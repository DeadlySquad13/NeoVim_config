---@class Module
local NeoVimDevelopment = {}

NeoVimDevelopment.plugins = {
  ['debuglog'] = {
    'smartpde/debuglog',
  },
  ['yop'] = {
    'zdcthomas/yop.nvim',
  },
}

NeoVimDevelopment.configs = {
  ['debuglog'] = function()
    require('ds_omega.layers.NeoVimDevelopment.debuglog')
  end,
  ['yop'] = function()
    require('ds_omega.layers.NeoVimDevelopment.yop')
  end,
}

return NeoVimDevelopment
