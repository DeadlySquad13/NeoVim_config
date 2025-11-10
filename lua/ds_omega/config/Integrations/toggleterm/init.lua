local M = {}

M.keymappings = require('ds_omega.config.Integrations.toggleterm.keymappings')
M.open_terminal_keymappings = {
    -- Same physical key, just C-y is the only key on Darwin that is
    -- not mapped properly to hdn.
    require("ds_omega.utils.os").is("Darwin") and [[<C-y>]] or [[<C-/>]],
}

---@type LazySpec
return {
    'akinsho/toggleterm.nvim',

    version = "*",

    cmd = {
        "ToggleTerm",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines",
        "ToggleTermVisualSelection",
        "ToggleTermToggleAll",
    },

    keys = vim.list_extend(
        to_lazy_keys(M.keymappings),
        -- Just for lazy-loading
        M.open_terminal_keymappings
    ),

    opts = {
        -- Leads to strange highlighting. I'm ok with default one for now.
        shade_terminals = false,
        -- Adds count and other niceties to keymapping.
        open_mapping = M.open_terminal_keymappings,
    }
}
