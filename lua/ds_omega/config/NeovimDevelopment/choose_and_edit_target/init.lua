local M = {}

M.keymappings = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.keymappings')

return {
    -- Doesn't work on Windows…
    -- name = "choose_and_edit_configs",
    -- dir = "ds_omega.modules.choose_and_edit_configs",
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/choose_and_edit_configs",

    cmd = 'ChooseAndEditConfigs',
    keys = to_lazy_keys(M.keymappings),

    dependencies = { 'stevearc/dressing.nvim' },

    opts = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.settings'),

    config = function(_, opts)
        require('ds_omega.modules.choose_and_edit_configs').setup(opts)

        local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
        if not ds_omega_utils_is_available or not ds_omega_utils then
            return
        end

        ds_omega_utils.apply_plugin_keymappings(M.keymappings)
    end,
}
