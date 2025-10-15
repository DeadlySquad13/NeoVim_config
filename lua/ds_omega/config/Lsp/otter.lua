---@type LazySpec
return {
    -- For lsp features in code cells / embedded code
    'jmbuhr/otter.nvim',
    dev = false,
    event = require("ds_omega.constants.events").jupyter_notebooks,
    dependencies = {
        {
            'neovim/nvim-lspconfig',
            'nvim-treesitter/nvim-treesitter',
            'hrsh7th/nvim-cmp',
        },
    },
    opts = {
        lsp = {
            hover = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            },
        },
        buffers = {
            set_filetype = true,
            write_to_disk = false,
        },
        handle_leading_whitespace = true,
    },
}
