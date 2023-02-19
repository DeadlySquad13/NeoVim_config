local utils = require('utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local SetFormatOptions = create_augroup('SetFormatOptions', { clear = true })

--   Format options can be additionally built into each filetype in vim. We
--   don't want some options to be overriden.
create_autocmd({ 'BufReadPost' }, {
  group = SetFormatOptions,
  desc = 'Do not autocmment new lines when using o and O.',
  pattern = '*',

  command = 'set fo-=o',
})
