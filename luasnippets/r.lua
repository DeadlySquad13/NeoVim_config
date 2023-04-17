local utils_ls = require('utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local t = utils_ls.t
local fmt = utils_ls.fmt
local conds = utils_ls.conds
local selected_text = utils_ls.selected_text
local last_after_dot = utils_ls.last_after_dot
local optional_postifx = utils_ls.optional_postifx
local optional_field = utils_ls.optional_field

-- Use < and > as delimiters as Latex has a lot of {} in syntax.
local function lfmt(format_str, nodes, opts)
  return fmt(format_str, nodes, vim.tbl_extend('error', { delimiters = '<>' }, opts or {}))
end

-- About greek letters:
-- - theta is v (because it resemble v). Theta is V to match small letter.
-- - o and O is skipped because they're just o and O, no need for snippet.
-- Instead o and O are assigned to omega and Omega.
-- - pi and Pi are left as snippets for comfortability even though there's no
-- merit in symbols printed.

-- Skipped:
-- - o (it's just o, no need for snippet)
local small_greek_letters = {
  s(
    {
      trig = ';a',
      dscr = 'alpha',
    },
    t([[\alpha]])
  ),
  s(
    {
      trig = ';b',
      dscr = 'beta',
    },
    t([[\beta]])
  ),
  s(
    {
      trig = ';g',
      dscr = 'gamma',
    },
    t([[\gamma]])
  ),
  s(
    {
      trig = ';d',
      dscr = 'delta',
    },
    t([[\delta]])
  ),
  s(
    {
      trig = ';e',
      dscr = 'varepsilon',
    },
    t([[\epsilon]])
  ),
  s(
    {
      trig = ';z',
      dscr = 'zeta',
    },
    t([[\zeta]])
  ),
  s(
    {
      trig = ';e',
      dscr = 'eta',
    },
    t([[\eta]])
  ),
  s(
    {
      trig = ';v',
      dscr = 'theta',
    },
    t([[\vartheta]])
  ),
  s(
    {
      trig = ';i',
      dscr = 'iota',
    },
    t([[\iota]])
  ),
  s(
    {
      trig = ';k',
      dscr = 'kappa',
    },
    t([[\kappa]])
  ),
  s(
    {
      trig = ';l',
      dscr = 'lambda',
    },
    t([[\lambda]])
  ),
  s(
    {
      trig = ';m',
      dscr = 'mu',
    },
    t([[\mu]])
  ),
  s(
    {
      trig = ';n',
      dscr = 'nu',
    },
    t([[\nu]])
  ),
  s(
    {
      trig = ';x',
      dscr = 'xi',
    },
    t([[\xi]])
  ),
  s(
    {
      trig = ';pi',
      dscr = 'pi',
    },
    t([[\pi]])
  ),
  s(
    {
      trig = ';r',
      dscr = 'rho',
    },
    t([[\rho]])
  ),
  s(
    {
      trig = ';s',
      dscr = 'sigma',
    },
    t([[\sigma]])
  ),
  s(
    {
      trig = ';t',
      dscr = 'tau',
    },
    t([[\tau]])
  ),
  s(
    {
      trig = ';u',
      dscr = 'upsilon',
    },
    t([[\upsilon]])
  ),
  s(
    {
      trig = ';ph',
      dscr = 'phi',
    },
    t([[\varphi]])
  ),
  s(
    {
      trig = ';hi',
      dscr = 'hi',
    },
    t([[\chi]])
  ),
  s(
    {
      trig = ';ps',
      dscr = 'psi',
    },
    t([[\psi]])
  ),
  s(
    {
      trig = ';o',
      dscr = 'omega',
    },
    t([[\omega]])
  ),
}


-- Skipped:
-- - Alpha (it's just A, no need for snippet)
-- - Beta (it's just B, no need for snippet)
-- - Epsilon (it's just E, no need for snippet)
-- - Zeta (it's just Z, no need for snippet)
-- - Eta (it's just H, no need for snippet)
-- - Iota (it's just I, no need for snippet)
-- - Kappa (it's just K, no need for snippet)
-- - Mu (it's just M, no need for snippet)
-- - Nu (it's just N, no need for snippet)
-- - Pho (it's just P, no need for snippet)
-- - Tau (it's just T, no need for snippet)
-- - Hi (it's just X, no need for snippet)
local big_greek_latters = {
  s(
    {
      trig = ';G',
      dscr = 'Gamma',
    },
    t([[\Gamma]])
  ),
  s(
    {
      trig = ';D',
      dscr = 'Delta',
    },
    t([[\Delta]])
  ),
  s(
    {
      trig = ';v',
      dscr = 'Theta',
    },
    t([[\Theta]])
  ),
  s(
    {
      trig = ';l',
      dscr = 'Lambda',
    },
    t([[\Lambda]])
  ),
  s(
    {
      trig = ';X',
      dscr = 'Xi',
    },
    t([[\Xi]])
  ),
  s(
    {
      trig = ';Pi',
      dscr = 'Pi',
    },
    t([[\Pi]])
  ),
  s(
    {
      trig = ';s',
      dscr = 'Sigma',
    },
    t([[\Sigma]])
  ),
  s(
    {
      trig = ';U',
      dscr = 'Upsilon',
    },
    t([[\Upsilon]])
  ),
  s(
    {
      trig = ';Ph',
      dscr = 'Phi',
    },
    t([[\Phi]])
  ),
  s(
    {
      trig = ';Ps',
      dscr = 'Psi',
    },
    t([[\Psi]])
  ),
  s(
    {
      trig = ';O',
      dscr = 'Omega',
    },
    t([[\Omega]])
  ),
}

local latex_snippets = require('utils').list_deep_extend(
  small_greek_letters,
  big_greek_latters,
  {
    s(
      {
        trig = '//',
        dscr = 'Fraction'
      },
      lfmt(
        [[\frac{<>}{<>}]],
        { i(1), i(2) }
      )
    )
  }
)

return {}, vim.list_extend({
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
}, latex_snippets)

