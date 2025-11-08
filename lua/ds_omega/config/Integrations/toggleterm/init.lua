local M = {}

M.keymappings = require('ds_omega.config.Integrations.toggleterm.keymappings')
M.terminal_leader = M.keymappings.terminal_leader
M.open_terminal_keymapping = { M.terminal_leader .. "t", [[<C-/>]] }
M.keymappings.terminal_leader = nil

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
        M.open_terminal_keymapping
    ),

    opts = {
        -- Leads to strange highlighting. I'm ok with default one for now.
        shade_terminals = false,
        -- Adds count and other niceties to keymapping.
        open_mapping = M.open_terminal_keymapping,
    }
}
