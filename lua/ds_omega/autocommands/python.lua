local utils = require('ds_omega.utils')
local create_augroup = utils.create_augroup
local file_type_autocmd_factory = require('ds_omega.autocommands.utils').file_type_autocmd_factory

-- NOTE: clear option - clears previously created autocommands in augroup.

local Python = create_augroup('PythonOptions', { clear = true })
local create_python_autocmd = file_type_autocmd_factory({ group = Python, pattern = 'python' })

create_python_autocmd({
  desc = '',
  callback = function()
    vim.schedule(function()
      print('I am python!')
      -- setlocal tabstop=4
      -- setlocal softtabstop=4
      -- setlocal shiftwidth=4
    end)
  end,
})

