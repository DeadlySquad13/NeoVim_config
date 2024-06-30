return {
  'ripxorip/aerojump.nvim',

  build = ':UpdateRemotePlugins',

  config = function(_, opts)
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
    if not ds_omega_utils_is_available then
      return
    end

    local keymappings = require('ds_omega.config.Navigation.aerojump.keymappings')
    -- `apply_plugin_keymappings` will not accept non-mode keys in a keymappings
    -- table.
    local search_keymappings = keymappings.search
    keymappings.search = nil

    ds_omega_utils.apply_plugin_keymappings(keymappings)

    local setters = require('ds_omega.utils.setters')

    setters.set_global_variables({ keymaps = search_keymappings }, 'aerojump')
  end,
}
