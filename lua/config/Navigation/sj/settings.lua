local leap_settings = require('config.Navigation.leap.settings')

return {
  separator = ';', -- Character used to split the user input in <pattern> and <label> (can be empty).
  use_overlay = false, -- If true, apply an overlay to better identify labels and matches.
  labels = leap_settings.labels,
  relative_labels = true, -- if true, labels are ordered from the cursor position, 
  update_search_register = true, -- If true, update the search register with the last used pattern.
  -- Can be: current_line, visible_lines_above, visible_lines_below, visible_lines, buffer.
  search_scope = 'buffer', -- To align more with default / and ?

  keymaps = {
    prev_pattern = "<C-k>", -- Select the previous pattern while searching.
    next_pattern = "<C-j>", -- Select the next pattern while searching.

    send_to_qflist = "<C-q>", --- Send the search results to the quickfix list.
  }
}
