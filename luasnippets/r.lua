local utils_ls = require('utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local t = utils_ls.t
local conds = utils_ls.conds
local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt
local last_after_dot = utils_ls.last_after_dot
local optional_postifx = utils_ls.optional_postifx
local optional_field = utils_ls.optional_field

return {}, {
  s(
    {
      trig = '=',
      dscr = 'Use <- instead of =',
    },
    t('<-'),
    {
      condition = function()
        local node_type_under_cursor = vim.treesitter.get_node():type()

        return not vim.tbl_contains({
          'call',
          'comment',
          'if',
        }, node_type_under_cursor)
      end,
    }
  ),
}

