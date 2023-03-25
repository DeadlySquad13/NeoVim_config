local snippets_engine = require('config.Completion.cmp.luasnip_engine')

local cmp = require('cmp')
local compare = require('cmp.config.compare')

local window_visuals = require('config.Completion.cmp.window_visuals')
local formatting = require('config.Completion.cmp.formatting')
local keymappings = require('config.Completion.cmp.keymappings')

local MIN_KEYWORD_LENGTH = 2

return {
  window = window_visuals,

  formatting = formatting,

  -- experimental = {
  --   ghost_text = {
  --     hl_group = 'NonText',
  --   },
  -- },

  snippet = {
    expand = snippets_engine.expand,
  },

  -- Order matters!
  sources = cmp.config.sources({
    { name = 'path', keyword_length = MIN_KEYWORD_LENGTH + 1, max_item_count = 30 }, -- Path completion.
    { name = 'nvim_lsp', keyword_length = MIN_KEYWORD_LENGTH, max_item_count = 30 }, -- Nvim-lsp.
    { name = 'nvim_lua', keyword_length = MIN_KEYWORD_LENGTH }, -- Nvim-lua functions.
    { name = 'luasnip', keyword_length = MIN_KEYWORD_LENGTH }, -- LuaSnip Snippets.
    --{ name = 'ultisnips' }, -- Ultisnips.
    -- Setting spell (and spelllang) is mandatory to use spellsuggest.
    -- { name = 'spell' }, -- Spellsuggest.

    -- * Ai assitance.
    -- { name = 'copilot' },

    { name = 'buffer', keyword_length = MIN_KEYWORD_LENGTH }, -- Buffer word completion.
    -- { name = 'omni' },
    { name = 'emoji', insert = true }, -- Emoji completion.
  }, {
    { name = 'buffer' },
  }),

  ---@ref [fenuks' dotfiles](https://github.com/fenuks/dotfiles/blob/aa7bbdcd1929bf0f83411f7b94fc31f75c43073d/.config/nvim/lua/init.lua#L414-L427)
  sorting = {
    priority_weight = 10,
    comparators = {
      compare.score,
      compare.order,
    },
    -- Field = 11,
    -- Property = 11,
    -- Constant = 10,
    -- Enum = 10,
    -- EnumMember = 10,
    -- Event = 10,
    -- Function = 10,
    -- Method = 10,
    -- Operator = 10,
    -- Reference = 10,
    -- Struct = 10,
    -- Variable = 9,
    -- File = 8,
    -- Folder = 8,
    -- Class = 5,
    -- Color = 5,
    -- Module = 5,
    -- Keyword = 2,
    -- Constructor = 1,
    -- Interface = 1,
    -- Snippet = 0,
    -- Text = 1,
    -- TypeParameter = 1,
    -- Unit = 1,
    -- Value = 1,
  },

  mapping = keymappings,

  performance = {
    debounce = 300,
    throttle = 60,
    fetching_timeout = 200,
  }
}
