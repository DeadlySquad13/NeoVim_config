return {
  'mg979/vim-visual-multi',

  branch = 'master',

  config = function()
    keymappings = require('config.Editing.visual_multi.keymappings')

    if keymappings then
      vim.g.VM_maps = keymappings
    end
  end,
}
