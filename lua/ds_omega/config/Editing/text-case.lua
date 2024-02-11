return {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true, -- Once it will be better then abolish disable as we want to work with substitute command interactively from beginning.

    opts = {
        -- substitude_command_name = 'S', -- Once it will be better then abolish (https://github.com/johmsalas/text-case.nvim/issues/160)
    },

    keys = {
        "ga", -- Default invocation prefix
        { "ga.", "<Cmd>TextCaseOpenTelescope<Cr>", mode = { "n", "v" }, desc = "Telescope" },
    },

    config = function(_, opts)
        require("textcase").setup(opts)
        require("telescope").load_extension("textcase")
    end,
}
