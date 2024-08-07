return {
  'okuuva/auto-save.nvim',

  opts = require('ds_omega.config.Editing.auto_save.settings'),

  config = function(_, opts)
    local keymappings = require('ds_omega.config.Editing.auto_save.keymappings')
    require('ds_omega.ds_omega_utils').apply_plugin_keymappings(keymappings)

    require('auto-save').setup(opts)
  end,
}
