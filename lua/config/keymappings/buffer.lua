return {
  name = 'Buffer',

  -- Deletes buffer without closing vim if it was in the only window.
  d = { ':Bdelete<cr>', 'Delete' },

  ---@see{the lua api at @link{https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline.lua}}
  --p = { function() bufferline.pick_buffer() end, 'Pick' },
  p = { '<cmd>BufferLinePick<cr>', 'Pick' },
  n = { 'bn', 'Next' },
}
