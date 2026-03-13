-- Some recommended exclusions. you can use `:lua print(vim.bo.filetype)` to
-- get the filetype string of the current buffer.
local excluded_filetypes = {
    -- this one is especially useful if you use neovim as a commit message editor
    -- "gitcommit",
    -- Quickfixlist changer.
    "replacer",
    -- most of these are usually set to non-modifiable, which prevents autosaving
    -- by default, but it doesn't hurt to be extra safe.
    "NvimTree",
    "Outline",
    "TelescopePrompt",
    "alpha",
    "dashboard",
    "lazygit",
    "neo-tree",
    "oil",
    "prompt",
    "toggleterm",
}

return {
    trigger_events = {                                 -- See :h events
        immediate_save = { "BufLeave", "FocusLost" },  -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_deferred_save = { "InsertEnter" },      -- vim events that cancel a pending deferred save
    },
    condition = function(buf)
        local filetype = vim.fn.getbufvar(buf, "&filetype")

        -- Don't save for these file types.
        return not vim.list_contains(
            excluded_filetypes,
            filetype
        )
    end,
    callbacks = {
        -- Run when enabling auto-save.
        enabling = nil,
        -- Run when disabling auto-save.
        disabling = nil,
        -- Run before checking `condition`.
        before_asserting_save = nil,
    },
}
