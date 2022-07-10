local prequire = require('utils').prequire;

local lspkind_is_available, lspkind = prequire('lspkind')

if not lspkind_is_available then
  return
end

local symbol_map = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = 'ﰠ',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '塞',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local types = require('cmp.types')
local str = require('cmp.utils.str')

return {
  --format = function(entry, vim_item)
  --local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
  --local strings = vim.split(kind.kind, "%s", { trimempty = true })
  --kind.kind = " " .. strings[1] .. " "
  --kind.menu = "    (" .. strings[2] .. ")"
  --return kind
  --end,
  format = lspkind.cmp_format({
    mode = 'text_symbol', -- show only symbol annotations
    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

    --   פּ ﯟ   some other good icons
    -- find more here: https://www.nerdfonts.com/cheat-sheet
    symbol_map = symbol_map,

    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    --before = function (entry, vim_item)
    --return vim_item
    --end
    before = function(entry, vim_item)
      -- Get the full snippet (and only keep first line)
      local word = entry:get_insert_text()
      if entry.completion_item.insertTextFormat
          == types.lsp.InsertTextFormat.Snippet
      then
        word = vim.lsp.util.parse_snippet(word)
      end
      word = str.oneline(word)

      -- Concatenates the string.
      local max = 50
      if string.len(word) >= max then
        local before = string.sub(word, 1, math.floor((max - 3) / 2))
        word = before .. '...'
      end

      if entry.completion_item.insertTextFormat
          == types.lsp.InsertTextFormat.Snippet
          and string.sub(vim_item.abbr, -1, -1) == '~'
      then
        word = word .. '~'
      end
      vim_item.abbr = word

      return vim_item
    end,
  }),
}
