local M = {}

M.keymappings = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.keymappings')

return {
    -- Doesn't work on Windows…
    -- name = "choose_and_edit_configs",
    -- dir = "ds_omega.modules.choose_and_edit_configs",
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/choose_and_edit_configs",

    cmd = { 'ChooseAndEditConfigs', 'ChooseAndEditUnixDotfiles' },
    keys = to_lazy_keys(M.keymappings),

    dependencies = { 'stevearc/dressing.nvim' },

    opts = require('ds_omega.config.NeovimDevelopment.choose_and_edit_target.settings'),

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local choose_and_edit_configs_is_available = prequire('ds_omega.modules.choose_and_edit_configs')

        if not choose_and_edit_configs_is_available then
          return
        end
        local choose_and_edit_configs = require('ds_omega.modules.choose_and_edit_configs')

        -- REFACTOR: Into separate modules. NeoVim is in NeovimDevelopment
        -- layer, other - in Integrations.
        choose_and_edit_configs.setup_neovim(opts.neovim())
        choose_and_edit_configs.setup_unix_dotfiles(opts.unix_dotfiles())
        choose_and_edit_configs.setup_scripts(opts.scripts())
        choose_and_edit_configs.setup_bookmarked_locations(opts.bookmarked_locations())
        choose_and_edit_configs.setup_all(opts.all())

        local ds_omega_utils_is_available = prequire('ds_omega.ds_omega_utils')
        if not ds_omega_utils_is_available then
            return
        end
        local ds_omega_utils = require('ds_omega.ds_omega_utils')

        ds_omega_utils.apply_plugin_keymappings(M.keymappings)
    end,
}
