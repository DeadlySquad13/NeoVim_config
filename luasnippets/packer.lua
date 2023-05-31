package.loaded['ds_omega.utils.luasnip'] = nil
local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local selected_text_or_i = utils_ls.selected_text_or_i
local fmt = utils_ls.fmt
local optional_sn = utils_ls.optional_sn
local events = utils_ls.events
local t = utils_ls.t
local sn = utils_ls.sn
local r = utils_ls.r
local c = utils_ls.c
local delete_unmodified_node = utils_ls.delete_unmodified_node
local conds = utils_ls.conds

return {}, {
  s(
    'use',
    fmt(
      [=[
      use({{
        '{}',

        {}
      }}){}
    ]=] ,
      {
        selected_text_or_i(1),
        optional_sn(2),
        i(0)
      }
    ),
    {
      callbacks = {
        [2] = {
          [events.leave] = delete_unmodified_node
        }
      },
      condition = conds.line_begin,
    }
  ),
  s("class", {
      -- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
      c(1, {
        t("public "),
        t("private "),
      }),
      t("class "),
      i(2),
      t(" "),
      c(3, {
        t("{"),
        -- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
        -- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
        sn(nil, {
          t("extends "),
          -- restoreNode: stores and restores nodes.
          -- pass position, store-key and nodes.
          r(1, "other_class", i(1)),
          t(" {"),
        }),
        sn(nil, {
          t("implements "),
          -- no need to define the nodes for a given key a second time.
          r(1, "other_class"),
          t(" {"),
        }),
      }),
      t({ "", "\t" }),
      i(0),
      t({ "", "}" }),
    },
    {
      stored = {
        other_class = i(1, "default_other_class")
      }
    }),
}

