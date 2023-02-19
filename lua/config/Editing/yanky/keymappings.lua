local put_mappings = {
  p = { '<Plug>(YankyPutAfter)', 'Put after' },
  P = { '<Plug>(YankyPutBefore)', 'Put before' },
  gp = { '<Plug>(YankyGPutAfter)', 'G put after' },
  gP = { '<Plug>(YankyGPutBefore)', 'G put before' },
}

return {
  n = vim.tbl_extend('error', put_mappings, {
    ['<C-n>'] = { '<Plug>(YankyCycleForward)', 'Cycle forward yank history' },
    ['<C-p>'] = { '<Plug>(YankyCycleBackward)', 'Cycle backward yank history' },
  }),

  x = put_mappings,
}
