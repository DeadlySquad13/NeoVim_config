---@class Module
local Assistance = {}

Assistance.plugins = {
  ['null_ls'] = {
      'jose-elias-alvarez/null-ls.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
  },
}

Assistance.configs = {
  ['null_ls'] = function()
    require('ds_omega.layers.Assistance.null_ls')
  end,
}

return Assistance
