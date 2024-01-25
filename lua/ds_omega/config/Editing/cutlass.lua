return {
  'gbprod/cutlass.nvim',

  opts = {
      cut_key = 'n',
      exclude = {
          -- Surround mappings.
          'ns', 'nS',
          'vs', 'vS',
          -- Change mappings.
          -- 'nc', 'vc',
      },
  },

  config = true,
}
