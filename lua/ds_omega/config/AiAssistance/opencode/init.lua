local M = {}

M.opts = require('ds_omega.config.AiAssistance.opencode.settings')

M.keymappings = require('ds_omega.config.AiAssistance.opencode.keymappings')

---@type LazySpec
return {
    "sudo-tee/opencode.nvim",

    lazy = true,

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                anti_conceal = { enabled = false },
                file_types = { 'markdown', 'opencode_output' },
            },
            ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
        },
        -- Optional, for file mentions and commands completion, pick only one
        -- 'saghen/blink.cmp',
        'hrsh7th/nvim-cmp',

        -- Optional, for file mentions picker, pick only one
        -- 'folke/snacks.nvim',
        'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        -- 'nvim_mini/mini.nvim',
    },

    opts = M.opts,

    keys = to_lazy_keys(M.keymappings),

    cmd = { "Opencode", "OpencodeDsOmega" },

    config = function(_, opts)
        local opencode_is_available = prequire('opencode')

        if not opencode_is_available then
            return
        end

        local opencode = require('opencode')

        opencode.setup(opts)
        require('ds_omega.modules.opencode_launcher').setup()


        require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
    end,
}
