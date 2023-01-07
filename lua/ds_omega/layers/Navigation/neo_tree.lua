local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define(
  'DiagnosticSignError',
  { text = ' ', texthl = 'DiagnosticSignError' }
)
vim.fn.sign_define(
  'DiagnosticSignWarn',
  { text = ' ', texthl = 'DiagnosticSignWarn' }
)
vim.fn.sign_define(
  'DiagnosticSignInfo',
  { text = ' ', texthl = 'DiagnosticSignInfo' }
)
vim.fn.sign_define(
  'DiagnosticSignHint',
  { text = '', texthl = 'DiagnosticSignHint' }
)

simple_plugin_setup('neo-tree', 'Navigation.neo_tree')
