local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local t = utils_ls.t
local c = utils_ls.c
local fmt = utils_ls.fmt

return {
    s(
        {
            -- TODO: Ideally trigger only at the start of the file.
            trig = '#!!',
            dscr = 'Shebang for bash',
        },
        t("#!/usr/bin/env bash")
    ),
}, {}
