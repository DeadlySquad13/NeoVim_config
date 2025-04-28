local M = {}

M.keymappings = require('ds_omega.config.Workspace.replacer.keymappings')

return {
    'gabrielpoca/replacer.nvim',

    keys = to_lazy_keys(M.keymappings),

    opts = require('ds_omega.config.Workspace.replacer.settings'),

    config = function (_, opts)
        local prequire = require('ds_omega.utils').prequire

        local replacer_is_available, replacer = prequire('replacer')

        if not replacer_is_available or not replacer then
          return
        end

        -- Not sure opts work properly as they still are not properly
        -- recognized in keymappings. So I pass them explicitly in keymappings
        -- too.
        replacer.setup(opts)

        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
    end,
}
