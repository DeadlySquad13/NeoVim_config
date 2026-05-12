local M = {}

M.keymappings = require('ds_omega.config.Navigation.aerojump.keymappings')
-- `apply_plugin_keymappings` will not accept non-mode keys in a keymappings
-- table.
M.search_keymappings = M.keymappings.search
M.keymappings.search = nil

return {
  'ripxorip/aerojump.nvim',

  build = ':UpdateRemotePlugins',

  keys = to_lazy_keys(M.keymappings),

  config = function(_, opts)
    local ds_omega_utils_is_available = prequire('ds_omega.ds_omega_utils')

    if not ds_omega_utils_is_available then
      return
    end

    local ds_omega_utils = require('ds_omega.ds_omega_utils')
    
    ds_omega_utils.apply_plugin_keymappings(M.keymappings)

    local setters = require('ds_omega.utils.setters')

    setters.set_global_variables({ keymaps = M.search_keymappings }, 'aerojump')
  end,
}
