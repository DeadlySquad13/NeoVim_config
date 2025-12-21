local M = {}
M.keymappings = require('ds_omega.config.Editing.text-case.keymappings')

---@type LazySpec
return {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true, -- Once it will be better then abolish disable as we want to work with substitute command interactively from beginning.

    opts = {
        default_keymappings_enabled = false, -- We use mainly abolish coerce, this plugin is just for a few methods.
        -- substitude_command_name = 'S', -- Once it will be better then abolish (https://github.com/johmsalas/text-case.nvim/issues/160)
    },

    -- Didn't map them as used seldom and transitive_catalizator is already
    -- taken by abolish.
    cmd = {
        "TextCaseOpenTelescopeQuickChange",
        "TextCaseOpenTelescopeLSPChange",
    },
    keys = to_lazy_keys(M.keymappings),

    config = function(_, opts)
        require("textcase").setup(opts)
        require("telescope").load_extension("textcase")
    end,
}
