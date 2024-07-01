return {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        -- to show diff splits and open commits in browser
        -- "tpope/vim-fugitive",
        -- to open commits in browser with fugitive
        -- "tpope/vim-rhubarb",
        -- optional: to replace the diff from fugitive with diffview.nvim
        -- (fugitive is still needed to open in browser)
        "sindrets/diffview.nvim",
        -- to open commits in browser
        "linrongbin16/gitlinker.nvim",
    },
    cmd = { "AdvancedGitSearch" },

    -- Options for telescope extension. Loaded in Telescope, see
    -- 'ds_omega.config.Navigation.telescope'.
    opts = {
        -- Browse command to open commits in browser. Default fugitive GBrowse.
        -- {commit_hash} is the placeholder for the commit hash.
        -- browse_command = "GBrowse {commit_hash}",
        browse_command = "GitLink! rev={commit_hash}",

        ---@type "fugitive" | "diffview" Plugin to show diff.
        diff_plugin = "diffview",
        -- customize git in previewer
        -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
        git_flags = {},
        -- customize git diff in previewer
        -- e.g. flags such as { "--raw" }
        git_diff_flags = {},
        -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
        show_builtin_git_pickers = true,
        entry_default_author_or_date = "author", -- one of "author" or "date"
        keymaps = {
            -- following keymaps can be overridden
            toggle_date_author = "<C-w>",
            open_commit_in_browser = "<C-o>",
            copy_commit_hash = "<C-f>",
            show_entire_commit = "<C-e>",
        },
    },

    init = function()
        local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

        if not ds_omega_utils_is_available then
            return
        end

        ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Git.advanced_git_search.keymappings'))
    end,

    config = function()
        local prequire = require('ds_omega.utils').prequire

        local telescope_is_available, telescope = prequire('telescope')

        if not telescope_is_available then
            return
        end

        telescope.load_extension('advanced_git_search')
    end,
}
