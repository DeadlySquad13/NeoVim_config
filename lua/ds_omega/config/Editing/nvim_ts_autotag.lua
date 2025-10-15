---@type LazySpec
return {
    'windwp/nvim-ts-autotag',

    event = require('ds_omega.constants.events').lazy_file,

    opts = {
        opts = {
            -- Defaults
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = false -- Auto close on trailing </
        },
    },

    config = true,
}
