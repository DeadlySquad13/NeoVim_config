local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local which_key_is_available = simple_plugin_setup('which-key', 'Ui.which_key')
if not which_key_is_available then
  return
end

local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

local mappings = require('ds_omega.config.keymappings')

for mode, mode_mappings in pairs(mappings) do
    apply_keymappings(mode, mode_mappings)
end

