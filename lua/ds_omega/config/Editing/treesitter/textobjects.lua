local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local add_prefix = require('ds_omega.config.keymappings._common.utils').add_prefix
local K = CONSTANTS.keymappings

-- TODO: Remap some of the square bracket commands (`:h [) to this pattern to
--   have a fallback when treesitter is not available and to
--   firm the mnemonics.
local move_objects = {
  start = {
    m = { query = "@function.outer", desc = "Function (method) start" },

    c = { query = "@class.outer", desc = "Class start" },

    o = { query = "@loop.*", desc = "Loop start" }, -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
    -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
    -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },

    -- For example (cursor at |):
    -- local test_var = 'some string to t|est' .. ' my new module'
    -- ^ to get here use "<C^ to get here use "<Right>-Left>
    --              ^ to get here use "<Left>
    --                  ^ to get here use "<Right>
    --                                to get here use y<C-Right> ^
    ['<C-Left>'] = { query = { "@assignment.lhs", "@attribute.inner", }, desc = "Left hand side of assignment start" },
    ['<Right>'] = { query = { "@assignment.rhs", "@attribute.outer" }, desc = "Right hand side of assignment start" },

    -- ? May need to remap it as it conflicts with 
    p = { query = "@parameter.outer", desc = "Parameter start" },

    ['/'] = { query = "@comment.outer", desc = "Comment start" },
  },
  ['end'] = {
    M = { query = "@function.outer", desc = "Function end" },

    C = { query = "@class.outer", desc = "Class end" },

    O = { query = "@loop.*", desc = "Loop end" },

    ['<Left>'] = { query = { "@assignment.lhs", "@attribute.inner", }, desc = "Left hand side of assignment end" },
    ['<C-Right>'] = { query = { "@assignment.rhs", "@attribute.outer" }, desc = "Right hand side of assignment end" },

    P = { query = "@parameter.outer", desc = "Parameter end" },

    ['*'] = { query = "@comment.outer", desc = "Comment end" },
  },

  -- Below will go to either the start or the end, whichever is closer.
  -- Use if you want more granular movements
  -- Make it even more gradual by adding multiple queries and regex.
  next = {
    ["d"] = { query = "@conditional.outer", desc = "Conditional" },
  },
  previous = {
    ["d"] = { query = "@conditional.outer", desc = "Conditional" },
  }
}

local goto_next_start = add_prefix(K.next, move_objects.start)
local goto_next_end = add_prefix(K.next, move_objects["end"])
local goto_previous_start = add_prefix(K.previous, move_objects.start)
local goto_previous_end = add_prefix(K.previous, move_objects["end"])
local goto_next = add_prefix(K.next, move_objects.next)
local goto_previous = add_prefix(K.previous, move_objects.previous)

return {
  select = {
    enable = true,

    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["em"] = "@function.outer",
      ["qm"] = "@function.inner",
      ["ec"] = "@class.outer",
      ["qc"] = { query = "@class.inner", desc = "Select inner part of a class region" },
    },

    --   If you set this to `true` (default is `false`) then any textobject is
    -- extended to include preceding or succeeding whitespace. Succeeding
    -- whitespace has priority in order to act similarly to eg the built-in
    -- `ap`.
    --
    --   Can also be a function which gets passed a table with the keys
    -- * query_string: eg '@function.inner'
    -- * selection_mode: eg 'v'
    -- and should return true of false
    include_surrounding_whitespace = false,
  },

  move = {
    enable = true,
    -- Whether to set jumps in the jumplist.
    set_jumps = true,
    goto_next_start = goto_next_start,
    goto_next_end = goto_next_end,

    goto_previous_start = goto_previous_start,
    goto_previous_end = goto_previous_end,
    goto_next = goto_next,
    goto_previous = goto_previous,
  },

}
