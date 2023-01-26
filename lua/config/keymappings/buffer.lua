return {
  name = 'Buffer',

  -- Deletes buffer without closing vim if it was in the only window.
  d = { '<Cmd>Bdelete<Cr>', 'Delete' },
  D = { '<Cmd>%bdelete|edit#<Cr>', 'Delete all buffer except for current one' },

  ---@see{the lua api at @link{https://github.com/akinsho/bufferline.nvim/blob/main/lua/bufferline.lua}}
  --p = { function() bufferline.pick_buffer() end, 'Pick' },
  p = { '<Cmd>BufferLinePick<Cr>', 'Pick' },
  n = { '<Cmd>bnext<Cr>', 'Next' },
}
