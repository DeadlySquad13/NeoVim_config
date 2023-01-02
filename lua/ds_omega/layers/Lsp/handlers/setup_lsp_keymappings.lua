  local which_key_utils = require('config.which_key.utils')

--- Apply all lsp related keymappings.
---@param bufnr (integer)
---@param additional_keymappings (table | nil) # Keymappings provided by
--additional lsp handlers.
local setup_lsp_keymappings = function(bufnr, additional_keymappings)
  additional_keymappings = additional_keymappings or {}
  local lsp_buf = vim.lsp.buf
  local prequire = require('utils').prequire

  local lsp_diagnostic = vim.diagnostic

  local lspsaga_diagnostic_is_available, lspsaga_diagnostic =
  prequire('lspsaga.diagnostic')

  if lspsaga_diagnostic_is_available then
    lsp_diagnostic = lspsaga_diagnostic
  end

  --local rename = (function()
  --local renamer_is_available, renamer = pcall(require, "renamer");
  --if not renamer_is_available then
  --return lsp_buf.rename;
  --end

  --return renamer.rename;
  --end)()

  local keymappings = {}

  -- * General.
  --nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

  -- * Investigation.
  -- - & is ? in Russian layout.
  --nnoremap <silent> <leader>gi& <cmd>lua vim.lsp.buf.hover()<CR>
  -- - Implementation.
  --nnoremap <silent> <leader>gii <cmd>lua vim.lsp.buf.implementation()<CR>

  -- - Declaration.
  --nnoremap <silent> <leader>giD <cmd>lua vim.lsp.buf.declaration()<CR>

  -- - Type definition.
  --nnoremap <silent> <leader>git <cmd>lua vim.lsp.buf.type_definition()<CR>

  -- - Definition.
  --nnoremap <silent> <leader>gid <cmd>lua vim.lsp.buf.definition()<CR>

  -- * Searching.
  --nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
  --nnoremap <silent> <leader>g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
  --nnoremap <silent> <leader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

  --vim.keymap.set("n", "gd", lsp_buf.definition, opts)
  --vim.keymap.set("n", "<C-]>", lsp_buf.definition, opts)
  --vim.keymap.set("n", "K", lsp_buf.hover, opts)
  --vim.keymap.set("n", "<C-k>", lsp_buf.signature_help, opts)
  --vim.keymap.set("n", "<space>wa", lsp_buf.add_workspace_folder, opts)
  --vim.keymap.set("n", "<space>wr", lsp_buf.remove_workspace_folder, opts)
  --vim.keymap.set("n", "<space>wl", function() print(vim.inspect(lsp_buf.list_workspace_folders())) end, opts)
  --vim.keymap.set("n", "<space>rn", lsp_buf.rename, opts)
  --vim.keymap.set("n", "gr", lsp_buf.references, opts)
  --vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  --vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  --vim.keymap.set("n", "<space>q", function() vim.diagnostic.setqflist({open = true}) end, opts)
  --vim.keymap.set("n", "<space>ca", lsp_buf.code_action, opts)

  keymappings.n = {
    name = 'LSP',

    ['gd'] = { lsp_buf.definition, 'Jump to definition' },
    ['<c-]>'] = { lsp_buf.definition, 'Jump to definition' },
    ['K'] = { lsp_buf.hover, 'Hover' },
    ['<c-k>'] = { lsp_buf.signature_help, 'Signature help' },
    ['<space>wa'] = { lsp_buf.add_workspace_folder, 'Add workspace folder' },
    ['<space>wr'] = {
      lsp_buf.remove_workspace_folder,
      'Remove workspace folder',
    },
    ['<space>wl'] = {
      function()
        vim.pretty_print(lsp_buf.list_workspace_folders())
      end,
      'List workspace folders',
    },
    ['<space>rs'] = { lsp_buf.rename, 'Rename Symbol' },
    ['<space>ca'] = { lsp_buf.code_action, 'Code Action' }, -- Change from `c`.
    ['<space>q'] = {
      function()
        vim.diagnostic.setqflist({ open = true })
      end,
      'Send diagnostic to quickfix list',
    },

    ['<space>ff'] = { lsp_buf.format, 'Format' },

    ['[d'] = { lsp_diagnostic.goto_prev, 'Go to previous diagnostic' },
    [']d'] = { lsp_diagnostic.goto_next, 'Go to next diagnostic' },

    ['[e'] = {
      function()
        lsp_diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end,
      'Go to previous error',
    },
    [']e'] = {
      function()
        lsp_diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
      end,
      'Go to next error',
    },

    ['[w'] = {
      function()
        lsp_diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
      end,
      'Go to previous warning',
    },
    [']w'] = {
      function()
        lsp_diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
      end,
      'Go to next warning',
    },

    ['[i'] = {
      function()
        lsp_diagnostic.goto_prev({ severity = vim.diagnostic.severity.INFO })
      end,
      'Go to previous info diagnostic',
    },
    [']i'] = {
      function()
        lsp_diagnostic.goto_next({ severity = vim.diagnostic.severity.INFO })
      end,
      'Go to next info diagnostic',
    },

    ['[h'] = {
      function()
        lsp_diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT })
      end,
      'Go to previous hint',
    },
    [']h'] = {
      function()
        lsp_diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
      end,
      'Go to next hint',
    },

    ['<space>i'] = {
      d = {
        lsp_diagnostic.show_line_diagnostics,
        ' Investigate line diagnostics',
      },
      r = { lsp_buf.references, 'List References' },
    },
  }

  keymappings.x = {
    ['<space>ff'] = { lsp_buf.format, 'Format' },
  }

  local options = {
    buffer = bufnr,
  }

  local merged_keymappings = keymappings
  -- TODO: get all modes from `apply_keymappings`.
  for _, mode in ipairs(which_key_utils.MODES) do
    local additional_keymappings_for_mode = vim.tbl_map(
      function(k) return k[mode] end,
      additional_keymappings
    )

    if not vim.tbl_isempty(additional_keymappings_for_mode) then
      merged_keymappings[mode] = vim.tbl_extend('error',
        keymappings[mode] or {},
        unpack(additional_keymappings_for_mode)
      )
    end

    if merged_keymappings[mode] then
      which_key_utils.apply_keymappings(mode, merged_keymappings[mode], options)
    end
  end
end

return setup_lsp_keymappings
