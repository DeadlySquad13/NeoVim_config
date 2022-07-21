local fp = require('utils').fp
-- local prequire = require('utils').prequire

local function simple_plugin_setup(plugin_name, config_relative_path)
  local plugin = require(plugin_name)

  -- if not plugin_is_available then
  --   return
  -- end
  local config_path = 'config.' .. config_relative_path
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
  simple_plugin_setup = simple_plugin_setup,
  load_coloscheme = load_coloscheme,
}
