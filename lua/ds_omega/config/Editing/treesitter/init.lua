return {
  'nvim-treesitter/nvim-treesitter',

  lazy = false,
  -- build = ':TSUpdate',

  opts = function()
    local TREESITTER_CONFIGURATION = 'ds_omega.config.Editing.treesitter'

    local function require_treesitter_configuration(configuration)
      return require(TREESITTER_CONFIGURATION .. '.' .. configuration)
    end

    local parsers = require_treesitter_configuration('parsers')
    local incremental_selection =
    require_treesitter_configuration('incremental_selection')
    local rainbow = require_treesitter_configuration('rainbow')

    local textobjects = require_treesitter_configuration('textobjects')

    -- local yati_is_available, yati = prequire('ds_omega.config.Editing.yati')

    -- List of language that will be disabled
    local DISABLED_HIGHLIGHT_FILETYPES = {
      'css',
    }
    local MAX_HIGHLIGHT_LINE_SIZE = 50000

    return {
      ensure_installed = parsers,
      ignore_install = {}, -- List of parsers to ignore installing
      indent = {
        -- enable = not yati_is_available,
        disable = {
          'yaml',
          'python',
        },
      },

      -- yati = yati.opts,

      incremental_selection = incremental_selection,

      highlight = {
        enable = true, -- false will disable the whole extension
        disable = function(lang, bufnr)
          local current_file_type_is_disabled = require('ds_omega.utils').Set(DISABLED_HIGHLIGHT_FILETYPES)[lang]
          local line_is_too_long = vim.api.nvim_buf_line_count(bufnr) > MAX_HIGHLIGHT_LINE_SIZE

          return current_file_type_is_disabled
              or line_is_too_long
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      -- Brackets.
      rainbow = rainbow,

      textobjects = textobjects,

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    }
  end,

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local tree_sitter_is_available, tree_sitter =
      prequire('nvim-treesitter.configs')

    if not tree_sitter_is_available then
      return
    end

    tree_sitter.setup(opts)

    -- Needed for parser generator to work. TS will try compilers from left to
    --   right.
    require('nvim-treesitter.install').compilers = { 'gcc', 'clang', 'zig' }
  end,
}
