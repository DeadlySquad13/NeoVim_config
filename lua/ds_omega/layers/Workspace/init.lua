---@class Module
local Workspace = {}

Workspace.plugins = {
  ['JABS.nvim'] = {
    'matbme/JABS.nvim',
    cmd = 'JABSOpen',
  },
}

Workspace.configs = {
  ['JABS.nvim'] = function()
    local prequire = require('utils').prequire

    local jabs_is_available, jabs = prequire('jabs')

    if not jabs_is_available then
      return 
    end

    jabs.setup({})
  end
}

return Workspace
