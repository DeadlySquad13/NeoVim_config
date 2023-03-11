---@class Module
local Commands = {}

Commands.plugins = {
    ['genghis'] = {
        'chrisgrieser/nvim-genghis',
    },
}

Commands.configs = {
    ['genghis'] = function()
      require('ds_omega.layers.Commands.genghis')
    end,
}

return Commands
