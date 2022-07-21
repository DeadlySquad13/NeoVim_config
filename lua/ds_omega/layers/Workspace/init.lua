---@class Module
local Workspace = {}

Workspace.plugins = {
  ['tpipeline'] = {
    'vimpostor/vim-tpipeline',
    -- Broke after this commit.
    lock = true,
    branch = 'af7fe78523c7c860d00b79383908322fcb5e6133',
  },

  ['lualine'] = {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    event = 'VimEnter',
  },

  ['bufferline'] = {

    'akinsho/bufferline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    event = 'VimEnter',
  },

  ['jabs'] = {
    'matbme/JABS.nvim',
    cmd = 'JABSOpen',
  },

  ['incline'] = {
    'b0o/incline.nvim',
  },

  ['true_zen'] = {
    'Pocco81/TrueZen.nvim',
  },

  ['twilight'] = {
    -- See [issue about background](https://github.com/folke/twilight.nvim/issues/15)
    'benstockil/twilight.nvim',
    -- Uses treesitter to automatically expand the visible text.
    after = 'nvim-treesitter',
  },

}

Workspace.configs = {
  ['twilight'] = function()
    require('ds_omega.layers.Workspace.twilight')
  end,

  ['tpipeline'] = function()
    require('ds_omega.layers.Workspace.tpipeline')
  end,

  ['lualine'] = function()
    require('ds_omega.layers.Workspace.lualine')
  end,

  ['bufferline'] = function()
    require('ds_omega.layers.Workspace.bufferline')
  end,

  ['jabs'] = function()
    require('ds_omega.layers.Workspace.jabs')
  end,

  ['true_zen'] = function()
    require('ds_omega.layers.Workspace.true_zen')
  end,
}

return Workspace
