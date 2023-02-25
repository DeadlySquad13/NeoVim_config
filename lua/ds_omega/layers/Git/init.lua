---@class Module
local Git = {}

Git.plugins = {
    ['fugitive'] = {
        'tpope/vim-fugitive',
    },

    ['neogit'] = {
      'TimUntersberger/neogit',

      requires = 'nvim-lua/plenary.nvim',
    },

    ['diffview'] = {
      'sindrets/diffview.nvim',

      requires = 'nvim-lua/plenary.nvim',
    },
}

Git.configs = {
    ['fugitive'] = function()
      require('ds_omega.layers.Git.fugitive')
    end,

    ['neogit'] = function()
      require('ds_omega.layers.Git.neogit')
    end,

    ['diffview'] = function()
      require('ds_omega.layers.Git.diffview')
    end,
}

return Git
