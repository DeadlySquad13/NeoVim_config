return {
    'yioneko/nvim-vtsls',

    opts = {
        -- Automatically trigger renaming of extracted symbol.
        refactor_auto_rename = true,
    },

    config = function (_, opts)
        require('vtsls').config(opts)
    end,
}
