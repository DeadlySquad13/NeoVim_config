local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local conds = utils_ls.conds
local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt
local last_after_dot = utils_ls.last_after_dot
local optional_postifx = utils_ls.optional_postifx
local optional_field = utils_ls.optional_field

return {}, {
  s(
    {
      trig = ';req',
      dscr = 'Require module',
    },
    fmt(
      "local {}{} = require('{}'){}",
      { last_after_dot(1), optional_postifx(2), i(1), optional_field(2) }
    ),
    {
      condition = conds.line_begin,
    }
  ),

  s(
    {
      trig = 'preq',
      dscr = 'Protected require',
    },
    fmt(
      [[
        local prequire = require('utils').prequire

        local {}_is_available, {} = prequire('{}')

        if not {}_is_available then
          return {}
        end
      ]],
      {
        last_after_dot(1),
        last_after_dot(1),
        i(1),
        last_after_dot(1),
        selected_text(),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
}
