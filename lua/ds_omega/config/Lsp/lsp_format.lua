return {
  'lukas-reineke/lsp-format.nvim',

  opts = {
    sync = true,
    typescript = {
        exclude = { 'vtsls' },
    },
    typescriptreact = {
        exclude = { 'vtsls' },
    },
  },

  config = true,
}
