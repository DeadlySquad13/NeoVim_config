---@type LazySpec
return {
    'mistweaverco/kulala.nvim',
    -- Can't be omitted.
    opts = {
        global_keymaps = true,
        global_keymaps_prefix = "<leader>R",
        kulala_keymaps_prefix = "",
    },


    ft = { "http", "rest" },
}
