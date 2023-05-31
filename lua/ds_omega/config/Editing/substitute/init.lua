return {
  'gbprod/substitute.nvim',

  opts = require('ds_omega.config.Editing.substitute.settings'),

  config = function(_, opts)
    require('substitute').setup(opts)
    
    local keymappings = require('ds_omega.config.Editing.substitute.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)
  end,
}
