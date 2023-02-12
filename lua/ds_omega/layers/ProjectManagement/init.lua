---@class Module
local ProjectManagement = {}

ProjectManagement.plugins = {
  ['auto_session'] = {
    'rmagatti/auto-session',
  },

  ['todo_comments'] = {
    'folke/todo-comments.nvim',
  },

  ['mind'] = {
    'phaazon/mind.nvim',
    branch = 'v2',

    requires = { 'nvim-lua/plenary.nvim' },
  },
}

ProjectManagement.configs = {
  ['auto_session'] = function()
    require('ds_omega.layers.ProjectManagement.auto_session')
  end,

  ['todo_comments'] = function()
    require('ds_omega.layers.ProjectManagement.todo_comments')
  end,

  ['mind'] = function()
    require('ds_omega.layers.ProjectManagement.mind')
  end,
}

return ProjectManagement
