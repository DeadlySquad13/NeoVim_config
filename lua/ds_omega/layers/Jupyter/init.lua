---@class Module
local Jupyter = {}

Jupyter.plugins = {
    ['jukit'] = {
        'luk400/vim-jukit',
    },
}

Jupyter.configs = {
    ['jukit'] = function()
      require('ds_omega.layers.Jupyter.jukit')
    end,
}

return Jupyter
