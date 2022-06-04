local M = {}

M.on_attach = function(client, bufnr)
	--Enable completion triggered by <c-x><c-o>
  --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  local opts = { silent = true, buffer = bufnr }
  --vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  --vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
  --vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  --vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  --vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  --vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  --vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  --vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  --vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  --vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  --vim.keymap.set("n", "<space>q", function() vim.diagnostic.setqflist({open = true}) end, opts)
  --vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

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

  -- The blow command will highlight the current variable and its usages in the buffer.
  --if client.resolved_capabilities.document_highlight then
    --vim.cmd([[
      --hi! link LspReferenceRead Visual
      --hi! link LspReferenceText Visual
      --hi! link LspReferenceWrite Visual
      --augroup lsp_document_highlight
        --autocmd! * <buffer>
        --autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        --autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      --augroup END
    --]])
  --end

  --if vim.g.logging_level == 'debug' then
    --local msg = string.format("Language server %s started!", client.name)
    --vim.notify(msg, 'info', {title = 'Nvim-config'})
  --end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities

return M
