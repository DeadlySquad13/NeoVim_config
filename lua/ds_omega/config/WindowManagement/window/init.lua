local M = {}

M.keymappings = require('ds_omega.config.WindowManagement.window.keymappings')

return {
    'yorickpeterse/nvim-window',

    keys = to_lazy_keys(M.keymappings),

    opts = require('ds_omega.config.WindowManagement.window.settings'),

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local nvim_window_is_available, nvim_window = prequire('nvim-window')

        if not nvim_window_is_available then
            return
        end

        nvim_window.setup(opts)

        local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

        if not ds_omega_utils_is_available then
            return
        end

        ds_omega_utils.apply_plugin_keymappings(M.keymappings)
    end,
}
