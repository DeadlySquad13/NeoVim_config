local prequire = require('ds_omega.utils').prequire
local _, utils = prequire('ds_omega.config.keymappings._common.utils')

return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      -- It extends `~` into username so it will not work in other
      -- environments.
      -- dir_path = "~/.bookmarks/kbd/_assets",
      -- use_absolute_path = true,
      dir_path = "_assets",
    },
  },
  keys = {
    { "<leader>ip", utils.cmd "PasteImage", desc = "Paste image from system clipboard" },
  },
}
