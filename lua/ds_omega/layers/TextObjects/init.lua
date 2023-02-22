---@class Module
local TextObjects = {}

TextObjects.plugins = {
  ['textobjects'] = {
    'kana/vim-textobj-user',
  },

  ['word_column'] = {
    'coderifous/textobj-word-column.vim',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['indented_paragraph'] = {
    'pianohacker/vim-textobj-indented-paragraph',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['indent'] = {
    'kana/vim-textobj-indent',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['hydrogen'] = {
    'GCBallesteros/vim-textobj-hydrogen',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['word'] = {
    'chaoren/vim-wordmotion',
    event = 'VimEnter',
    after = 'vim-textobj-user',
  },

  ['smart_word'] = {
    'anuvyklack/vim-smartword',
    event = 'VimEnter',
  },

  -- Has it's config in treesitter.
  ['treesitter'] = {
    'nvim-treesitter/nvim-treesitter-textobjects',

    requires = 'nvim-treesitter',
  }
}

TextObjects.configs = {
  ['smart_word'] = function()
    require('ds_omega.layers.TextObjects.smart_word')
  end,
}

return TextObjects
