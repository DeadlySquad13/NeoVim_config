---@class Module
local Editing = {}

Editing.plugins = {
  ['autopairs'] = {
    'windwp/nvim-autopairs',
  },

  ['comments'] = {
    'numToStr/Comment.nvim',
    event = 'VimEnter',

    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      --event = 'VimEnter',

      requires = 'nvim-treesitter/nvim-treesitter',
    },
  },

  ['surround'] = {
    'kylechui/nvim-surround',
  },

  ['multi_cursors'] = {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  ['abolish'] = {
    'tpope/vim-abolish',
  },

  ['tabout'] = {
    'abecodes/tabout.nvim',

    -- Should be after mappings to overwrite the trigger key ('tab').
    after = {
      'which-key.nvim',
      'tinykeymap_vim',

      'nvim-treesitter', -- Needs utils from treesitter.
    },
  },

  ['easy_align'] = {
    'junegunn/vim-easy-align'
  },

  ['splitjoin'] = {
    'AndrewRadev/splitjoin.vim'
  },
}

Editing.configs = {
  ['autopairs'] = function()
    require('ds_omega.layers.Editing.autopairs')
  end,

  ['comments'] = function()
    require('ds_omega.layers.Editing.comments')
  end,

  ['surround'] = function()
    require('ds_omega.layers.Editing.surround')
  end,

  ['multi_cursors'] = function()
    require('ds_omega.layers.Editing.multi_cursors')
  end,

  ['abolish'] = function()
    require('ds_omega.layers.Editing.abolish')
  end,

  ['tabout'] = function()
    require('ds_omega.layers.Editing.tabout')
  end,

  ['easy_align'] = function()
    require('ds_omega.layers.Editing.easy_align')
  end,

  ['splitjoin'] = function()
    require('ds_omega.layers.Editing.splitjoin')
  end,
}

return Editing
