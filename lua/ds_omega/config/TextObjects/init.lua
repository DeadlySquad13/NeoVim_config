return {
  {
      'kana/vim-textobj-user',
  },
  {
      'pianohacker/vim-textobj-indented-paragraph',
      event = require('ds_omega.constants.events').lazy_file,
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'kana/vim-textobj-indent',
      event = require('ds_omega.constants.events').lazy_file,
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'GCBallesteros/vim-textobj-hydrogen',
      event = require('ds_omega.constants.events').lazy_file,
      dependencies = {
        'vim-textobj-user'
      },
  },
  {
      'anuvyklack/vim-smartword',
      event = require('ds_omega.constants.events').lazy_file,
  },
  -- Has it's config in treesitter.
  {
      'nvim-treesitter/nvim-treesitter-textobjects',

      event = require('ds_omega.constants.events').lazy_file,

      dependencies = {
        'nvim-treesitter'
      },
  }
}
