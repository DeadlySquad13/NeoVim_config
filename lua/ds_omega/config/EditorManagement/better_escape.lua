---@type LazySpec
return {
    "max397574/better-escape.nvim",

    ft = { "toggleterm" },
    event = { "TermEnter" },

    opts = {
        -- after `timeout` passes, you can press the escape key and the plugin will ignore it
        timeout = vim.o.timeoutlen,
        -- setting this to false removes all the default mappings
        default_mappings = false,
        -- INFO: Without this plugin double escape creates delay after going into
        -- normal mode in terminal.
        mappings = {
            t = {
                ['<Esc>'] = {
                    ['<Esc>'] = "<C-\\><C-n>",
                },
            },
        },
    },
}
