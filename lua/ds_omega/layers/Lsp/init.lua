---@class Module
local Lsp = {}

Lsp.plugins = {
  ['lspsaga'] = {
    'glepnir/lspsaga.nvim',
    branch = 'main',
  },
}

Lsp.configs = {
  ['lspsaga'] = function()
    require('ds_omega.layers.Lsp.lspsaga')
  end,
}

return Lsp
