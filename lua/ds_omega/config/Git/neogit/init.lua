return {
  'TimUntersberger/neogit',

  dependencies = 'nvim-lua/plenary.nvim',
  cmd = { "Neogit" },

  opts = require('ds_omega.config.Git.neogit.settings'),

  init = function()
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Git.neogit.keymappings'))
  end,


  config = function(_, opts)
    local neogit_is_available, neogit = require('ds_omega.ds_omega_utils').prequire_plugin('neogit')
    if not neogit_is_available then
      return
    end

    neogit.setup(opts)
  end,
}
