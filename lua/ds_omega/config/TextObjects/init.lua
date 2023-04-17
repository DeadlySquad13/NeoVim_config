return {
  {
      'kana/vim-textobj-user',
  },
  {
      'coderifous/textobj-word-column.vim',
      -- event = 'VimEnter',
     dependencies = {
       'vim-textobj-user',
     },
  },
  {
      'pianohacker/vim-textobj-indented-paragraph',
      -- event = 'VimEnter',
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'kana/vim-textobj-indent',
      -- event = 'VimEnter',
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'GCBallesteros/vim-textobj-hydrogen',
      -- event = 'VimEnter',
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'anuvyklack/vim-smartword',
      -- event = 'VimEnter',
  },
  -- Has it's config in treesitter.
  {
      'nvim-treesitter/nvim-treesitter-textobjects',

      dependencies = {
        'nvim-treesitter'
      },
  }
}
