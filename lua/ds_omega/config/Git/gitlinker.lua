return {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
        { "<leader>gf", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Yank git link" },
        { "<leader>gx", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
}
