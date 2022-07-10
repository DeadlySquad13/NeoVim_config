---@class Module
local Toggleterm = {}

Toggleterm.plugins = {
  ['toggleterm.nvim'] = {
    'akinsho/toggleterm.nvim',
    -- keys = { "<leader>r", "<c-t>" },
    -- lua_module = 'toggleterm',
  },
}

Toggleterm.configs = {
  ['toggleterm.nvim'] = function()
    local prequire = require('utils').prequire

    local toggleterm_is_available, toggleterm = prequire('toggleterm')

    if not toggleterm_is_available then
      return
    end
    toggleterm.setup({})
  end
}

return Toggleterm
