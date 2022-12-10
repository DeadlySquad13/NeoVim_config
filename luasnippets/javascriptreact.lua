local utils_ls = require('utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local conds = utils_ls.conds
local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt
local t = utils_ls.t
local last_after_dot = utils_ls.last_after_dot
local optional_postifx = utils_ls.optional_postifx
local optional_field = utils_ls.optional_field

return {}, {
  s(
    {
      trig = 'useLog',
      dscr = 'console.log inside useEffect',
    },
    fmt(
      [[
        useEffect(() => {{
          console.log({})
        }}, [{}])
      ]],
      {
        i(1),
        i(2)
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
  s(
    {
      trig = 'useComponent',
      dscr = 'Common hooks for components',
    },
    {
      t({
        [[const cn = useClassnames(style);]],
        [[const { t } = useTranslation();]]
      })
    },
    {
      condition = conds.line_begin,
    }
  ),
}
