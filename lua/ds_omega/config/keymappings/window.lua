local prequire = require('ds_omega.utils').prequire

local utils = require("ds_omega.config.keymappings._common.utils")
local cmd, pcmd = utils.cmd, utils.pcmd

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')

local window_hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_, _c_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
 _b_: choose buffer
]]

---@param key (string)
local function wincmd(key)
    return cmd('wincmd ' .. key)
end
local Window = {}

local hydra_is_available, Hydra = prequire('hydra')

if hydra_is_available and Hydra then
    -- TODO: Move keybindings to which-key to remove inconsistencies.
    Window.hydra = Hydra({
        name = 'Windows',
        -- hint = window_hint,
        config = {
            hint = {
                float_opts = {
                    style = 'rounded',
                },
                offset = -1
            }
        },
        mode = 'n',
        heads = {
            -- Navigaiton.
            { 's',     wincmd 'h' },
            { 'n',     wincmd 'j' },
            { 'm',     pcmd('wincmd k', 'E11', 'close') },
            { 't',     wincmd 'l' },

            { 'a',     wincmd 't',                      { desc = 'Move to top-left window' } },
            { 'u',     wincmd 'b',                      { desc = 'Move to bottom-right window' } },

            { 'p',     wincmd 'p',                      { desc = 'Go to previous window' } },

            { 'r',     wincmd 'r',                      { desc = 'Rotate window downwards/rightwards' } },
            { 'R',     wincmd 'R',                      { desc = 'Rotate window upwards/leftwards' } },

            -- Moving.
            { 'S',     cmd 'WinShift left' },
            { 'N',     cmd 'WinShift down' },
            { 'M',     cmd 'WinShift up' },
            { 'T',     cmd 'WinShift right' },

            { 'x',     wincmd 'x',                      { desc = 'Exchange windows' } },

            { 'V',     wincmd 'T',                      { desc = 'Move current window to a new tab page' } },

            -- Resizing.
            { '>',     wincmd '>',                      { desc = 'Increase width' } },
            { '<',     wincmd '<',                      { desc = 'Decrease width' } },

            { '+',     wincmd '+',                      { desc = 'Increase height' } },
            { '-',     wincmd '-',                      { desc = 'Decrease height' } },

            { '=',     wincmd '=',                      { desc = 'Make equally high and wide' } },

            -- Splitting.
            { 'l',     pcmd('below new', 'E36') },
            { '<C-l>', pcmd('below new', 'E36'),        { desc = false } },
            { 'h',     pcmd('vnew', 'E36') },
            { '<C-h>', pcmd('vnew', 'E36'),             { desc = false } },

            { 'z',     wincmd 'o',                      { exit = true, desc = 'Remain only' } },
            { '<C-z>', wincmd 'o',                      { exit = true, desc = false } },

            { 'e',     cmd 'FocusMaximise',             { desc = 'Enable Maximise mode' } },
            -- { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

            { 'c',     pcmd('close', 'E444') },
            { 'q',     pcmd('close', 'E444'),           { desc = 'Close window' } },
            { '<C-c>', pcmd('close', 'E444'),           { desc = false } },
            { '<C-q>', pcmd('close', 'E444'),           { desc = false } },

            { 'P',     pcmd('wincmd P', 'E441'),        { desc = 'Open preview window' } },

            { '<Esc>', nil,                             { exit = true, desc = false } }
        }
    })
end

Window.mappings = {
    name = 'Window',

    s = { wincmd 'h', 'Move left' },
    n = { wincmd 'j', 'Move down' },
    m = { pcmd('wincmd k', 'E11', 'close'), 'Move up' },
    t = { wincmd 'l', 'Move right' },

    S = { cmd 'WinShift left', 'Swap left' },
    N = { cmd 'WinShift down', 'Swap down' },
    M = { cmd 'WinShift up', 'Swap up' },
    T = { cmd 'WinShift right', 'Swap right' },

    a = { wincmd 't', 'Move to top-left window' },
    u = { wincmd 'b', 'Move to bottom-right window' },
    -- Overrides close preview window.
    z = { wincmd 'o', 'Remain only' },
    ['<C-z>'] = { wincmd 'o' },

    l = { cmd 'below new', 'Horizontal split new window below' },
    ['<C-l>'] = { cmd 'below new', 'Horizontal split new window below' },
    h = { cmd 'vnew', 'Vertical split new window' },
    ['<C-h>'] = { cmd 'vnew', 'Vertical split new window' },

    -- This keymappings ruins hand position (shifts left from main home-row keys). But it's ok as this mapping is
    -- usually last when interacting with windows (after maximizing you focus on content itself).
    [','] = { cmd 'FocusMaximise', 'Maximise window' },
    [CONSTANTS.transitive_catalizator] = { function() Window.hydra:activate() end, 'Activate window mode' },
}

return Window
