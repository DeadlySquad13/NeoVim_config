return {
  -- use_custom_command = { 'cmd.exe', '/c', [[echo $DIFF | delta]]}, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
  use_custom_command = { 'pwsh.exe', '-NoProfile', '-Command', 'echo "$DIFF" | delta'}, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
  side_by_side = true, -- Available only with delta.
  layout_strategy = 'vertical',
  layout_config = {
    preview_height = 0.8,
  },

  diff_context_lines = vim.o.scrolloff,
  entry_format = "state #$ID, $STAT, $TIME",

  mappings = {
    i = {
      -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
      -- you want to replicate these defaults and use the following actions. This means
      -- installing as a dependency of telescope in it's `requirements` and loading this
      -- extension from there instead of having the separate plugin definition as outlined
      -- above.
      ["<cr>"] = require("telescope-undo.actions").yank_additions,
      ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
      ["<C-cr>"] = require("telescope-undo.actions").restore,
    },
  },
}
