return {
  "moyiz/git-dev.nvim",
  event = "VeryLazy",

  opts = function()
    -- TODO: Add commands: one for fast repo clone which gets deleted
    -- (ephemeral). And one
    -- for more prolonged testing of projects (interim).
    local env = require("ds_omega.constants.env")

    return {
      ephemeral = false,
      read_only = true,
      cd_type = "tab",
      -- Location of cloned repositories. Should be dedicated for this purpose.
      repositories_dir = vim.fn.isdirectory(env.INTERIM_PROJECTS) ~= 0 and env.INTERIM_PROJECTS or vim.fn.stdpath "cache" .. "/git-dev",
    }
  end,
}
