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

-- Using ufo provider need remap `zR` and `zM`.
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

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
ufo.setFoldVirtTextHandler(bufnr, get_customized_selector)

-- local function peekOrHover()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--         -- coc.nvim
--         vim.fn.CocActionAsync('definitionHover')
--         -- nvimlsp
--         vim.lsp.buf.hover()
--     end
-- end
