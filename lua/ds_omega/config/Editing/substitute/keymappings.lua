local function substitute()
    local prequire = require('ds_omega.utils').prequire

    local substitute_is_available, substitute = prequire('substitute')

    if not substitute_is_available or not substitute then
        return
    end

    return substitute
end

local function substitute_range()
    local prequire = require('ds_omega.utils').prequire

    local range_is_available, range = prequire('substitute.range')

    if not range_is_available then
        return
    end

    return range
end

-- I decided to call all operations as replace to minimize confusion.
return {
    n = {
        s = { function() return substitute().operator() end, 'Replace', expr = true },
        ss = { function() return substitute().line() end, 'Replace line', expr = true },
        S = { function() return substitute().eol() end, 'Replace to end of line', expr = true },

        --   There's prompt current text that may be useful:
        -- https://github.com/gbprod/substitute.nvim#rangeprompt_current_text

        ['<Leader>'] = {
            s = {
                function()
                    substitute().operator({
                        register = "+"
                    })
                end,
                'Replace from system register',
            },
            ss = {
                function()
                    substitute().line({
                        register = "+"
                    })
                end,
                'Replace line from system register',
            },
            S = {
                function()
                    substitute().eol({
                        register = "+"
                    })
                end,
                'Replace to end of line from system register',
            },

            --   Search and replace keymappings are grouped under <Leader>r (for replace), only
            -- these plugin operators above (and in x mode) are exception (because used frequently
            -- and `r` is reserved for ex-mode).
            r = {
                function()
                    substitute_range().operator({
                        group_substituted_text = true,
                    })
                end,
                'Replace range',
                silent = false,
            },

            rr = {
                function()
                    substitute_range().word({
                        group_substituted_text = true,
                    })
                end,
                'Replace word under cursor',
                silent = false,
            },

            R = {
                function()
                    substitute_range().operator({
                        group_substituted_text = true,
                        prefix = 'S',
                    }) -- For abolish substituion.
                end,
                'Replace range with abolish',
                silent = false,
            },
        },
    },

    x = {
        s = { function() return substitute().visual end, 'Replace', expr = true },
        ['<Leader>r'] = { function() return substitute_range().visual end, 'Replace range', expr = true },
    },
}
