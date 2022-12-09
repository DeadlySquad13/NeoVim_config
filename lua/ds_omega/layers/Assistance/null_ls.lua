local prequire = require('utils').prequire

local null_ls_is_available, null_ls = prequire('null-ls')

if not null_ls_is_available then
  return
end

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
      { title = 'Null-ls', timeout = 1000 }
    )
  end

  return is_executable
end

local function pop_unavailable_sources(sources)
  local available_sources = {}

  for _, source in ipairs(sources) do
    if check_if_executable(source._opts.command) then
      table.insert(available_sources, source)
    end
  end

  return available_sources
end

local sources = require('config.lsp.null_ls')

--@see [config options](https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md).
null_ls.setup({
  sources = pop_unavailable_sources(sources),
})
