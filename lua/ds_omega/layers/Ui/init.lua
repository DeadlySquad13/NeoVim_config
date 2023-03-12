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
    ['ufo'] = {
        'kevinhwang91/nvim-ufo',

        requires = 'kevinhwang91/promise-async'
    },
    ['conceal'] = {
        --'Jxstxs/conceal.nvim',
        'DeadlySquad13/conceal.nvim',

        requires = 'nvim-treesitter/nvim-treesitter',
    },
    ['headlines'] = {
        'lukas-reineke/headlines.nvim',
    },
    ['dashboard'] = {
        'glepnir/dashboard-nvim',
        cond = function()
          return not vim.g.started_by_firenvim
        end,
    },
    ['noice'] = {
    disable = true,
      'folke/noice.nvim',

      requires = {
          -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries.
          'MunifTanjim/nui.nvim',
          -- OPTIONAL:
          --   `nvim-notify` is only needed, if you want to use the notification view.
          --   If not available, we use `mini` as the fallback.
          -- 'rcarriga/nvim-notify',
          }
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
    end,
    ['ufo'] = function()
      require('ds_omega.layers.Ui.ufo')
    end,
    ['conceal'] = function()
      require('ds_omega.layers.Ui.conceal')
    end,
    ['headlines'] = function()
      require('ds_omega.layers.Ui.headlines')
    end,
    ['headlines'] = function()
      require('ds_omega.layers.Ui.headlines')
    end,
    ['noice'] = function()
      require('ds_omega.layers.Ui.noice')
    end,
}

return Ui
