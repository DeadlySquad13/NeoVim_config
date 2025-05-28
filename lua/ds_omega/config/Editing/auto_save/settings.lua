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
            {
                -- Quickfixlist changer.
                "replacer",
            },
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
