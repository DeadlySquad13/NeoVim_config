local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local RestoreView = create_augroup('RestoreView', { clear = true })

-- Basically all programming filetypes where we need folding.
local PATTERNS_ON_WHICH_TO_PRESERVE_OPTIONS = {
  '*.c',
  '*.cpp',
  '*.lua',
  '*.py',
  '*.vim',
  '*.js',
  '*.ts',
  '*.jsx',
  '*.tsx',
}

create_autocmd({ 'BufWinLeave' }, {
  group = RestoreView,
  desc = 'Save view',
  pattern = PATTERNS_ON_WHICH_TO_PRESERVE_OPTIONS,

  callback = function()
    print('mkview')
    vim.cmd.mkview({
      -- Overwrite existing file.
      bang = true,
    })
  end
})

local autocmds = require('ds_omega.config.Ui.ufo.fold_on_file_open').autocmds

-- create_autocmd({ 'BufWinEnter' }, {
create_autocmd({ 'BufReadPre' }, {
  group = RestoreView,
  desc = 'Restore view',
  pattern = PATTERNS_ON_WHICH_TO_PRESERVE_OPTIONS,

  callback = function()
    print('loadview')
    local ok = vim.cmd.loadview()
    print('loaded', ok)

    if ok then
      local i = 5
      while i < 10 do
        i = i+1
      end
      for _, autocmd in pairs(autocmds) do
        print(autocmd)
        vim.api.nvim_del_autocmd(autocmd.id)
      end
    end
  end,
})
