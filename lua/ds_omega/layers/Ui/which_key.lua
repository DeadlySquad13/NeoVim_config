local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local which_key_is_available = simple_plugin_setup('which-key', 'Ui.which_key')
if not which_key_is_available then
  return
end

local apply_keymappings = require('config.Ui.which_key.utils').apply_keymappings

local mappings = require('config.keymappings')

for _, mode in ipairs({ 'n', 'x', 'i', 'c' }) do
    apply_keymappings(mode, mappings[mode])
end

