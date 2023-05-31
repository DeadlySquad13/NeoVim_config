local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local t = utils_ls.t
local c = utils_ls.c
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
      trig = 'logc',
      dscr = 'Log colored info into console',
    },
    fmt(
      "console.log('%c{}', 'color: {}')",
      {
        i(1),
        c(2, {
          t('#bada55'),
          t('#00aabb'),
          i(nil, 'white'),
        })
      }
    )
  ),
}, {}
