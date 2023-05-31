return function()
  local pickers = require('ds_omega.config.Editing.yanky.picker')()

  return {
    system_clipboard = {
      -- I don't like when system clipboard is intermingled with vim.
      sync_with_ring = false,
    },

    -- I have it already configured separately via autocmd.
    -- TODO: Adopt it here instead?
    highlight = {
      on_put = false,
      on_yank = false,
    },

    -- I have yank assassin for that.
    -- TODO: Make assassin optional.
    preserve_cursor_position = {
      enabled = false,
    },

    picker = {
      telescope = pickers.telescope,
    },
  }
end
