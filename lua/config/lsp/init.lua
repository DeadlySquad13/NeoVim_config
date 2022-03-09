local ENV = require('global');
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
local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

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

-- Setup lspconfig.
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- local servers = { 'pylsp', 'tsserver', 'vimls' }

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- * Python.
lspconfig.pylsp.setup {
  capabilities = capabilities
}

-- * Typescript.
lspconfig.tsserver.setup {
  -- Default values.
  cmd = { ENV:PATH().npm_global_bin .. '/typescript-language-server', "--stdio" },
  filetypes = {
    "javascript", "javascriptreact", "typescript", "typescriptreact" 
  },
  init_options = {
    hostInfo = "neovim"
  },
  -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),

  capabilities = capabilities,
}

-- * Vim.
lspconfig.vimls.setup {
  cmd = { ENV:PATH().npm_global_modules .. '/vim-language-server/bin/index.js', '--stdio' },

  capabilities = capabilities,

  filetypes = { "vim" },
  init_options = {
    diagnostic = {
      enable = true
    },
    -- If you want to speed up index, change gap to smaller and count to
    -- greater, this will cause high CPU usage for some time.
    indexes = {
      -- Count of files index at the same time.
      count = 3,
      -- Index time gap between next file.
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      -- Index vim's runtimepath files.
      runtimepath = true
    },
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true
    },
    vimruntime = ""
  },
}

-- * Linters (diagnostics).
lspconfig.diagnosticls.setup {
  capabilities = capabilities,
  cmd = { ENV:PATH().npm_global_bin .. '/diagnostic-languageserver', "--stdio" },

  filetypes = {
    "javascript", "javascriptreact", "typescript", "typescriptreact", "css"
  },

  init_options = {
    filetypes = {
      javascript = "eslint",
      typescript = "eslint",
      javascriptreact = "eslint",
      typescriptreact = "eslint"
    },
    linters = {
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslitrc.js",
          ".eslitrc",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json"
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        args = {'--stdin-filepath', '%filepath'},
      },
      eslint = {
        sourceName = "eslint",
        command = "./node_modules/.bin/eslint",
        rootPatterns = {
          ".eslitrc.js",
          ".eslitrc",
          "package.json"
        },
        debounce = 100,
        args = {
          "--cache",
          "--stdin",
          "--fix",
          "--stdin-filename",
          "%filepath",
          "--format",
          "json",
        },
        parseJson = {
          errorsRoot = "[0].messages",
          line = "line",
          column = "column",
          endLine = "endLine",
          endColumn = "endColumn",
          message = "${message} [${ruleId}]",
          security = "severity"
        },
        securities = {
          [2] = "error",
          [1] = "warning"
        }
      }
    },
    formatFiletypes = {
      javascript = 'prettier',
      javascriptreact = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'eslint',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      markdown = 'prettier',
    },
  }
}

-- * Emmet.
--if not configs.ls_emmet then
--  configs.ls_emmet = {
--    default_config = {
--      cmd = { 'ls_emmet', '--stdio' };
--      filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
--        'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss'};
--      root_dir = function(fname)
--        return vim.loop.cwd()
--      end;
--      settings = {};
--    };
--  }
--end

--lspconfig.ls_emmet.setup{ capabilities = capabilities }
