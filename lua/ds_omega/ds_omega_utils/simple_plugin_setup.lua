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
  local plugin_is_available, plugin = require('ds_omega.utils.prequire_plugin')(plugin_name)
  if not plugin_is_available then
    return
  end

  local settings, keymappings = require('ds_omega.utils.get_plugin_config')(plugin_name, config_relative_path)
  plugin.setup(settings)

  if keymappings then
    require('ds_omega.utils.apply_plugin_keymappings')(keymappings)
  end

  return plugin_is_available, plugin
end

return simple_plugin_setup
