return {
    'folke/which-key.nvim',
    enabled = true,
    version = "2.x",
    lazy = false,
    -- Since which-key handles all your keymaps,
    -- its recommended to load it before other plugins.
    priority = 10000,

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 600
    end,

    opts = require('ds_omega.config.Ui.which_key.settings'),
    config = function(_, opts)
        require('which-key').setup(opts)

        local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

        local mappings = require('ds_omega.config.keymappings')

        for mode, mode_mappings in pairs(mappings) do
            apply_keymappings(mode, mode_mappings)
        end
    end
}
