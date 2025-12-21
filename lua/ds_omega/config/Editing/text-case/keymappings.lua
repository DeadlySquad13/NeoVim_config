local function text_case()
    local textcase_is_available = prequire('textcase')

    if not textcase_is_available then
        return
    end

    return require('textcase')
end

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local K = CONSTANTS.keymappings

local enabled_methods = {
    -- u = "to_upper_case",
    -- l = "to_lower_case",
    -- s = "to_snake_case",
    -- ["-"] = "to_dash_case",
    -- ? = "to_title_dash_case",
    -- n = "to_constant_case",
    d = "to_dot_case",
    [","] = "to_comma_case",
    a = "to_phrase_case",
    -- c = "to_camel_case", -- mixed case in abolish
    -- p = "to_pascal_case",
    t = "to_title_case",
    f = "to_path_case",
    -- ? = "to_upper_phrase_case",
    -- ? = "to_lower_phrase_case",
}

local enabled_lsp_methods = {
    u = "to_upper_case",
    l = "to_lower_case",
    s = "to_snake_case",
    ["-"] = "to_dash_case",
    -- ? = "to_title_dash_case",
    n = "to_constant_case",
    d = "to_dot_case",
    -- [","] = "to_comma_case",
    -- a = "to_phrase_case",
    m = "to_camel_case", -- mixed case in abolish
    p = "to_pascal_case",
    -- t = "to_title_case",
    -- f = "to_path_case",
    -- ? = "to_upper_phrase_case",
    -- ? = "to_lower_phrase_case",
}

return {
    n = {
        -- [coerce] = {
        --     ["/"] = { function() text_case().lsp_rename('to_path_case') end, 'Coerce to path case' },
        -- },
        -- [K.coerce]
        [K.coerce] = vim.tbl_map(function(method)
            -- STYLE: convert method name to phrase case (`method_name` -> "method name").
            return { function() text_case().current_word(method) end, 'Current word Coerce to '..method }
        end, enabled_methods),
        [K.coerce .. 'o'] = vim.tbl_map(function(method)
            -- STYLE: convert method name to phrase case (`method_name` -> "method name").
            return { function() text_case().operator(method) end, 'Coerce to '..method }
        end, enabled_methods),
        ['<Leader>' .. K.coerce] = vim.tbl_map(function(method)
            -- STYLE: convert method name to phrase case (`method_name` -> "method name").
            return { function() text_case().lsp_rename(method) end, 'Lsp Coerce to '..method }
        end, enabled_lsp_methods),
    },
}
