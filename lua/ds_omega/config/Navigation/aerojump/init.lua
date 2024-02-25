-- TODO: Make it work!
return {
  'ripxorip/aerojump.nvim',

  opts = require('ds_omega.config.Navigation.aerojump.settings'),

  build = ':UpdateRemotePlugins',

  config = function(_, opts)
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Navigation.sj.keymappings'))

    require('sj').setup(opts)
  end,
}
