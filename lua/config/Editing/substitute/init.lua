return {
  'gbprod/substitute.nvim',

  opts = require('config.Editing.substitute.settings'),

  config = function(_, opts)
    require('substitute').setup(opts)
    
    keymappings = require('config.Editing.substitute.keymappings')
    require('ds_omega.utils').apply_plugin_keymappings(keymappings)
  end,
}
