local utils = require('ds_omega.utils')

local _, keymappings = utils.get_plugin_config('genghis', 'Commands')

if keymappings then
  utils.apply_plugin_keymappings(keymappings)
end
