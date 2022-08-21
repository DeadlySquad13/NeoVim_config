---@class Module
local Ui = {}

Ui.plugins = {
  ['dressing'] = {
    'stevearc/dressing.nvim',
  },
  ['notify'] = {
    'rcarriga/nvim-notify',
  },
  ['fidget'] = {
    'j-hui/fidget.nvim',
  },

  ['which_key'] = {
    'folke/which-key.nvim',
    event = 'BufWinEnter',
  },

    -- - Better UI for Lsp rename.
    -- use({
    --   'filipdutescu/renamer.nvim',
    --   branch = 'master',
    --   requires = { { 'nvim-lua/plenary.nvim' } },

    --   config = [[ require('config.renamer') ]],
    -- })
}

Ui.configs = {
  ['dressing'] = function()
    require('ds_omega.layers.Ui.dressing')
  end,

  ['notify'] = function()
    require('ds_omega.layers.Ui.notify')
  end,

  ['fidget'] = function()
    require('ds_omega.layers.Ui.fidget')
  end,

  ['which_key'] = function()
    require('ds_omega.layers.Ui.which_key')
  end
}

return Ui
