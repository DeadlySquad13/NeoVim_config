return {
    "tpope/vim-abolish",

    -- Usual approach with opts and config wasn't fast enough it seems...
    init = function(_)
        local setters = require('ds_omega.utils.setters')

        setters.set_global_variables({
            -- Disables `cr` mapping.
            no_mappings = 1,
        }, 'abolish')
    end,
}
