local prequire = require('utils').prequire

local function prequire_plugin(plugin_name)
  local plugin_is_available, plugin = prequire(plugin_name)

  if not plugin_is_available then
    notify(
      'Plugin `' .. plugin_name .. '` does not exist!',
      vim.log.levels.ERROR,
      {
        title = 'Core',
      }
    )
  end

  return plugin_is_available, plugin
end

--- Perform common setup actions for connecting layer with user configuration.
---@param plugin_name 
---@param config_relative_path (string) If only layer name is given, plugin_name will be used
-- instead assuming config is nested in this layer under the same name as
-- plugin_name.
---@example
-- -- Config is in `Integrations.toggleterm`.
-- simple_plugin_setup('toggleterm', 'Integrations')
--
-- -- Take config without changes: `Navigation.other`.
-- simple_plugin_setup('other-nvim', 'Navigation.other')
---@return
local function simple_plugin_setup(plugin_name, config_relative_path)
  local plugin_is_available, plugin = prequire_plugin(plugin_name)
  if not plugin_is_available then
    return
  end

  -- Finding first segment. It must be a layer.
  local segment_end = string.find(config_relative_path, "%.")

  ---  Only layer name was given.
  -- Assuming plugin_name and config_name for this plugin are the same.
  if not segment_end then
    local layer = config_relative_path

    config_relative_path = layer ..'.'.. plugin_name
  end

  local config_path = 'config.' .. (config_relative_path)
  local config_is_available, config = pcall(require, config_path)
  if not config_is_available then
    config = {}
    notify(
      'Config for plugin `' .. plugin_name .. '` on path `' .. config_path .. '` does not exist!\nReverting to default configuration.',
      vim.log.levels.WARN,
      {
        title = 'Core',
      }
    )
  end

  plugin.setup(config)

  return plugin_is_available, plugin
end


--- Set theme with rollback mechanism: colorscheme -> backup  -> fallback.
---@param colorscheme_name (string) Preferred colorscheme.
---@param backup_colorscheme_name (string) Custom theme from stable plugin.
---@param fallback_colorscheme_name (string) Theme embedded into the vim.
local function load_coloscheme(colorscheme_name, backup_colorscheme_name, fallback_colorscheme_name)
  local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme_name)

  if status_ok then
    return
  end

  notify(
    'Colorscheme ' .. colorscheme_name .. ' not found!\nSetting backup colorscheme!',
    vim.log.levels.WARNING,
    { title = 'Colorscheme' }
  )

  local backup_status_ok, _ = pcall(
    vim.cmd,
    'colorscheme ' .. backup_colorscheme_name
  )
  if backup_status_ok then
    return
  end

  notify(
    'Backup colorscheme ' .. backup_colorscheme_name .. ' not found!\nSetting default backup colorscheme!',
    vim.log.levels.WARNING,
    { title = 'Colorscheme' }
  )

  local fallback_status_ok, _ = pcall(
    vim.cmd,
    'colorscheme ' .. fallback_colorscheme_name
  )
  if fallback_status_ok then
    return
  end

  notify(
    'Fallback colorscheme ' .. fallback_colorscheme_name .. ' not found!',
    vim.log.levels.ERROR,
    { title = 'Colorscheme' }
  )
end

return {
  prequire_plugin = prequire_plugin,
  simple_plugin_setup = simple_plugin_setup,
  load_coloscheme = load_coloscheme,
}
