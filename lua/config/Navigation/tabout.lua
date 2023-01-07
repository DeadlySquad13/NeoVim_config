return {
  -- Key to trigger tabout, set to an empty string to disable.
  tabkey = '<Tab>',
  -- Key to trigger backwards tabout, set to an empty string to disable.
  backwards_tabkey = '<S-Tab>',
  -- Shift content if tab out is not possible.
  act_as_tab = true,
  -- Reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>).
  act_as_shift_tab = false,
  enable_backwards = true,
  -- If the tabkey is used in a completion pum.
  completion = true,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' },
  },
  --[[ If the cursor is at the beginning of a filled element it will rather tab
  --out than shift the content ]]
  ignore_beginning = true,
  -- Filetypes to ignore.
  exclude = {},
}
