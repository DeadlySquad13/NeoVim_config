---@class Module
local Highlighting = {}

Highlighting.plugins = {
    ['colorizer'] = {
        'norcalli/nvim-colorizer.lua',
    },
    -- - Hide cursorline during moving, highlight words under cursor.
    -- use({ 'yamatsum/nvim-cursorline' })
    ['rainbow'] = {
        'DeadlySquad13/nvim-ts-rainbow',
    },
    ['devicons'] = {
        'ryanoasis/vim-devicons',
    },
    ['range_highlight'] = {
        'winston0410/range-highlight.nvim',
    },
    ['indent_blankline'] = {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VimEnter',
        -- Uses treesitter to calculate indentation when possible.
        after = 'nvim-treesitter',
    },
    ['hslens'] = {
        'kevinhwang91/nvim-hlslens',
        branch = 'main',
    },
    ['cmd_parser'] = {
        'winston0410/cmd-parser.nvim',
    },
}

Highlighting.configs = {
    ['colorizer'] = function()
      require('ds_omega.layers.Highlighting.colorizer')
    end,
    ['range_highlight'] = function()
      require('ds_omega.layers.Highlighting.range_highlight')
    end,
    ['indent_blankline'] = function()
      require('ds_omega.layers.Highlighting.indent_blankline')
    end,
}

return Highlighting
