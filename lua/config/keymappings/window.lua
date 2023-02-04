local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

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

local window_hydra = Hydra({
  name = 'Windows',
  -- hint = window_hint,
  config = {
    hint = {
      border = 'rounded',
      offset = -1
    }
  },
  mode = 'n',
  heads = {
    -- Navigaiton.
    { 'h', wincmd 'h' },
    { 'j', wincmd 'j' },
    { 'k', pcmd('wincmd k', 'E11', 'close') },
    { 'l', wincmd 'l' },

    { 't', wincmd 't', { desc = 'Move to top-left window' } },
    { 'b', wincmd 'b', { desc = 'Move to bottom-right window' } },

    { 'p', wincmd 'p', { desc = 'Go to previous window' } },

    { 'r', wincmd 'r', { desc = 'Rotate window downwards/rightwards' } },
    { 'R', wincmd 'R', { desc = 'Rotate window upwards/leftwards' } },

    -- Moving.
    { 'H', cmd 'WinShift left' },
    { 'J', cmd 'WinShift down' },
    { 'K', cmd 'WinShift up' },
    { 'L', cmd 'WinShift right' },

    { 'x', wincmd 'x', { desc = 'Exchange windows' } },

    { 'T', wincmd 'T', { desc = 'Move current window to a new tab page' } },

    -- Resizing.
    { '>', wincmd '>', { desc = 'Increase width' } },
    { '<', wincmd '<', { desc = 'Decrease width' } },

    { '+', wincmd '+', { desc = 'Increase height' } },
    { '-', wincmd '-', { desc = 'Decrease height' } },

    { '=', wincmd '=', { desc = 'Make equally high and wide' } },

    -- Splitting.
    { 's', pcmd('split', 'E36') },
    { '<C-s>', pcmd('split', 'E36'), { desc = false } },
    { 'v', pcmd('vsplit', 'E36') },
    { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

    { 'z', wincmd 'o', { exit = true, desc = 'Remain only' } },
    { '<C-z>', wincmd 'o', { exit = true, desc = false } },

    -- { 'o',     require('nvim-window').pick, { desc = 'Pick window' } },
    -- { '<C-o>', require('nvim-window').pick, { desc = 'Pick window' } },

    { 'm', cmd 'FocusMaximise', { desc = 'Enable Maximise mode' } },
    -- { 'b', choose_buffer, { exit = true, desc = 'choose buffer' } },

    { 'c', pcmd('close', 'E444') },
    { 'q', pcmd('close', 'E444'), { desc = 'Close window' } },
    { '<C-c>', pcmd('close', 'E444'), { desc = false } },
    { '<C-q>', pcmd('close', 'E444'), { desc = false } },

    { 'P', pcmd('wincmd P', 'E441'), { desc = 'Open preview window' } },

    { '<Esc>', nil, { exit = true, desc = false } }
  }
})

local window_mappings = {
  name = 'Window',
  -- List of windows like in tmux?
  --w = {  },

  -- Made it similar to tmux, even though there's ctrl-w_w shortcut in vim for
  -- such jump.
  o = { require('nvim-window').pick, 'Pick window' },
  ['<c-o>'] = { require('nvim-window').pick, 'Pick window' },

  -- Overrides close preview window.
  z = { wincmd 'o', 'Remain only' },
  ['<C-z>'] = { wincmd 'o' },

  s = { pcmd('split', 'E36') },
  ['<C-s>'] = { pcmd('split', 'E36') },
  v = { pcmd('vsplit', 'E36') },
  ['<C-v>'] = { pcmd('vsplit', 'E36') },


  m = { ':FocusMaximise<cr>', 'Maximise window' },

  [require('config.keymappings._common.constants').transitive_catalizator] = { function() window_hydra:activate() end, 'Activate window mode' },
}

return window_mappings
