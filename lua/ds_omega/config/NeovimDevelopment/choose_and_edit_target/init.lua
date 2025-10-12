local M = {}

M.keymappings = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.keymappings')
M.settings = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.settings')

local choose_and_edit_configs = require('ds_omega.modules.choose_and_edit_configs')

M.cmds = vim.tbl_map(function(target_group)
    return choose_and_edit_configs.generate_command_name(target_group)
end, M.settings)

return {
    -- Doesn't work on Windows…
    -- name = "choose_and_edit_configs",
    -- dir = "ds_omega.modules.choose_and_edit_configs",
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/choose_and_edit_configs",

    cmd = M.cmds,
    keys = to_lazy_keys(M.keymappings),

    dependencies = { 'stevearc/dressing.nvim' },

    opts = M.settings,

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local choose_and_edit_configs_is_available = prequire('ds_omega.modules.choose_and_edit_configs')

        if not choose_and_edit_configs_is_available then
            return
        end
        local choose_and_edit_configs = require('ds_omega.modules.choose_and_edit_configs')

        -- REFACTOR: Into separate modules. NeoVim is in NeovimDevelopment
        -- layer, other - in Integrations.
        choose_and_edit_configs.setup(opts)

        local ds_omega_utils_is_available = prequire('ds_omega.ds_omega_utils')
        if not ds_omega_utils_is_available then
            return
        end
        local ds_omega_utils = require('ds_omega.ds_omega_utils')

        ds_omega_utils.apply_plugin_keymappings(M.keymappings)
    end,
}
