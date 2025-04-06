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

    -- Text object corresponding to last put text. Especially useful with Lsp
    -- because builtin NeoVim put marks are sometimes overriden.
    textobj = {
      enabled = true,
    },

    -- I use YankAssassin for that because it's easier to integrate with other
    -- mappings.
    preserve_cursor_position = {
      enabled = false,
    },

    picker = {
      telescope = pickers.telescope,
    },
  }
end
