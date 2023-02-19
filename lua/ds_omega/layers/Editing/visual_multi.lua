local utils = require('ds_omega.utils')

local settings, keymappings = utils.get_plugin_config('visual_multi', 'Editing')

if keymappings then
  vim.g.VM_maps = keymappings
end
