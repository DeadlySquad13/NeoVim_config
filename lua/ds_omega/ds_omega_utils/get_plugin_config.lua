---@param plugin_name 
---@param config_relative_path (string) If only layer name is given, plugin_name will be used
-- instead assuming config is nested in this layer under the same name as
-- plugin_name.
---@example
-- -- Config is in `Integrations.toggleterm`.
-- get_plugin_config('toggleterm', 'Integrations')
--
-- -- Take config without changes: `Navigation.other`.
-- get_plugin_config('other-nvim', 'Navigation.other')
local function get_plugin_config(plugin_name, config_relative_path)
  -- Finding first segment. It must be a layer.
  local segment_end = string.find(config_relative_path, "%.")

  ---  Only layer name was given.
  -- Assuming plugin_name and config_name for this plugin are the same.
  if not segment_end then
    local layer = config_relative_path

    config_relative_path = layer ..'.'.. plugin_name
  end

  local config_path = 'ds_omega.config.' .. (config_relative_path)
  local config_is_available, config = pcall(require, config_path)
  if not config_is_available then
    local message = 'Config for plugin `' .. plugin_name .. '` on path `' .. config_path .. '` does not exist or an error has occured while loading it!\nReverting to default configuration.'
    if LOG_INTO.notify then
      notify(message, {
        title = 'Core',
      })
    end

    log('Core')(message)

    return {}
  end

  local absolute_path = require('ds_omega.constants.env').NVIM_LUA_CONFIG ..'/'.. string.gsub(config_relative_path, '%.', '/')

  -- Whole object is settings.
  if not require('utils.file').is_lua_module(absolute_path) then
    return config
  end

  return config.settings, config.keymappings
end

return get_plugin_config
