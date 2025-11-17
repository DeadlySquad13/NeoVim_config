local M = {}

M.keymappings = require('ds_omega.config.Integrations.toggleterm.keymappings')

---@type table<SystemName, table<string>>
M.open_terminal_keymappings_map = {
    -- Same physical key, just C-y is the only key on Darwin and Linux that is
    -- not mapped properly to hdn (and different...).
    Darwin = { [[<C-y>]] },
    Windows_NT = {  [[<C-/>]] },
    Linux = {  [[<C-_>]] },
}

M.open_terminal_keymappings = M.open_terminal_keymappings_map[require("ds_omega.utils.os").system_name()] or {}

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
