return {
  enabled = false, -- We need it only as a part of meta-layer so disabling it locally.
  "huantrinh1802/m_taskwarrior_d.nvim",
  version = "*",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    -- The order of toggling task statuses
    task_statuses = { " ", ">", "x", "~" },
    -- The mapping between status and symbol in checkbox
    status_map = { [" "] = "pending", [">"] = "active", ["x"] = "completed", ["~"] = "deleted" },
    -- The checkbox prefix and suffix
    checkbox_prefix = "[",
    checkbox_suffix = "]",
    -- The default list symbol
    default_list_symbol = "*",
    -- Comments pattern prefix and suffix
    -- This is extremely useful for viewing the note in any Makrdown previewers (i.e. Obsidian app) if you set
    comment_prefix = "<!--",
    comment_suffix = "-->",
    -- More configurations will be added in the future
  },

  config = function(_, opts)
    -- Required.
    require("m_taskwarrior_d").setup(opts)

    -- Optional.
    vim.api.nvim_set_keymap("n", "<leader>te", "<cmd>TWEditTask<cr>",
      { desc = "TaskWarrior Edit", noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>TWView<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tu", "<cmd>TWUpdateCurrent<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>tw", "<cmd>TWSyncTasks<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap(
      "n",
      "<c-t>",
      "<cmd>TWToggle<cr>",
      { silent = true }
    )

    -- Be caution: it may be slow to open large files, because it scans the whole buffer.
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("TWTask", { clear = true }),
      pattern = "*.md,*.markdown",
      callback = function()
        vim.cmd('TWSyncTasks')
      end,
    })
  end,
}
