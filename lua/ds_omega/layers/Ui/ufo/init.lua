-- local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

-- local ufo = simple_plugin_setup('ufo', 'ufo')
local ufo = require('ufo')

-- Pretty fold column ([even prettier one](https://github.com/kevinhwang91/nvim-ufo/issues/4)):
-- Arrows are U+2B9{B,A}
vim.o.fillchars = [[eob: ,fold: ,foldopen:⮛,foldsep: ,foldclose:⮚]]

vim.o.foldcolumn = '1'

vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- It seems to be overriden by setup_lsp_keymappings. Use amend keymappings plugin for that?
-- local function peekOrHover()
--   local winid = ufo.peekFoldedLinesUnderCursor()
--   if not winid then
--     vim.lsp.buf.hover()
--   end
-- end

local apply_keymappings_once_ready = require('config.Ui.which_key.utils').apply_keymappings_once_ready
apply_keymappings_once_ready('n', {
  -- Using ufo provider need remap `zR` and `zM`.
  z = {
    R = { ufo.openAllFolds, 'Close all folds' },
    M = { ufo.closeAllFolds, 'Open all folds' },
  },

  ['<A-k>'] = { ufo.peekFoldedLinesUnderCursor, 'Peek lines' },
})

local get_customized_selector = require('ds_omega.layers.Ui.ufo.get_customized_selector')
local fold_virt_text_handler = require('ds_omega.layers.Ui.ufo.fold_virt_text_handler')

ufo.setup({
  -- Global handler
  fold_virt_text_handler = fold_virt_text_handler,
  provider_selector = get_customized_selector,
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
ufo.setFoldVirtTextHandler(bufnr, fold_virt_text_handler)
