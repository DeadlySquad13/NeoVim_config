local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local RevisitLastPositionInFile = create_augroup('RevisitLastPositionInFile', { clear = true })

create_autocmd({ 'BufReadPost' }, {
  group = RevisitLastPositionInFile,
  desc = 'Revisit last position in file.',
  pattern = '*',

  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})
