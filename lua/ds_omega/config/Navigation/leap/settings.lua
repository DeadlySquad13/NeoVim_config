return {
  max_phase_one_targets = nil,
  highlight_unlabeled_phase_one_targets = true,
  max_highlighted_traversal_targets = 10,
  case_sensitive = true,
  equivalence_classes = { ' \t\r\n' },
  substitute_chars = { ['\r'] = '¬' },
  safe_labels = {
    's', 'f', 'n', 'u', 't', '/',
    'S', 'F', 'N', 'L', 'H', 'M', 'U', 'G', 'T', '?', 'Z',
  },
  labels ={
    't', 'a', 'n', 'e', 's', 'i', 'r', 'h',
    'd', 'u', 'l', 'o', 'c', 'y', 'x', 'k',
    'p', '.', 'm', 'q', 'f', '"', 'w', '\'',
    'T', 'A', 'N', 'E', 'S', 'I', 'R', 'H',
    'D', 'U', 'L', 'O', 'C', 'Y', 'X', 'K',
    'P', ':', 'M', 'Q', 'F', '[', 'W', ']',
  },
  --[[ labels = {
    's', 'f',
    'j', 'k', 'l', 'h', 'o', 'd', 'w', 'e', 'm',
    'v', 'r', 'c', 'x', '/', 'z',
    'S', 'F',
    'J', 'K', 'L', 'H', 'O', 'D', 'W', 'E', 'M',
    'V', 'R', 'C', 'X', '?', 'Z',
  }, ]]
  special_keys = {
    repeat_search = '<enter>',
    next_phase_one_target = '<enter>',
    next_target = {'<enter>', ';'},
    prev_target = {'<tab>', ','},
    next_group = '<space>',
    prev_group = '<tab>',
    multi_accept = '<enter>',
    multi_revert = '<backspace>',
  },
}
