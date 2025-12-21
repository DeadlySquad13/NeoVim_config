---@type LazySpec
return {
    "tpope/vim-abolish",

    -- Usual approach with opts and config wasn't fast enough it seems...
    init = function(_)
        local setters = require('ds_omega.utils.setters')

        setters.set_global_variables({
            -- Disables `cr` mapping.
            no_mappings = 1,
        }, 'abolish')

        local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
        local K = CONSTANTS.keymappings

        vim.keymap.set({ "n" }, K.coerce, "<Plug>(abolish-coerce-word)")
        -- Operator pending mode. You first enter case and then operator.
        vim.keymap.set({ "n" }, K.coerce .. "o", "<Plug>(abolish-coerce)")
    end,
}
