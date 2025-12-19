---@type LazySpec
return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {},

  init = function()
    -- Now you can easily start a new task by simply typing :OS <command to run>
    vim.cmd.cnoreabbrev("OS OverseerShell")
  end,
}
