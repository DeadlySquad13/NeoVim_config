return {
  'DeadlySquad13/other.nvim',
  branch = 'create-file',

  opts = require('ds_omega.config.Navigation.other.settings'),

  config = function(_, opts)
    require('other-nvim').setup(opts)

    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    if not ds_omega_utils_is_available then
      return
    end
    local keymappings = require('ds_omega.config.Navigation.other.keymappings')
    ds_omega_utils.apply_plugin_keymappings(keymappings)
  end,
}
