local lsp_handlers = require('config.lsp.handlers')

local default_server_config = {
  on_attach = lsp_handlers.on_attach,
  capabilities = lsp_handlers.capabilitiesor,
  settings = {},
}

return default_server_config
