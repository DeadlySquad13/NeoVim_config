-- Lua api is available for these actions.
return {
  n = {
    ['<Leader>z'] = {
      name = 'TrueZen',

      n = { '<Cmd>TZNarrow<Cr>', 'Narrow true-zen mode' },
      f = { '<Cmd>TZFocus<Cr>', 'Focus true-zen mode' },
      m = { '<Cmd>TZMinimalist<Cr>', 'Minimalist true-zen mode' },
      a = { '<Cmd>TZAtaraxis<Cr>', 'Ataraxis true-zen mode' },
    }
  },
  -- Using colon as marks have to be set.
  x = {
    -- TODO: Add variants that select some node and narrow it. For example,
    -- function.
    ['<Leader>zn'] = { ":'<,'>TZNarrow<Cr>", 'Narrow true-zen mode' }
  }
}
