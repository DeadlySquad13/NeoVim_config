-- Extend text input up to 10 lines if it's small.
vim.cmd([[
  function! s:IsFirenvimActive(event) abort
    if !exists('*nvim_get_chan_info')
      return 0
    endif
    let l:ui = nvim_get_chan_info(a:event.chan)
    return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
        \ l:ui.client.name =~? 'Firenvim'
  endfunction

  function! OnUIEnter(event) abort
    if s:IsFirenvimActive(a:event) && &lines < 10
      set lines=10
    endif
  endfunction

  augroup FirenvimUser
    autocmd!
    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
  augroup end
]])

vim.g.firenvim_config = {
  localSettings = {
    -- Use [keyboard shortcut](https://github.com/glacambre/firenvim#manually-triggering-firenvim) inside browser to start editing input in firenvim.
    ['.*'] = { takeover = 'never' },
  },
}

-- Use different settings depending on the page being edited.
local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local Firenvim = create_augroup('Firenvim', { clear = true })

create_autocmd({ 'BufEnter' }, {
  group = Firenvim,
  pattern = 'github.com_*.txt',
  desc = 'Started editing GitHub text element',
  callback = function() vim.bo.filetype = 'markdown' end
})

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Keymappings.
map('n', '<esc><esc>', ':call firenvim#focus_page()<cr>')
map('n', '<c-z>', ':call firenvim#hide_frame()<cr>')
