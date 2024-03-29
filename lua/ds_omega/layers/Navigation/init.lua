---@class Module
local Navigation = {}

Navigation.plugins = {
  ['quick_scope'] = {
    'unblevable/quick-scope',
  },

  ['lightspeed'] = {
    'ggandor/lightspeed.nvim',

    setup = function()
      require('ds_omega.autocommands.lightspeed')
    end
  },

  ['leap'] = {
    'ggandor/leap.nvim',
  },

  ['flit'] = {
    'ggandor/flit.nvim',

    requires = 'leap.nvim',
  },

  ['sj'] = {
    'woosaaahh/sj.nvim',
  },

  ['syntax_tree_surfer'] = {
    'ziontee113/syntax-tree-surfer',
  },

  ['marks'] = {
    'chentoast/marks.nvim',
  },

  ['telescope'] = {
    'nvim-telescope/telescope.nvim',

    requires = 'nvim-lua/plenary.nvim',
  },

  ['telescope_file_browser'] = {
    'nvim-telescope/telescope-file-browser.nvim',

    requires = 'nvim-telescope/telescope.nvim',
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

  ['other'] = {
    -- 'rgroli/other.nvim',
    'DeadlySquad13/other.nvim',

    branch = 'create-file',
  },

  ['rel'] = {
    'aklt/rel.vim',
  }
}

Navigation.configs = {
  ['quick_scope'] = function()
    require('ds_omega.layers.Navigation.quick_scope')
  end,

  ['leap'] = function()
    require('ds_omega.layers.Navigation.leap')
  end,

  ['flit'] = function()
    require('ds_omega.layers.Navigation.flit')
  end,

  ['sj'] = function()
    require('ds_omega.layers.Navigation.sj')
  end,

  ['syntax_tree_surfer'] = function()
    require('ds_omega.layers.Navigation.syntax_tree_surfer')
  end,

  ['marks'] = function()
    require('ds_omega.layers.Navigation.marks')
  end,

  ['telescope'] = function()
    require('ds_omega.layers.Navigation.telescope')
  end,

  ['telescope_file_browser'] = function()
    require('ds_omega.layers.Navigation.telescope_file_browser')
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

  ['other'] = function()
    require('ds_omega.layers.Navigation.other')
  end,
}

return Navigation
