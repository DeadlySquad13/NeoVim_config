local utils = require('config.Completion.utils')
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

  expand = function(args)
    -- Maybe replace with #Anon?
    --return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
    return vim.fn["UltiSnips#Anon"](args.body);
    --return vim.fn.feedkeys(t("<C-R>=UltiSnips#Anon()<CR>"));
  end,
}

return ultisnips_engine;
