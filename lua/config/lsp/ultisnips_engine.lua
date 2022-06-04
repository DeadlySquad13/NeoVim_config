-- Somehow fixes fallback behaviour during tab
--   (otherwise ultisnips tries to expand even if it can't and throws error,
--   preventing *normal* fallback --- tab).
vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0

local utils = require('config.lsp.utils')
local t = utils.t;

local ultisnips_engine = {
  can_jump = function()
    return vim.fn["UltiSnips#CanJumpForwards"]() == 1
  end,

  jump = function()
    return vim.api.nvim_feedkeys(
      t("<Plug>(ultisnips_jump_forward)"), 'm', true
    )
  end,

  can_jump_backwards = function()
    return vim.fn["UltiSnips#CanJumpBackwards"]() == 1
  end,

  jump_backward = function()
    return vim.api.nvim_feedkeys(
      t("<Plug>(ultisnips_jump_backward)"), 'm', true
    )
  end,

  can_expand = function()
    return vim.fn["UltiSnips#CanExpandSnippet"]() == 1
  end,

  expand = function()
    -- Maybe replace with #Anon?
    return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
    -- return vim.fn.feedkeys(t("<C-R>=UltiSnips#Anon()<CR>"))
  end,
}

return ultisnips_engine;

