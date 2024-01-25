local utils_ls = require('ds_omega.utils.luasnip')
local s = utils_ls.s
local i = utils_ls.i
local f = utils_ls.f
local t = utils_ls.t
local c = utils_ls.c
-- local selected_text = utils_ls.selected_text
local fmt = utils_ls.fmt

local package_diagram_snippets = {
    s(
        {
            trig = 'rect~',
            dscr = 'Package element',
        },
        fmt([[
    rect "{}" as {}
    ]],
            {
                i(2, 'Название'),
                i(1,'Alias'),
                -- f(
                --     function (args, _parent, user_args)
                --         return "'" .. args[1][1] .. "'"
                --     end,
                --     {2},
                --     { user_args = { 'Alias' } }
                -- ),
            }
        )
    ),
}

local deployment_diagram_snippets = {
    s(
        {
            trig = 'device~',
            dscr = 'Device (e.g. server)',
        },
        fmt([[
    node "{}" as {} <<device>> {{
        {}
    }}
    ]],
            {
                i(2, 'Сервер'),
                i(1,'Server'),
                i(0)
            }
        )
    ),
}
return require('ds_omega.utils').list_deep_extend(
    package_diagram_snippets,
    deployment_diagram_snippets
), {}
