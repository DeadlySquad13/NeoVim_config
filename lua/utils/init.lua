------------------------------------------------------------------
-- General purpose utils (mostly used for writing pretty code). --
------------------------------------------------------------------
local env = require('global')

--- Prints prettily the data and returns it without any changes. Used for
-- testing.
---@param data any data.
---@return data without changes.
_G.P = function(data)
  vim.pretty_print(data)
  return data
end

--- Notify user with nvim.notify. If it is not available, fallback to
--vim.notify.
---@param message to display.
---@param level of notification (see `:h vim.log.levels`).
---@param opts additional options for nvim.notify visualization (see `:h
--notify.Options`).
_G.notify = function(message, level, opts)
  local nvim_notify_is_available, nvim_notify = pcall(require, 'notify')

  local notify = vim.notify
  if nvim_notify_is_available then
    notify = nvim_notify
  end

  notify(message, level, opts)
end

local function prequire(plugin_name)
  local plugin_loading_error_handler = function(error)
    notify(
      'Error in loading plugin ' .. plugin_name .. '!',
      vim.log.levels.ERROR
    )
  end

  local status_ok, plugin = xpcall(
    require,
    plugin_loading_error_handler,
    plugin_name
  )

  if not status_ok then
    return status_ok
  end

  return status_ok, plugin
end

-- Shortcut for printing variables in a meaningless way: showing contents of a
--   table via vim.inspect. Used log as console.log in js works pretty the same
--   way.
local function log(data)
  vim.pretty_print(data)
end

--- Creates new function with default parameters.
---@ref https://gist.github.com/stuartpb/975399
---@usage:
--- myfunction = fancyparams(
---   {{"a"},{"b",7},{"c",5}},
---   function(a, b, c)
---     print(a, b, c)
---   end
--- );
--- myfunction({ a = 8 )}; -- b and c have defaults!
---
---@param arg_def table with parameters with their default values.
---@param f function to which are default parameters are applied.
---@return new function with default parameters.
local function fancyparams(arg_def, f)
  return function(args)
    local params = {}
    for i = 1, #arg_def do
      local paramname = arg_def[i][1] --the name of the first parameter to the function
      local default_value = arg_def[i][2]
      params[i] = args[i] or args[paramname] or default_value
    end
    return f(unpack(params, 1, #arg_def))
  end
end

--- Converts path to runtimepath (see `:h runtimepath`) or more specifically to
-- stdpath('config') (see `:h stdpath`).
---@param path that looks like
--`home/dubuntus/.config/nvim/lua/config/incline.lua`
---@return path thats truncated at the beggining (as if starting relatively
-- from stdpath('config')):
-- `lua/config/incline.lua`.
local function convert_to_runtimepath(path)
  local path_with_truncated_runtimepath = string.gsub(
    path,
    vim.fn.stdpath('config'),
    ''
  )

  -- Removing first slash.
  return path_with_truncated_runtimepath:sub(2)
end

local function edit_file(path)
  return vim.cmd('e ' .. path)
end

local function apply_global_variables(global_variables)
  for name, value in pairs(global_variables) do
    vim.g[name] = value
  end
end

local function exists(plugin_name)
  return packer_plugins and packer_plugins[plugin_name]
end

local function is_loaded(plugin_name)
  return exists(plugin_name) and packer_plugins[plugin_name].loaded
end

--- Convert list to the table that you can use for fast find.
-- It is indexed so you can easily get index of the item in initial list. If
-- you work with large list, you may need `Set`.
---@param list (table) list of items { 'a', 'b', 'c' }.
---@return (table) table #table of items { 'a' = 1, 'b' = 2, 'c' = 3 }.
local function IndexedSet(list)
  local set = {}
  for i, item in ipairs(list) do
    set[item] = i
  end
  return set
end

---Create a function that runs functions passed in the argument.
--They will be called in the same order that they were passed in.
--Useful for composing multiple `on_attach` functions.
---@vararg (function) variable number of functions
---@return (function) composed function that will run all functions (accepts
--variable number of arguments).
local function compose(...)
  local fns = { ... }

  return function(...)
    for _, fn in ipairs(fns) do
      fn(...)
    end
  end
end

--- Pop element from table by key.
---@param table (table)
---@param key (string)
---@return (any) element
local function tbl_remove_key(table, key)
  local element = table[key]
  table[key] = nil
  return element
end

local M = {
  -- # Core
  prequire = prequire,

  -- # Printing and loggin.
  log = log,

  -- # Vim api.
  create_augroup = vim.api.nvim_create_augroup,
  create_autocmd = vim.api.nvim_create_autocmd,

  apply = {
    variables = {
      global = apply_global_variables,
    },
  },

  exists = exists,
  is_loaded = is_loaded,

  -- # File system.
  convert_to_runtimepath = convert_to_runtimepath,
  edit_file = edit_file,

  -- # Functional programming.
  compose = compose,
  fp = fancyparams,

  -- # Collections.
  IndexedSet = IndexedSet,

  -- * Collection utils.
  tbl_remove_key = tbl_remove_key,
}

--- Convert list to the table that you can use for fast find.
---@param list (table) list of items { 'a', 'b', 'c' }.
---@return (table) table #table of items { 'a' = true, 'b' = true, 'c' = true }.
M.Set = function(list)
  local set = {}
  for _, item in ipairs(list) do
    set[item] = true
  end
  return set
end

return M
