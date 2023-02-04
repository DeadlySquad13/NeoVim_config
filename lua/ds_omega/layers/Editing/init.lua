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

  ['treesj'] = {
    'Wansmer/treesj',

    requires = 'nvim-treesitter',
  },

  ['undo'] = {
    'debugloop/telescope-undo.nvim',

    requires = 'nvim-telescope/telescope.nvim',
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

  ['tabout'] = function()
    require('ds_omega.layers.Editing.tabout')
  end,

  ['treesj'] = function()
    require('ds_omega.layers.Editing.treesj')
  end,

  ['undo'] = function()
    require('ds_omega.layers.Editing.undo')
  end,
}

return Editing
