return {
  'windwp/nvim-autopairs',

  opts = {
    fast_wrap = {
      map = '<M-a>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match.
      end_key = '$',
      keys = 'rsntaeihg,wfmp.qxclduoyk',
      check_comma = true,
      highlight = 'Search',
      highlight_grey = 'Comment',
    },
    disable_filetype = { 'TelescopePrompt' },
    -- Disable when recording or executing a macro.
    disable_in_macro = true,
    -- Disable when insert after visual block mode.
    disable_in_visualblock = true,
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
    enable_moveright = true,
    -- Add bracket pairs after quote.
    enable_afterquote = true,
    -- Check bracket in same line.
    enable_check_bracket_line = true,
    check_ts = false,
    -- Map the <BS> key.
    map_bs = true,
    -- Map the i_ctrl-h key to delete a pair.
    map_c_h = true,
    -- Map i_ctrl-w to delete a pair if possible.
    map_c_w = true,
  },

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local nvim_autopairs_is_available, nvim_autopairs = prequire('nvim-autopairs')

    if not nvim_autopairs_is_available or not nvim_autopairs then
      return
    end

    nvim_autopairs.setup(opts)

    local Rule = require('nvim-autopairs.rule')
    -- Add spaces between parentheses
    -- Before Insert After
    -- ()     space  ( | )
    -- ( | )  space  (  )|
    -- Reference: [wiki](https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-spaces-between-parentheses)
    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    nvim_autopairs.add_rules({
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
      nvim_autopairs.add_rules({
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
      nvim_autopairs.add_rules({
        Rule('', punct)
            :with_move(function(move_opts)
              return move_opts.char == punct
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
  end,
}
