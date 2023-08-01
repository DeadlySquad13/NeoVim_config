return {
  'sindrets/diffview.nvim',

  dependencies = 'nvim-lua/plenary.nvim',

  opts = require('ds_omega.config.Git.diffview.settings'),

  config = true,
}
