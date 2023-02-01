-- See [second proposal](https://github.com/ggandor/leap.nvim/discussions/41):
-- abcd|                    |bcde
-- ████e  ←  Zab    zde  →  █████    (this might also be the desired behavior for Visual `s` - see below)
-- ab██e  ←  Xab    xde  →  ███de
local keymappings = {
  z = { '<Plug>(leap-forward-to)', 'Leap forward to' },
  Z = { '<Plug>(leap-backward-to)', 'Leap backward to' },

  -- 'x' for exclusive.
  x = { '<Plug>(leap-forward-till)', 'Leap forward till' },
  X = { '<Plug>(leap-backward-till)', 'Leap backward till' },
}

return {
  o = keymappings,
  x = keymappings,
}
