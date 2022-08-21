local function safe_read(filename, read_quantifier)
  local file, err = io.open(filename, 'r')
  if not file then
    return error(err)
  end

  local content = file:read(read_quantifier)
  io.close(file)
  return content
end

--- Reads files in array one by one.
---@param filenames (string[]) Array of file paths to read.
---@return (string) concatenated_file File with concatenated content of all files.
-- TODO: change to read_files.
local function read_query_files(filenames)
  local contents = {}

  for _, filename in ipairs(filenames) do
    table.insert(contents, safe_read(filename, '*a'))
  end

  return table.concat(contents, '')
end

local get_query_files = vim.treesitter.query.get_query_files

local ENV = require('constants.env')

---@see `:h get_query_files` for params.
local function read_local_query_files(lang, query_name)
  return read_query_files({
    ENV.NVIM_QUERIES .. '/' .. lang .. '/' .. query_name .. '.scm',
  })
end

-- Search for queries in
-- $PACKER/opt/nvim-treesitter/queries/<lang>/highlights.scm
local set_query = vim.treesitter.query.set_query

return {
  get_query_files = get_query_files,

  safe_read = safe_read,
  read_query_files = read_query_files,

  read_local_query_files = read_local_query_files,

  set_query = set_query,
}
