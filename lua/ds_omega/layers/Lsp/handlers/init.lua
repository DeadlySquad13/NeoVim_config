return {
  capabilities = require('ds_omega.layers.Lsp.handlers.capabilities'),
  on_attach = require('ds_omega.layers.Lsp.handlers.on_attach'),
  disable_formatting = require('ds_omega.layers.Lsp.handlers.disable_formatting'),
  auto_format_on_save = require('ds_omega.layers.Lsp.handlers.auto_format_on_save'),
}
