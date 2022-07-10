-- These custom highlights will be set only in my themes.
-- By convention each theme should set this.
if not vim.g.colors_name == 'deadly-gruv' then
  return
end

local parsers_with_modified_queries = {
  'lua',
  'css',
  'typescript'
}

local QUERIES = 'config.queries'

--- 
---@param parser_name (string) Parser name (in most cases filetype).
---@see `:h treesitter-parsers`.
---@return 
local function require_queries(parser_name)
  return require(QUERIES .. '.' .. parser_name)
end

for _, parser in ipairs(parsers_with_modified_queries) do
  require_queries(parser)
end

