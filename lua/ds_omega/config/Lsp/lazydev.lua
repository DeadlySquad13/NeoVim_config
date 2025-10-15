---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found.
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- Only load the lazy.nvim library when the `LazySpec` or something
        -- like 'LazyPluginSpec' global is found.
        { path = "lazy.nvim",            words = { "Lazy*Spec" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}




