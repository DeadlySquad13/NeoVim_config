local M = {}

M.keymappings = require('ds_omega.config.Editing.substitute.keymappings')

return {
    'gbprod/substitute.nvim',

    opts = require('ds_omega.config.Editing.substitute.settings'),

    keys = to_lazy_keys(M.keymappings),

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local substitute_is_available, substitute = prequire('substitute')

        if not substitute_is_available or not substitute then
          return
        end

        substitute.setup(opts)

        -- Currently need it alongside `keys` because otherwise `s` is
        -- overwritten by which_key.
        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
    end,
}
