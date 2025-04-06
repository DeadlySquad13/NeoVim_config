local M = {}
M.keymappings = require('ds_omega.config.Editing.treesj.keymappings')

return {
    'Wansmer/treesj',

    dependencies = 'nvim-treesitter',

    keys = to_lazy_keys(M.keymappings),

    opts = require('ds_omega.config.Editing.treesj.settings'),

    config = function (_, opts)
        local prequire = require('ds_omega.utils').prequire

        local treesj_is_available, treesj = prequire('treesj')

        if not treesj_is_available or not treesj then
          return
        end

        treesj.setup(opts)

        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
    end,
}
