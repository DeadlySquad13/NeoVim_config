-- Setup nvim-cmp.
-- config = function()      
--     vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'      
--     vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
--     vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
--     vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
--     vim.g.UltiSnipsRemoveSelectModeMappings = 0
-- end

-- config()

local snippets_engine = require('config.lsp.ultisnips_engine');
local utils = require('config.lsp.utils');
local t = utils.t;

local cmp = require('cmp')
-- Optional.
-- local cmp_nvim_ultisnips = require('cmp_nvim_ultisnips').setup {}
-- local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

cmp.setup {
  snippet = {
    expand = function()
      -- snippets_engine.expand()
      vim.fn["UltiSnips#Anon"](args.body)
    end,

  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    }),

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

