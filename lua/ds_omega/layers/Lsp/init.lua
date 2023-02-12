---@class Module
local Lsp = {}

Lsp.plugins = {
  ['mason'] = {
    'williamboman/mason.nvim',
  },

  ['mason_lspconfig'] = { 
    'williamboman/mason-lspconfig.nvim',
    after = 'mason.nvim',
  },

  ['lspconfig'] = {
    'neovim/nvim-lspconfig',
    after = {
      -- Lsp relies on cmp-nvim-lsp during capabilities initialization.
      'cmp-nvim-lsp',
      'mason-lspconfig.nvim'
    },
  },

  ['copilot'] = {
    'github/copilot.vim',
  },

  ['typescript'] = {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    -- See config in `lsp.server_configurations`.

    requires = 'neovim/nvim-lspconfig',
  },

  -- Lua server enhancement. Config sourced on lua's server setup.
  ['neodev'] = {
    'folke/neodev.nvim',
  },

  ['lspsaga'] = {
    'glepnir/lspsaga.nvim',
    branch = 'main',
  },

  ['illuminate'] = {
    'RRethy/vim-illuminate',
  },

  ['lsp_format'] = {
    'lukas-reineke/lsp-format.nvim',
  },
}

Lsp.configs = {
  ['mason'] = function()
    require('ds_omega.layers.Lsp.mason')
  end,

  ['mason_lspconfig'] = function()
    require('ds_omega.layers.Lsp.mason_lspconfig')
  end,

  ['lspconfig'] = function()
    require('ds_omega.layers.Lsp.lsp')
  end,

  ['lspsaga'] = function()
    require('ds_omega.layers.Lsp.lspsaga')
  end,

  ['illuminate'] = function()
    require('ds_omega.layers.Lsp.illuminate')
  end,

  ['lsp_format'] = function()
    require('ds_omega.layers.Lsp.lsp_format')
  end,
}

return Lsp
