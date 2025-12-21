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
    ['.'] = "to_dot_case",
    [","] = "to_comma_case",
    a = "to_phrase_case",
    -- c = "to_camel_case",
    -- m = "to_pascal_case", -- mixed case in abolish
    t = "to_title_case",
    f = "to_path_case",
    -- ? = "to_upper_phrase_case",
    -- ? = "to_lower_phrase_case",
}

local enabled_lsp_methods = {
    -- In Abolish there's only 'SNAKE_UPPERCASE'.
    u = "to_upper_case",
    l = "to_lower_case",
    s = "to_snake_case",
    ['_'] = "to_snake_case",
    ["-"] = "to_dash_case",
    -- ? = "to_title_dash_case",
    -- In Abolish it's u and U. Decided to leave it different still.
    n = "to_constant_case",
    ['.'] = "to_dot_case",
    -- [","] = "to_comma_case",
    -- a = "to_phrase_case",
    c = "to_camel_case",
    -- ? = "ToUpperPhraseCase",,
    -- t = "to_title_case",
    -- f = "to_path_case",
    m = "to_pascal_case" -- mixed case in abolish
    -- ? = "to_lower_phrase_case",
}

return {
    n = {
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
