local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local fmt = utils_ls.fmt

return {
    s(
        {
            trig = '~importenv',
            dscr = 'Import .env to Makefile',
        },
        fmt([[
            ifneq (,$(wildcard ./.env))
                include .env
                export
            endif
            ]], {}
        )
    ),
}, {}
