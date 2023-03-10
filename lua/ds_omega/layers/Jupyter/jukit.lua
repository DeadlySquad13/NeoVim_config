local utils = require('ds_omega.utils')

local settings, keymappings = utils.get_plugin_config('jukit', 'Jupyter')

if settings then
  require('utils.setters').set_global_variables(settings)
end

if keymappings then
  utils.apply_plugin_keymappings(keymappings)
end
