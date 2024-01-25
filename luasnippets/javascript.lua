local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local t = utils_ls.t
local c = utils_ls.c
-- local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt

-- TODO: `describe.each` and `expect`
local jest_snippets = {
    s(
        {
            trig = 'describe',
            dscr = 'Group of snippets',
        },
        fmt([[
    describe('{}', () => {{
        {}
    }})
    ]],
            { i(1, 'testing some module'), i(0) })
    ),
    s(
        {
            trig = 'test',
            dscr = 'testing some functionality',
        },
        fmt([[
    it('{}', () =>
        expect({}).{}({})
    )
    ]],
            {
                i(1, 'tests some functionality'),
                i(2, 'util()'),
                c(3, {
                    t('toEqual'),
                    t('toBe'),
                }),
                i(0)
            }
        )
    ),
}

return vim.list_extend({
    s(
        {
            trig = 'log',
            dscr = 'Log info into console',
        },
        fmt(
            "console.log({})",
            { i(1) }
        )
    ),
    s(
        {
            trig = 'logo',
            dscr = 'Log object into console',
        },
        fmt(
            "console.log({{ {} }})",
            { i(1) }
        )
    ),
    s(
        {
            trig = 'logc',
            dscr = 'Log colored info into console',
        },
        fmt(
            "console.log('%c{}', 'color: {}')",
            {
                i(1),
                c(2, {
                    t('#bada55'),
                    t('#00aabb'),
                    i(nil, 'white'),
                })
            }
        )
    ),
}, jest_snippets), {}
