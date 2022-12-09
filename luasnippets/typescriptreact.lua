local utils_ls = require('utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local conds = utils_ls.conds
local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt
local t = utils_ls.t
local c = utils_ls.c
local last_after_dot = utils_ls.last_after_dot
local optional_postifx = utils_ls.optional_postifx
local optional_field = utils_ls.optional_field

return {
  -- Stories.
  s(
    {
      trig = 'Story',
      dscr = 'Create a story',
    },
    fmt(
      [[
      export const {}: StoryObj<typeof {}> = {{ args: {{,
          {}
      }}}};
      ]],
      {
        c(1, {
          i(nil, 'base'),
          t('primary'),
          t('secondary'),
          t('success'),
          t('error'),
          t('warning'),
        }),
        i(2, 'Component'),
        i(0),
      }
    )
  )
}, {}
