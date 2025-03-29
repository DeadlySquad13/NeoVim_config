return {
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "python", "janet", "racket", "scheme", "lisp", "julia", "rust", "lua" },
    lazy = true,

    -- Optional cmp-conjure integration
    dependencies = { "PaterJason/cmp-conjure" },

    'Olical/conjure',
    config = function()
      vim.g['conjure#mapping#doc_word'] = '<Leader>ii'
    end,
  },
  {
    "PaterJason/cmp-conjure",
    lazy = true,
    config = function()
      local cmp = require("cmp")
      local config = cmp.get_config()
      table.insert(config.sources, { name = "conjure" })
      return cmp.setup(config)
    end,
  },
}
