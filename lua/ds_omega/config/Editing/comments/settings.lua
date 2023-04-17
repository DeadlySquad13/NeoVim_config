local prequire = require('ds_omega.utils').prequire

---@param ctx CommentCtx

---@ref [Recommended configuration](https://github.com/numToStr/Comment.nvim#-hooks).
local function handle_typescriptreact(ctx)
  local U = require('Comment.utils')
  local ft = require('Comment.ft')
  local ts_context_commentstring_utils_is_available, ts_context_commentstring_utils = prequire('ts_context_commentstring.utils')

  -- Return default.
  if not ts_context_commentstring_utils_is_available then
    local cstr = ft.get(vim.bo.filetype, ctx.ctype)

    return cstr
  end


  -- Determine whether to use linewise or blockwise commentstring.
  local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

  -- Determine the location where to calculate commentstring from.
  local location = nil
  if ctx.ctype == U.ctype.block then
    location = ts_context_commentstring_utils.get_cursor_location()
  elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
    location = ts_context_commentstring_utils.get_visual_start_location()
  end

  return require('ts_context_commentstring.internal').calculate_commentstring({
    key = type,
    location = location,
  })
end

---@param ctx CommentCtx
local function pre_hook(ctx)
  -- Only calculate commentstring for tsx filetypes
  if vim.bo.filetype == 'typescriptreact' then
    return handle_typescriptreact(ctx)
  end
end

---
---@param ctx (CommentCtx).
---@return (string) commentstring `:h commentstring`.
local function post_hook(ctx)
  -- if ctx.cmotion == 1 and ctx.ctype == 1 then
  --   -- commentstring.
  --   local cstr = ft.get(vim.bo.filetype, ctx.ctype)
  --   -- Extracting left and right comments.
  --   local lcs, rcs = U.unwrap_cstr(cstr)
  --   local lines = vim.api.nvim_buf_get_lines(0, ctx.range.srow - 1, ctx.range.erow, false)
  --
  --   -- Commenting.
  --   if ctx.cmode == 1 then
  --     -- lines[1] = lines[1]:gsub(lcs, lcs, 1)
  --     --*lines
  --     lines[1] = P(lines[1]):gsub(regex_escape(lcs), lcs..'* ', 2)
  --     vim.api.nvim_buf_set_lines(0, ctx.range.srow - 1, ctx.range.erow, false, lines)
  --   end
  --
  --   -- if ctx.cmode == 1 then
  --   --   print('Extra >')
  --   --   -- return comment_type..' *'
  --   -- elseif ctx.cmode == 2 then
  --   --   print('Extra <')
  --   -- else
  --   --   print('Toggle')
  --   -- end
  -- end
end

return {
  ---Add a space b/w comment and the line
  ---@type boolean|fun():boolean
  padding = true,

  ---Whether the cursor should stay at its position
  ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
  ---@type boolean
  sticky = true,

  ---Lines to be ignored while comment/uncomment.
  ---Could be a regex string or a function that returns a regex string.
  ---Example: Use '^$' to ignore empty lines
  ---@type string|fun():string
  ignore = '^$',

  ---LHS of toggle mappings in NORMAL + VISUAL mode
  ---@type table
  toggler = {
    ---Line-comment toggle keymap
    line = '<leader>cc',
    ---Block-comment toggle keymap
    block = '<leader>Cc',
  },

  ---LHS of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
    ---Line-comment keymap
    line = '<leader>c',
    ---Block-comment keymap
    block = '<leader>C',
  },

  ---LHS of extra mappings
  ---@type table
  extra = {
    ---Add comment on the line above
    above = '<leader>cO',
    ---Add comment on the line below
    below = '<leader>co',
    ---Add comment at the end of line
    eol = '<leader>cA',
  },

  ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
  ---NOTE: If `mappings = false` then the plugin won't create any mappings
  ---@type boolean|table
  mappings = {
    ---Operator-pending mapping
    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
    basic = true,
    ---Extra mapping
    ---Includes `gco`, `gcO`, `gcA`
    extra = true,
  },

  ---Pre-hook, called before commenting the line
  ---@type fun(ctx: CommentCtx):string
  pre_hook = pre_hook,

  ---Post-hook, called after commenting is done
  ---@type fun(ctx: CommentCtx)
  post_hook = post_hook,
}
