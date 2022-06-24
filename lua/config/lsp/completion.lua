local prequire = require('utils').prequire;

local snippets_engine = require('config.lsp.ultisnips_engine');
local utils = require('config.lsp.utils');
local t = utils.t;

local neogen = require('neogen')

local lspkind_is_available, lspkind = prequire('lspkind');

if not lspkind_is_available then
  return ;
end

local cmp = require('cmp');
local types = require('cmp.types');
local str = require('cmp.utils.str');
-- Optional.
-- local cmp_nvim_ultisnips = require('cmp_nvim_ultisnips').setup {}
-- local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

--cmp.setup {
  --snippet = {
    --expand = function(args)
      --vim.fn["ultisnips#anonymous"](args.body)
    --end,
  --},

  --mapping = {
    --['<CR>'] = cmp.mapping.confirm({ select = true })
  --},

  --sources = {
    --{ name = "nvim_lsp" },
    --{ name = "buffer" },
  --},
--}

-- Unfortunately, `= true` wasn't working.
local autocomplete_on_every_stroke = {
  --require('cmp.types').cmp.TriggerEvent.InsertEnter,
  require('cmp.types').cmp.TriggerEvent.TextChanged
}
local symbol_map = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

cmp.setup {
  window = {
    --completion = cmp.config.window.bordered({}),
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:Normal,FloatBorder:Normal,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered(),
  },

  formatting = {
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
        if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
          word = vim.lsp.util.parse_snippet(word)
        end
        word = str.oneline(word)

        -- Concatenates the string.
        local max = 50
        if string.len(word) >= max then
          local before = string.sub(word, 1, math.floor((max - 3) / 2))
          word = before .. "..."
        end

        if
          entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
          and string.sub(vim_item.abbr, -1, -1) == "~"
        then
          word = word .. "~"
        end
        vim_item.abbr = word

        return vim_item
      end,
    })
  },
  experimental = {
    ghost_text = {
      hl_group = 'NonText',
    },
  },

  snippet = {
    expand = function(args)
      snippets_engine.expand(args)
    end,

  },

  -- Order matters!
  sources = cmp.config.sources({
    { name = 'path' }, -- Path completion.
    { name = 'nvim_lsp' }, -- Nvim-lsp.
    { name = 'ultisnips' }, -- Ultisnips.
		-- Setting spell (and spelllang) is mandatory to use spellsuggest.
		-- { name = 'spell' }, -- Spellsuggest.
		{ name = 'nvim_lua' }, -- Nvim-lua functions.
	  { name = 'buffer', keyword_length = 2 }, -- Buffer word completion.
    -- { name = 'omni' },
		{ name = 'emoji', insert = true, } -- Emoji completion.
    }, {
      { name = 'buffer' },
    }
  ),
  mapping = {
    ["<Tab>"] = cmp.mapping({
        c = function(fallback)
          if cmp.visible() then
            -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            -- `select = true` enables immediate autocomplete without selection
            --   <c-space><tab> gives the first result.
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
          else
            --cmp.complete();
            fallback()
          end
        end,

        i = function(fallback)
          if cmp.visible() then
            -- If you haven't started browsing snippets yet, choose next (first).
            -- if not cmp.get_active_entry() then
            --   return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            -- end
            --if snippets_engine.can_expand() then
              --return snippets_engine.expand()
            --end

            return cmp.confirm({ select = true })
          else
            fallback()
          end
        end,

        s = function(fallback)
          if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
              vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
          else
            fallback()
          end
        end
    }),

    -- Just defining function doesn't work.
    ['<c-j>'] = cmp.mapping(
      function(fallback)
        if snippets_engine.can_jump() then
          return snippets_engine.jump()
        end
        
        if neogen.jumpable() then
          return neogen.jump_next()
        end

        return fallback()
      end,
      {'i', 'c', 's'}
    ),

    -- Just defining function doesn't work.
    ['<c-k>'] = cmp.mapping(
      function(fallback)
        if snippets_engine.can_jump_backwards() then
          return snippets_engine.jump_backward()
        end

        local backwards = true
        if neogen.jumpable(backwards) then
          return neogen.jump_prev()
        end
        
        return fallback()
      end,
      {'i', 'c', 's'}
    ),

    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
        else
            vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,

      i = function(fallback)
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
        else
            fallback()
        end
      end
    }),

    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
        else
            vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,

      i = function(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
        else
            fallback()
        end
      end
    }),


    ['<C-l>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        -- Filter more precise matches:
        --   from de: { date, debug, defining } only { debug, defining } are
        --   left as they have complete common string.
        return cmp.complete_common_string()
      end
      fallback()
    end, { 'i', 'c' }),

    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),

    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.close(),
      c = cmp.mapping.close()
    }),
  },
}

-- * Enabling support for autopairs.
-- * If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- ? Is it used only for lisp?.
-- * Add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure",
--"clojurescript", "fennel", "janet" }
--cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  autocomplete = autocomplete_on_every_stroke,
  sources = {
    -- { name = 'buffer' }
    { name = 'buffer', option = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = {
    autocomplete = autocomplete_on_every_stroke,
  },
  sources = cmp.config.sources({
    { name = 'path' }
    }, {
    -- Don't show autocomplete on things like `:w`.
    { name = 'cmdline', keyword_length = 2 }
  })
});

