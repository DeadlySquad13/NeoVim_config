---@class Module
local Completion = {}

Completion.plugins = {
    ['cmp'] = {
        'hrsh7th/nvim-cmp',
        -- event = "InsertEnter", -- for lazyload
    },
    ['lsp'] = {
        'hrsh7th/cmp-nvim-lsp',

        after = 'nvim-cmp',
    },
    ['spell'] = {
        'f3fora/cmp-spell',

        after = 'nvim-cmp',
    },
    ['path'] = {
        'hrsh7th/cmp-path',

        after = 'nvim-cmp',
    },
    ['buffer'] = {
        'hrsh7th/cmp-buffer',

        after = 'nvim-cmp',
    },
    ['calc'] = {
        'hrsh7th/cmp-calc',

        after = 'nvim-cmp',
    },
    ['cmdline'] = {
        'hrsh7th/cmp-cmdline',

        after = 'nvim-cmp',
    },
    ['omni'] = {
        'hrsh7th/cmp-omni',

        after = 'nvim-cmp',
    },
    ['copilot'] = {
        'hrsh7th/cmp-copilot',

        after = 'nvim-cmp',
    },
    ['luasnip'] = {
        'saadparwaiz1/cmp_luasnip',
    },
    ['lspkind'] = {
        'onsails/lspkind.nvim',
    },
    --{'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp'}
}

Completion.configs = {
    ['cmp'] = function()
      require('ds_omega.layers.Completion.cmp')
    end,
}

return Completion
