local snippets_engine = require('config.lsp.ultisnips_engine');
local utils = require('config.lsp.utils');
local t = utils.t;

local neogen = require('neogen')
local cmp = require('cmp')
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

cmp.setup {
  snippet = {
    expand = function(args)
      snippets_engine.expand()
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,

  },
  -- Order matters!
  sources = cmp.config.sources({
    { name = 'path' }, -- Path completion.
    { name = 'nvim_lsp' }, -- Nvim-lsp.
    { name = 'ultisnips' }, -- Ultisnips.
    -- { name = 'nvim_lua' }, -- Nvim-lua functions
    -- { name = 'omni' },
    -- { name = 'buffer', keyword_length = 2 }, -- Buffer word completion.
    -- { name = 'emoji', insert = true, } -- Emoji completion
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
            fallback()
          end
        end,

        i = function(fallback)
          if cmp.visible() then
            -- If you haven't started browsing snippets yet, choose next (first).
            -- if not cmp.get_active_entry() then
            --   return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            -- end
            if snippets_engine.can_expand() then
              return snippets_engine.expand()
            end

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
cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  completion = { autocomplete = false },
  sources = {
    -- { name = 'buffer' }
    { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
  }
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  completion = { autocomplete = false },
  sources = cmp.config.sources({
    { name = 'path' }
    }, {
    { name = 'cmdline' }
  })
})

