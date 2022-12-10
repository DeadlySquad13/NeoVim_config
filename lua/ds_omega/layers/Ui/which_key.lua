local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local which_key_is_available = simple_plugin_setup('which-key', 'which_key')
if not which_key_is_available then
  return
end

local apply_keymappings = require('config.which_key.utils').apply_keymappings

local mappings = require('config.keymappings')

apply_keymappings(mappings.n, 'n')
apply_keymappings(mappings.x, 'x')
apply_keymappings(mappings.i, 'i')
apply_keymappings(mappings.c, 'c')

