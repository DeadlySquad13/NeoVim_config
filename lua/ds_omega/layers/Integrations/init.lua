---@class Module
local Integrations = {}

Integrations.plugins = {
  ['toggleterm'] = {
    'akinsho/toggleterm.nvim',
    -- keys = { "<leader>r", "<c-t>" },
    -- lua_module = 'toggleterm',
  },
}

Integrations.configs = {
  ['toggleterm'] = function()
    require('ds_omega.layers.Integrations.toggleterm')
  end,
}

return Integrations
