return {
  execution_message = {
    message = function() -- message to print on save
      return ('AutoSave at ' .. vim.fn.strftime('%H:%M:%S'))
    end,
    dim = 0.18, -- dim the color of `message`
    cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  },
  -- Vim events that trigger auto-save. See :h events.
  trigger_events = { 'BufLeave', 'FocusLost' },
  callbacks = {
    -- Run when enabling auto-save.
    enabling = nil,
    -- Run when disabling auto-save.
    disabling = nil,
    -- Run before checking `condition`.
    before_asserting_save = nil,
    before_saving = nil,
    after_saving = nil
  }
}
