---@class Module
local WindowManagement = {}

WindowManagement.plugins = {
  ['bufdelete'] = {
    'famiu/bufdelete.nvim',
  },

  -- To enable lazy load @see{github plugin page @link{https://github.com/beauwilliams/focus.nvim}}
  ['focus'] = {
    'beauwilliams/focus.nvim',
  },

  ['window'] = {
    'yorickpeterse/nvim-window'
  },

  ['winshift'] = {
    'sindrets/winshift.nvim',
  },
}

WindowManagement.configs = {
  ['focus'] = function()
    require('ds_omega.layers.WindowManagement.focus')
  end,

  ['window'] = function()
    require('ds_omega.layers.WindowManagement.window')
  end,

  ['winshift'] = function()
    require('ds_omega.layers.WindowManagement.winshift')
  end,
}

return WindowManagement
