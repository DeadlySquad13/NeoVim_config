local lsp_handlers = require('config.lsp.handlers')

return {
	settings = {
    Lua = {
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
      },
    },
	},

  on_attach = {
    lsp_handlers.disable_formatting
  }
}
