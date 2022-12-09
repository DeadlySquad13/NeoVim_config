---@class Module
local Navigation = {}

Navigation.plugins = {
  ['quick_scope'] = {
    'unblevable/quick-scope',
  },

  ['lightspeed'] = {
    'ggandor/lightspeed.nvim',

    setup = function ()
      require('autocommands.lightspeed')
    end
  },

  ['marks'] = {
    'chentoast/marks.nvim',
  },

  ['telescope'] = {
    'nvim-telescope/telescope.nvim',
    requires = 'nvim-lua/plenary.nvim',
  },

  ['rnvimr'] = {
    'kevinhwang91/rnvimr',
  },

  ['neo_tree'] = {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
  },

  ['dirbuf'] = {
    'elihunter173/dirbuf.nvim',
  },

  ['rel'] = {
    'aklt/rel.vim',
  }
}

Navigation.configs = {
  ['quick_scope'] = function()
    require('ds_omega.layers.Navigation.quick_scope')
  end,

  ['lightspeed'] = function ()
    require('ds_omega.layers.Navigation.lightspeed')
  end,

  ['marks'] = function()
    require('ds_omega.layers.Navigation.marks')
  end,

  ['telescope'] = function()
    require('ds_omega.layers.Navigation.telescope')
  end,

  ['rnvimr'] = function()
    require('ds_omega.layers.Navigation.rnvimr')
  end,

  ['neo_tree'] = function()
    require('ds_omega.layers.Navigation.neo_tree')
  end,

  ['dirbuf'] = function()
    require('ds_omega.layers.Navigation.dirbuf')
  end,

  ['rel'] = function()
    require('ds_omega.layers.Navigation.rel')
  end,
}

return Navigation
