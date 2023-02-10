local simple_plugin_setup = require('ds_omega.utils').simple_plugin_setup

local npairs_is_available, npairs =
simple_plugin_setup('nvim-autopairs', 'Editing.autopairs')

local Rule = require('nvim-autopairs.rule')
-- Add spaces between parentheses
-- Before Insert After
-- ()     space  ( | )
-- ( | )  space  (  )|
-- Reference: [wiki](https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses)
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules({
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      brackets[1][1] .. brackets[1][2],
      brackets[2][1] .. brackets[2][2],
      brackets[3][1] .. brackets[3][2],
    }, pair)
  end),
})

for _, bracket in pairs(brackets) do
  npairs.add_rules({
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
        :with_pair(function()
          return false
        end)
        :with_move(function(opts)
          return opts.prev_char:match('.%' .. bracket[2]) ~= nil
        end)
        :use_key(bracket[2]),
  })
end

-- Move past commas and semicolons.
-- Reference: [wiki](https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#move-past-commas-and-semicolons)
for _, punct in pairs({ ',', ';' }) do
  require('nvim-autopairs').add_rules({
    require('nvim-autopairs.rule')('', punct)
        :with_move(function(opts)
          return opts.char == punct
        end)
        :with_pair(function()
          return false
        end)
        :with_del(function()
          return false
        end)
        :with_cr(function()
          return false
        end)
        :use_key(punct),
  })
end
