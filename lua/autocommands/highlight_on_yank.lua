local utils = require('utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local HighlightOnYank = create_augroup('HighlightOnYank', { clear = true })

create_autocmd({ 'TextYankPost' }, {
  group = HighlightOnYank,
  desc = 'Highlight on yank.',
  pattern = '*',

  callback = function()
    vim.highlight.on_yank({ higroup = 'ColorColumn' })
  end
})
