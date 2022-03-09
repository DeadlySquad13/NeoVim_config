local nvim_autopairs = require('nvim-autopairs')
nvim_autopairs.setup {
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey='Comment'
  },
  disable_filetype = { "TelescopePrompt" },
    -- disable when recording or executing a macro
  disable_in_macro = false,
   -- disable when insert after visual block mode
  disable_in_visualblock = false,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
  enable_moveright = true,
    -- add bracket pairs after quote
  enable_afterquote = true,
    --- check bracket in same line
  enable_check_bracket_line = true,
  check_ts = false,
    -- map the <BS> key
  map_bs = true,
    -- Map the <C-h> key to delete a pair
  map_c_h = true,
   -- map <c-w> to delete a pair if possible
  map_c_w = false,
}
