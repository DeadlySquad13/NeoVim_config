return {
  'numToStr/Comment.nvim',
  -- event = 'VimEnter',

  dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      --event = 'VimEnter',

      dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  opts = require('ds_omega.config.Editing.comments.settings'),

  config = function(_, opts)
    require('Comment').setup(opts)
    require('ds_omega.config.Editing.comments.custom_comments')
  end,
}
