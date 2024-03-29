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
    ['visual_multi'] = {
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
            -- 'tinykeymap_vim',

            'nvim-treesitter', -- Needs utils from treesitter.
        },
    },
    ['easy_align'] = {
        'junegunn/vim-easy-align',
    },
    ['treesj'] = {
        'Wansmer/treesj',

        requires = 'nvim-treesitter',
    },
    ['undo'] = {
        'debugloop/telescope-undo.nvim',

        requires = 'nvim-telescope/telescope.nvim',
    },
    ['auto_save'] = {
        'pocco81/auto-save.nvim',
    },
    ['yati'] = {
        'yioneko/nvim-yati',
        tag = '*',
        requires = 'nvim-treesitter/nvim-treesitter',
    },
    ['substitute'] = {
        'gbprod/substitute.nvim',
    },
    ['cutlass'] = {
        'gbprod/cutlass.nvim',
    },
    ['yanky'] = {
        'gbprod/yanky.nvim',
    },
    ['dial'] = {
        'monaqa/dial.nvim',
    },
    ['recorder'] = {
        'chrisgrieser/nvim-recorder',
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
    ['visual_multi'] = function()
      require('ds_omega.layers.Editing.visual_multi')
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
    ['auto_save'] = function()
      require('ds_omega.layers.Editing.auto_save')
    end,
    ['substitute'] = function()
      require('ds_omega.layers.Editing.substitute')
    end,
    ['cutlass'] = function()
      require('ds_omega.layers.Editing.cutlass')
    end,
    ['yanky'] = function()
      require('ds_omega.layers.Editing.yanky')
    end,
    ['dial'] = function()
      require('ds_omega.layers.Editing.dial')
    end,
    ['recorder'] = function()
      require('ds_omega.layers.Editing.recorder')
    end,
}

return Editing
