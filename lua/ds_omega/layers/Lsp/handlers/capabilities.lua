local function setup_capabilities()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  return capabilities
end

return setup_capabilities
