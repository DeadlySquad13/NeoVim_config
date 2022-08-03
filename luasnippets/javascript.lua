local utils_ls = require('utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
-- local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt

return {
  s(
    {
      trig = 'log',
      dscr = 'Log info into console',
    },
    fmt(
      "console.log({})",
      { i(1) }
    )
  ),
  s(
    {
      trig = 'logo',
      dscr = 'Log object into console',
    },
    fmt(
      "console.log({{ {} }})",
      { i(1) }
    )
  ),
  s(
    {
      trig = 'logc1',
      dscr = 'Log colored info into console (variant 1)',
    },
    fmt(
      "console.log('%c{}', 'color: #bada55')",
      { i(1) }
    )
  ),
  s(
    {
      trig = 'logc2',
      dscr = 'Log colored info into console (variant 2)',
    },
    fmt(
      "console.log('%c{}', 'color: #00aabb')",
      { i(1) }
    )
  ),
}, {}
