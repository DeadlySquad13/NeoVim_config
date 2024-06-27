return {   -- requires plugins in lua/plugins/treesitter.lua and lua/plugins/lsp.lua
  -- for complete functionality (language features)
  'quarto-dev/quarto-nvim',
  ft = { 'quarto' },
  dev = false,
  opts = {
    lspFeatures = {
      languages = {
        'r',
        'python',
        -- 'julia', -- Have never used it.
        'bash',
        'lua',
        'html',
        'dot',
        'javascript',
        'typescript',
        'ojs',
      },
    },
    codeRunner = {
      enabled = true,
      default_method = 'slime',
    },
  },
  dependencies = {
    --   For language features in code cells
    -- configured in lsp and added as a nvim-cmp source.
    'jmbuhr/otter.nvim',
  },
}
