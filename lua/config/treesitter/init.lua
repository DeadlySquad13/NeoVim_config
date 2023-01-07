local prequire = require('utils').prequire

local tree_sitter_is_available, tree_sitter = prequire(
  'nvim-treesitter.configs'
)

if not tree_sitter_is_available then
  return
end

local TREESITTER_CONFIGURATION = 'config.treesitter'

local function require_treesitter_configuration(configuration)
  return require(TREESITTER_CONFIGURATION .. '.' .. configuration)
end

local parsers = require_treesitter_configuration('parsers')
local incremental_selection = require_treesitter_configuration(
  'incremental_selection'
)
local rainbow = require_treesitter_configuration('rainbow')

-- List of language that will be disabled
local DISABLED_HIGHLIGHT_FILETYPES = {
  'css',
}
local MAX_HIGHLIGHT_LINE_SIZE = 50000

tree_sitter.setup({
  ensure_installed = parsers,
  ignore_install = {}, -- List of parsers to ignore installing
  indent = {
    enable = true,
    disable = {
      'yaml',
      'python',
    },
  },
  incremental_selection = incremental_selection,

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = function(lang, bufnr)
      return require('utils').Set(DISABLED_HIGHLIGHT_FILETYPES)[lang] or vim.api.nvim_buf_line_count(bufnr) > MAX_HIGHLIGHT_LINE_SIZE
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Brackets.
  rainbow = rainbow,

  context_commentstring = {
    enable = true,
    -- Disable the CursorHold autocommand of this plugin to work with
    --   Comment.nvim.
    enable_autocmd = false,
  },
})

-- Needed for parser generator to work. TS will try compilers from left to
--   right.
require('nvim-treesitter.install').compilers = { 'gcc', 'clang' }
