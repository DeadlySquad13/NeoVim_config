return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',

  dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',

      lazy = true,

      dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  opts = require('ds_omega.config.Editing.comments.settings'),

  config = function(_, opts)
    require('Comment').setup(opts)
    require('ds_omega.config.Editing.comments.custom_comments')
  end,
}
