return {
  'pocco81/auto-save.nvim',

  opts = require('config.Editing.auto_save.settings'),

  config = function(_, opts)
    keymappings = require('config.Editing.auto_save.keymappings'),
    require('ds_omega.utils').apply_plugin_keymappings(keymappings)

    require('auto-save').setup(opts)
  end,
}
