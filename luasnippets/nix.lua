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


return {
    --  Insert stacktrace function: `builtins.trace (string to output) (expr to return)`
    -- Supports visual selection (fills both args with selection).
    s(
        'trace',
        fmt(
            [=[
              builtins.trace ({}) ({}){}
            ]=],
            {
                selected_text_or_i(1),
                selected_text_or_i(2),
                i(0)
            }
        )
    ),
}, {}
