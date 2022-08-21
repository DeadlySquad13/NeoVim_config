---@class Module
local Lsp = {}

Lsp.plugins = {
  ['lsp'] = {
    'williamboman/nvim-lsp-installer',
    {
      'neovim/nvim-lspconfig',
      -- Lsp relies on cmp-nvim-lsp during capabilities initialization.
      after = { 'cmp-nvim-lsp', 'which-key.nvim' },
      -- TODO: How to better handle it?
      config = function()
        require('ds_omega.layers.Lsp.lsp')
      end
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

  ['lspsaga'] = {
    'glepnir/lspsaga.nvim',
    branch = 'main',
  },
}

Lsp.configs = {
  -- ['lsp'] = function()
  --   vim.notify('Load LSP')
  --   require('ds_omega.layers.Lsp.lsp')
  -- end,

  ['lspsaga'] = function()
    require('ds_omega.layers.Lsp.lspsaga')
  end,
}

return Lsp
