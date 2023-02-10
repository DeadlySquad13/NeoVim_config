return {
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match.
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
  disable_filetype = { 'TelescopePrompt' },
  -- Disable when recording or executing a macro.
  disable_in_macro = true,
  -- Disable when insert after visual block mode.
  disable_in_visualblock = true,
  ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
  enable_moveright = true,
  -- Add bracket pairs after quote.
  enable_afterquote = true,
  -- Check bracket in same line.
  enable_check_bracket_line = true,
  check_ts = false,
  -- Map the <BS> key.
  map_bs = true,
  -- Map the i_ctrl-h key to delete a pair.
  map_c_h = true,
  -- Map i_ctrl-w to delete a pair if possible.
  map_c_w = true,
}
