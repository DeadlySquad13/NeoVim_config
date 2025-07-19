---@type LazySpec
return {
    -- "hedyhli/markdown-toc.nvim",
    "DeadlySquad13/markdown-toc.nvim",
    ft = "markdown",  -- Lazy load on markdown filetype
    cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command

    opts = {
        -- Set auto_update=true to use the following defaults.
        -- Set to false to disable completely.
        -- Fields events and pattern are used unprocessed for creating autocmds.
        auto_update = {
            enabled = true,
            -- This allows the ToC to be refreshed silently on save for any markdown file.
            -- The refresh operation uses `Mtoc update` and does NOT create the ToC if
            -- it does not exist.
            -- Default: BufWritePre. But it causes additional lags when used
            -- with other formatters on auto-save. And it polutes undo history
            -- https://github.com/hedyhli/markdown-toc.nvim/issues/6
            --
            -- Thus had to rewrite autocmd to run only when finish editing buffer, going out of window or closing vim at all.
            -- It required additional `update` after mtoc in the source code.
            -- Could have potentially overwritten it without forking by just
            -- creating autocmd in config instead of using builtin. But, unfortunately,
            -- setting `enabled = false` in config doesn't disable autocmd (we
            -- would need to hack it with wrong pattern, for instance). And it would
            -- break other functionality of a plugin like `mtoc.update_config`.
            events = {
                 -- Tried BufWinLeave to trigger only when the window with
                -- buffer is not visible to minimize dragging on a screen. But
                -- it didn't worked.
                "BufLeave", -- For :bd and when changing window.
                "ExitPre", -- For :q and :wq.
                "FocusLost", -- When NeoVim looses focus, for instance, when changing tmux window or OS window.
                "VimSuspend", -- Before NeoVim enters suspend state. Doesn't work...
            },
            pattern = "*.{md,mdown,mkd,mkdn,markdown,mdwn}",
        },
    },

    config = true,
}
