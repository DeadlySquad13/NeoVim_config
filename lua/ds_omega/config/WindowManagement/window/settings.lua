return function()
    local highlight = vim.g.colors_name == 'deadly-gruv' and 'dg_LabelPrimary' or 'Bold'

    return {
        -- The characters available for hinting windows.
        chars = {
            'r', 's', 'n', 't', 'a', 'e', 'i', 'h',
        },

        -- A group to use for overwriting the Normal highlight group in the floating
        -- window. This can be used to change the background color.
        normal_hl = highlight,

        -- The highlight group to apply to the line that contains the hint characters.
        -- This is used to make them stand out more.
        hint_hl = highlight,

        -- The border style to use for the floating window.
        border = 'none',
    }
end
