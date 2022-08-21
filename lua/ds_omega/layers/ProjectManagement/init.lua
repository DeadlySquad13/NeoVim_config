---@class Module
local ProjectManagement = {}

ProjectManagement.plugins = {
  ['auto_session'] = {
    'rmagatti/auto-session',
  },
}

ProjectManagement.configs = {
  ['auto_session'] = function()
    require('ds_omega.layers.ProjectManagement.auto_session')
  end,
}

return ProjectManagement
