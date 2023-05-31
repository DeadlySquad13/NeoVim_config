local setup_lsp_keymappings = require('ds_omega.layers.Lsp.handlers.setup_lsp_keymappings')
local setup_symbol_highlight_under_cursor = require('ds_omega.layers.Lsp.handlers.setup_symbol_highlight_under_cursor')
local setup_filter_diagnostics_by_severity = require('ds_omega.layers.Lsp.handlers.filter_diagnostics_by_severity')

local on_attach = function(client, bufnr)
  local filter_diagnostics_by_severity_keymappings = setup_filter_diagnostics_by_severity()
  setup_lsp_keymappings(bufnr, { filter_diagnostics_by_severity_keymappings })

  if not require('ds_omega.utils').exists('vim-illuminate') then
    setup_symbol_highlight_under_cursor(client)
  end

  --Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  --if vim.g.logging_level == 'debug' then
  --local msg = string.format("Language server %s started!", client.name)
  --vim.notify(msg, 'info', {title = 'Nvim-config'})
  --end
end


return on_attach
