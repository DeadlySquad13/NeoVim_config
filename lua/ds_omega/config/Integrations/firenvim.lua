return {
  'glacambre/firenvim',
  opts = {
    config = {
      localSettings = {
        -- Set 'never' and use [keyboard shortcut](https://github.com/glacambre/firenvim#manually-triggering-firenvim) inside browser to start editing input in firenvim.
        -- Or you can set 'always' and run it like described in [this issue](https://github.com/brookhong/Surfingkeys/issues/1064).
        ['.*'] = { takeover = 'always' },
      },
    }
  },

  cond = true,

  -- Lazy load firenvim
  -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
  lazy = not vim.g.started_by_firenvim,
  build = function()
    vim.fn["firenvim#install"](0)
  end,

  config = function(_, opts)
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
    if vim.g.started_by_firenvim then
      local colorschemas = require('ds_omega.config.theme').default

      require('ds_omega.ds_omega_utils').load_coloscheme(
        colorschemas.COLORSCHEME_NAME,
        colorschemas.BACKUP_COLORSCHEME_NAME,
        colorschemas.FALLBACK_COLORSCHEME_NAME
      )
    end

    local prequire = require('ds_omega.utils').prequire

    local setters_is_available, setters = prequire('ds_omega.utils.setters')

    if not setters_is_available or not setters then
      return
    end

    setters.set_global_variables(opts, 'firenvim')

    -- Use different settings depending on the page being edited.
    local utils = require('ds_omega.utils')
    local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

    local Firenvim = create_augroup('Firenvim', { clear = true })

    -- To check pattern use `:<C-r>%`
    create_autocmd({ 'BufEnter' }, {
      group = Firenvim,
      pattern = 'github.com_*.txt',
      desc = 'Started editing GitHub text element',
      callback = function() vim.bo.filetype = 'markdown' end
    })
    -- - I mostly train in Javascript in leetcode.
    create_autocmd({ 'BufEnter' }, {
      group = Firenvim,
      pattern = 'leetcode.com_problems-*-editor-*.txt',
      desc = 'Started editing leetcode solution',
      callback = function() vim.bo.filetype = 'javascript' end
    })

    local function map(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = vim.tbl_extend('force', options, opts)
      end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    -- Keymappings.
    map('n', '<Esc><Esc>', ':call firenvim#focus_page()<cr>')
    map('n', '<C-z>', ':call firenvim#hide_frame()<cr>')
  end,
}
