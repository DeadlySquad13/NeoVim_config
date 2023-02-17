local lsp_handlers = require('ds_omega.layers.Lsp.handlers')

return {
  settings = {
    Lua = {
      format = {
       -- Works only once server is loaded so it doesn't fit my workflow as it has a long loading time.
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 10000,
        preloadFileSize = 10000,
        checkThirdParty = false,
      },
    },
  },
  on_attach = {
    lsp_handlers.disable_formatting,
    lsp_handlers.auto_format_on_save,
  },
}
