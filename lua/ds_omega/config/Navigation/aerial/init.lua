M.keymappings = require('ds_omega.config.Navigation.aerial.keymappings')

---@type LazySpec
return {
  'stevearc/aerial.nvim',

  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },

  opts = require('ds_omega.config.Navigation.aerial.settings'),

  keys = to_lazy_keys(M.keymappings),
}
