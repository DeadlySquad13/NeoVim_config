local M = {}

M.settings = require('ds_omega.config.Ui.noice.settings')
M.keymappings = require('ds_omega.config.Ui.noice.keymappings')

---@type LazySpec
return {
  {
    'folke/noice.nvim',
    cond = not vim.g.started_by_firenvim,

    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries.
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback.
      'rcarriga/nvim-notify',
    },

    opts = M.settings,

    config = function(_, opts)
      local noice_is_available = prequire('noice')

      if not noice_is_available then
        return
      end

      local noice = require('noice')
      noice.setup(opts)


      require('ds_omega.ds_omega_utils').apply_plugin_keymappings(M.keymappings)
    end,
  },
  {
    "AckslD/messages.nvim",

    -- Subset of noice.nvim. As long as we need some features of noice, there's
    -- no need to enable it.
    enabled = false
  }
}
