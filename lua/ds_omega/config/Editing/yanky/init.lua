local M = {}
M.keymappings = require('ds_omega.config.Editing.yanky.keymappings')

return {
    'gbprod/yanky.nvim',

    opts = require('ds_omega.config.Editing.yanky.settings'),

    keys = to_lazy_keys(M.keymappings),

    config = function(_, opts)
        require('yanky').setup(opts)

        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)

        local prequire = require('ds_omega.utils').prequire

        local telescope_is_available, telescope = prequire('telescope')

        if telescope_is_available then
            telescope.load_extension('yank_history')
        end
    end,
}
