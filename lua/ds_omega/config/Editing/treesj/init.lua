return {
  'Wansmer/treesj',
  
  dependencies = 'nvim-treesitter',

  opts = require('ds_omega.config.Editing.treesj.settings'),

  config = function(_, opts)
    require('treesj').setup(opts)

    local keymappings = require('ds_omega.config.Editing.treesj.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)
  end,
}
