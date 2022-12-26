---@class Module
local ProjectManagement = {}

ProjectManagement.plugins = {
  ['auto_session'] = {
    'rmagatti/auto-session',
  },

  ['todo_comments'] = {
    'folke/todo-comments.nvim',
  },
}

ProjectManagement.configs = {
  ['auto_session'] = function()
    require('ds_omega.layers.ProjectManagement.auto_session')
  end,

  ['todo_comments'] = function()
    require('ds_omega.layers.ProjectManagement.todo_comments')
  end,
}

return ProjectManagement
