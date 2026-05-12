local M = {}

M.markdown_dialects_set = require('ds_omega.utils.set').Set(require('ds_omega.constants.filetypes').markdown_dialects)

---@type LazySpec
return {
  'kylechui/nvim-surround',

  event = 'BufEnter',

  opts = {
    keymaps = {
      -- See `:h nvim-surround.config.keymaps`.
      normal = 't',
      normal_cur = 'tt',
      normal_line = 'T',
      normal_cur_line = "fTT",
      visual = 't',
      visual_line = 'T',
      delete = 'lt',
      change = 'mt',
      change_line = 'mT',
    },

    surrounds = {
      -- Surround with markdown code block, triple backticks.
      -- <https://github.com/kylechui/nvim-surround/issues/88>
      ["c"] = {
        add = function()
          local ft = vim.bo.filetype
          if not M.markdown_dialects_set[ft] then
            return
          end

          local config = require("nvim-surround.config")
          local result = config.get_input("Code block language: ")

          return {
            { "```" .. result, '' },
            { "",              "```" },
          }
        end,
      },
    },

    aliases = {
      q = { '"', "'", "`" },
      t = { "}", "]", ")", ">", '"', "'", "`" },
      -- We have text-objects for function mapped to `m` as in "method".
      m = "f",
    }
  },

  config = true,
}
