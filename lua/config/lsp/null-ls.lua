local prequire = require('utils').prequire

local null_ls_is_available, null_ls = prequire('null-ls')

if not null_ls_is_available then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
--local completion = null_ls.builtins.completion;

---
---@param program_name (string)
local function check_if_executable(program_name)
  ---@type (boolean)
  local is_executable = vim.fn.executable(program_name) == 1

  if not is_executable then
    notify(
      'Program "'
      .. program_name
      .. '" is not executable! Make sure it\'s installed and in your $PATH.',
      vim.log.levels.ERROR,
      { title = 'Null-ls' }
    )
  end

  return is_executable
end

-- Unfortunately, null-ls uses log, not notify, for pretty notify we have to do
--   it manually.
--   @see [generators source
--   file](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/generators.lua)
local sources = {
  formatting.stylua,
  ---@see [misspell](https://github.com/client9/misspell).
  -- diagnostics.misspell,
  formatting.prettierd,
}

local function pop_unavailable_sources(sources)
  local available_sources = {}

  for _, source in ipairs(sources) do
    if check_if_executable(source._opts.command) then
      table.insert(available_sources, source)
    end
  end

  return available_sources
end

--@see [config options](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md).
null_ls.setup({
  sources = pop_unavailable_sources(sources),
})
