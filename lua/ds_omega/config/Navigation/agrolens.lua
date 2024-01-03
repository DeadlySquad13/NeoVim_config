return {
    "desdic/agrolens.nvim",

    -- Used in telescope extensions ./telescope.lua .
    opts = {
        agrolens = {
            debug = false,
            same_type = true,
            include_hidden_buffers = false,
            disable_indentation = false,
            aliases = {}
        }
    },

    config = function()
        require("telescope").load_extension("agrolens")
    end,
}
