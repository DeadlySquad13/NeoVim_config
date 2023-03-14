return {
  'Wansmer/treesj',
  
  dependencies = 'nvim-treesitter',

  opts = require('config.Editing.treesj.settings'),

  config = function(_, opts)
    require('treesj').setup(opts)

    local keymappings = require('config.Editing.treesj.keymappings')
    require('ds_omega.utils').apply_plugin_keymappings(keymappings)
  end,
}
