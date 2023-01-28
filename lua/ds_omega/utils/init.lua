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
  prequire_plugin = require('ds_omega.utils.prequire_plugin'),

  get_plugin_config = require('ds_omega.utils.get_plugin_config'),
  apply_plugin_keymappings = require('ds_omega.utils.apply_plugin_keymappings'),
  simple_plugin_setup = require('ds_omega.utils.simple_plugin_setup'),

  load_coloscheme = load_coloscheme,
}
