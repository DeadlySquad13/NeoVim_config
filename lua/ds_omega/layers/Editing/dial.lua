local utils = require('ds_omega.utils')

local settings, keymappings = utils.get_plugin_config('dial', 'Editing')

local prequire = require('utils').prequire

local config_is_available, config = prequire('dial.config')

if not config_is_available then
  return 
end

config.augends:register_group(settings)

if keymappings then
  utils.apply_plugin_keymappings(keymappings)
end
