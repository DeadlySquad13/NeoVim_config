local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

M = {}

M.logger = get_logger("RestoreView")

M.RestoreView = create_augroup('RestoreView', { clear = true })

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
  '*.org',
}

M.autocmds = {}

M.setup = function()
  M.autocmds.save = create_autocmd({ 'BufWinLeave' }, {
    group = M.RestoreView,
    desc = 'Save view',
    pattern = PATTERNS_ON_WHICH_TO_PRESERVE_OPTIONS,

    callback = function()
      M.logger:debug('mkview')
      vim.cmd.mkview({
        -- Overwrite existing file.
        bang = true,
      })
    end
  })

  M.autocmds.restore = create_autocmd({ 'BufWinEnter' }, {
    group = M.RestoreView,
    desc = 'Restore view',
    pattern = PATTERNS_ON_WHICH_TO_PRESERVE_OPTIONS,

    callback = function()
      local ok = pcall(vim.cmd.loadview)
      M.logger:debug('loaded view', ok)
    end,
  })
end

return M
