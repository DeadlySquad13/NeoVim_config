return {
  'sindrets/diffview.nvim',

  event = "VeryLazy",

  dependencies = 'nvim-lua/plenary.nvim',

  opts = require('ds_omega.config.Git.diffview.settings'),
}
