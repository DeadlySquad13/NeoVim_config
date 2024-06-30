return {
  n = {
    ['<Leader>'] = {
      -- - Overriding default search that we remapped to <Leader>/ because sj search is good enough
      -- and aerojump complements it good enough.
      -- - AerojumpSpace is cool but sj.nvim seems more familiar and has marks.
      ['/'] = { '<Plug>(AerojumpBolt)', 'Search across whole buffer folding irrelevant', silent = false },
    },
  },
  -- For a list of keymappings see:
  -- https://github.com/ripxorip/aerojump.nvim/blob/d0cda41cd33670179aa8cc67d9b9de35cb40ff63/rplugin/python3/aerojump/__init__.py#L37
  search = {   -- Keymappings inside search are configured via vim.g so they're in separate table that is set differently.
    ["<Tab>"] = "AerojumpSelNext",
    ["<S-Tab>"] = "AerojumpSelPrev",
  },
}
