return {
    execution_message = {
        message = function() -- message to print on save
            return ('AutoSave at ' .. vim.fn.strftime('%H:%M:%S'))
        end,
        dim = 0.18,                                    -- dim the color of `message`
        cleaning_interval = 1250,                      -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    trigger_events = {                                 -- See :h events
        immediate_save = { "BufLeave", "FocusLost" },  -- vim events that trigger an immediate save
        defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
        cancel_defered_save = { "InsertEnter" },       -- vim events that cancel a pending deferred save
    },
    callbacks = {
        -- Run when enabling auto-save.
        enabling = nil,
        -- Run when disabling auto-save.
        disabling = nil,
        -- Run before checking `condition`.
        before_asserting_save = nil,
        before_saving = function()
            print('before'); vim.cmd.mkview()
        end,
        after_saving = function()
            print('after'); vim.cmd.loadview()
        end,
    }
}
