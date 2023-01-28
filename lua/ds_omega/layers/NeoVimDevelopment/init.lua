---@class Module
local NeoVimDevelopment = {}

NeoVimDevelopment.plugins = {
  ['debuglog'] = {
    'smartpde/debuglog',
  },
}

NeoVimDevelopment.configs = {
  ['debuglog'] = function()
    require('ds_omega.layers.NeoVimDevelopment.debuglog')
  end,
}

return NeoVimDevelopment
