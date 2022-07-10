local setup_lsp_keymappings = require('config.lsp.handlers.setup_lsp_keymappings')
local setup_symbol_highlight_under_cursor = require('config.lsp.handlers.setup_symbol_highlight_under_cursor')

local on_attach = function(client, bufnr)
  setup_lsp_keymappings(bufnr)
  setup_symbol_highlight_under_cursor(client)

  --Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --vim.api.nvim_create_autocmd("CursorHold", {
  --buffer=bufnr,
  --callback = function()
  --local opts = {
  --focusable = false,
  --close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
  --border = 'rounded',
  --source = 'always',  -- show source in diagnostic popup window
  --prefix = ' '
  --}

  --if not vim.b.diagnostics_pos then
  --vim.b.diagnostics_pos = { nil, nil }
  --end

  --local cursor_pos = vim.api.nvim_win_get_cursor(0)
  --if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2]) and
  --#vim.diagnostic.get() > 0
  --then
  --vim.diagnostic.open_float(nil, opts)
  --end

  --vim.b.diagnostics_pos = cursor_pos
  --end
  --})

  --if vim.g.logging_level == 'debug' then
  --local msg = string.format("Language server %s started!", client.name)
  --vim.notify(msg, 'info', {title = 'Nvim-config'})
  --end
end


return on_attach
