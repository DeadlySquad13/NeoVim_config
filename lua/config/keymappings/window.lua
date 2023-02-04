local Hydra = require('hydra')
-- local splits = require('smart-splits')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd

-- local buffer_hydra = Hydra({
--    name = 'Barbar',
--    config = {
--       on_key = function()
--          -- Preserve animation
--          vim.wait(200, function() vim.cmd 'redraw' end, 30, false)
--       end
--    },
--    heads = {
--       { 'h', function() vim.cmd('BufferPrevious') end, { on_key = false } },
--       { 'l', function() vim.cmd('BufferNext') end, { desc = 'choose', on_key = false } },

--       { 'H', function() vim.cmd('BufferMovePrevious') end },
--       { 'L', function() vim.cmd('BufferMoveNext') end, { desc = 'move' } },

--       { 'p', function() vim.cmd('BufferPin') end, { desc = 'pin' } },

--       { 'd', function() vim.cmd('BufferClose') end, { desc = 'close' } },
--       { 'c', function() vim.cmd('BufferClose') end, { desc = false } },
--       { 'q', function() vim.cmd('BufferClose') end, { desc = false } },

--       { 'od', function() vim.cmd('BufferOrderByDirectory') end, { desc = 'by directory' } },
--       { 'ol', function() vim.cmd('BufferOrderByLanguage') end,  { desc = 'by language' } },
--       { '<Esc>', nil, { exit = true } }
--    }
-- })

-- local function choose_buffer()
--    if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
--       buffer_hydra:activate()
--    end
-- end

-- vim.keymap.set('n', 'gb', choose_buffer)

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

--[[ call tinykeymap#Map('windows', '>', '<count1>wincmd >', {'desc': 'Increase width'})
call tinykeymap#Map('windows', '<', '<count1>wincmd <', {'desc': 'Decrease width'})
call tinykeymap#Map('windows', '|', 'vertical resize <count>', {'desc': 'Set width'})
call tinykeymap#Map('windows', '+', 'resize +<count1>', {'desc': 'Increase height'})
call tinykeymap#Map('windows', '-', 'resize -<count1>', {'desc': 'Decrease height'})
call tinykeymap#Map('windows', '_', 'resize <count>', {'desc': 'Set height'})
call tinykeymap#Map('windows', 'w', '<count>wincmd w', {'desc': 'Below-right window'})
call tinykeymap#Map('windows', 'W', '<count>wincmd W', {'desc': 'Above-left window'})
]]--

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
    -- { '<C-h>', function() splits.resize_left(2)  end },
    -- { '<C-j>', function() splits.resize_down(2)  end },
    -- { '<C-k>', function() splits.resize_up(2)    end },
    -- { '<C-l>', function() splits.resize_right(2) end },
    { '=', wincmd '=', { desc = 'Make equally high and wide' } },

    { 's', pcmd('split', 'E36') },
    { '<C-s>', pcmd('split', 'E36'), { desc = false } },
    { 'v', pcmd('vsplit', 'E36') },
    { '<C-v>', pcmd('vsplit', 'E36'), { desc = false } },

    { 'o', wincmd 'o', { exit = true, desc = 'Remain only' } },
    { '<C-o>', wincmd 'o', { exit = true, desc = false } },

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

local TRANSITIVE_CATALIZATOR = '.'

local window_mappings = {
  name = 'Window',
  -- List of windows like in tmux?
  --w = {  },

  -- Made it similar to tmux, even though there's ctrl-w_w shortcut in vim for
  -- such jump.
  -- o = { require('nvim-window').pick, 'Pick window' },
  -- ['<c-o>'] = { require('nvim-window').pick, 'Pick window' },

  s = { pcmd('split', 'E36') },
  ['<C-s>'] = { pcmd('split', 'E36') },
  v = { pcmd('vsplit', 'E36') },
  ['<C-v>'] = { pcmd('vsplit', 'E36') },


  m = { ':FocusMaximise<cr>', 'Maximise window' },

  [TRANSITIVE_CATALIZATOR] = { function() window_hydra:activate() end, 'Activate window mode' },
}

return window_mappings
