local prequire = require('utils').prequire

local null_ls_is_available, null_ls = prequire('null-ls')

if not null_ls_is_available then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
--local completion = null_ls.builtins.completion;

-- Unfortunately, null-ls uses log, not notify, for pretty notify we have to do
--   it manually.
--   @see [generators source
--   file](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/generators.lua)
return {
  -- Lua.
  -- formatting.stylua,

  -- General.
  -- see [misspell](https://github.com/client9/misspell).
  -- diagnostics.misspell,

  -- Typescript.
  formatting.prettierd,
  -- - Frontend.
  formatting.stylelint,
  diagnostics.stylelint,

  -- Python.
  formatting.black,
  formatting.isort,
  diagnostics.flake8,
  diagnostics.mypy,
}

