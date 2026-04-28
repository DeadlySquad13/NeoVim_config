------------------------------------------------------------------
-- General purpose utils (mostly used for writing pretty code). --
------------------------------------------------------------------

-- Shortcut for printing variables in a meaningless way: showing contents of a
--   table via vim.inspect. Used log as console.log in js works pretty the same
--   way.
local function log(data)
  vim.print(data)
end

--- Check type of a vule
---@param value (unknown)
---@return (boolean) is function
local function is_function(value)
  return type(value) == 'function'
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
---@return (function) # New function with default parameters.
local function fancyparams(arg_def, f)
  return function(args)
    -- If function was called without params at all.
    args = args or {}

    local params = {}
    for i = 1, #arg_def do
      -- The name of the first parameter to the function
      local paramname = arg_def[i][1]
      local default_value = arg_def[i][2]
      params[i] = args[i] or args[paramname] or default_value
    end
    return f(unpack(params, 1, #arg_def))
  end
end

local function apply_global_variables(global_variables)
  for name, value in pairs(global_variables) do
    vim.g[name] = value
  end
end

---@type 'packer' | 'lazy'
local CURRENT_PLUGIN_MANAGER = 'lazy'

local function exists_in_packer_spec(plugin_name)
  return packer_plugins and packer_plugins[plugin_name]
end

local function is_loaded_in_packer_spec(plugin_name)
  return exists(plugin_name) and packer_plugins[plugin_name].loaded
end

-- Not sure if it's lazy specific way.
local function is_loaded_in_lazy_spec(plugin_name)
  local plugin = package.loaded[plugin_name]

  return plugin and not vim.tbl_isempty(plugin)
end

local function exists(plugin_name)
  if CURRENT_PLUGIN_MANAGER == 'packer' then
    return exists_in_packer_spec(plugin_name)
  elseif CURRENT_PLUGIN_MANAGER == 'lazy' then
    print("Function 'exists' is not implemented for lazy")
    return nil
  end
end

local function is_loaded(plugin_name)
  if CURRENT_PLUGIN_MANAGER == 'packer' then
    return is_loaded_in_packer_spec(plugin_name)
  elseif CURRENT_PLUGIN_MANAGER == 'lazy' then
    return is_loaded_in_lazy_spec(plugin_name)
  end
end

--- Convert list to the table that you can use for fast index find.
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

--- Convert list of table items to the index by certain iteratee 
--- so that you can use for fast find.
---@generic T : table
---@param list (table<T>) list of complex items.
---{
---  { name = 'a', value = 1 },
---  { name = 'b', value = 2 },
---  { name = 'c', value = 3 }
---}.
---@param iteratee (string|(fun(value: T): string)) name of the field or a function to create a key for an element.
---@return (table<string, T>) table #table of items indexed by the key derived by applying iteratee.
---IndexBy(list, 'name') = {
---  a = { name = 'a', value = 1 },
---  b = { name = 'b', value = 2 },
---  c = { name = 'c', value = 3 }
---}
---
---IndexBy(list, function(t) return t.name .. t.value) = {
---  a1 = { name = 'a', value = 1 },
---  b2 = { name = 'b', value = 2 },
---  c3 = { name = 'c', value = 3 }
---}
local function IndexBy(list, iteratee)
  local index = {}

  local iteratee_fn = is_function(iteratee) and iteratee or function(t) return t[iteratee] end

  for item in pairs(list) do
    local key = iteratee_fn(item)
    index[key] = item
  end

  return index
end

---Create a function that runs functions passed in the argument.
--They will be called in the same order that they were passed in.
--Useful for calling multiple `on_attach` functions.
---@vararg (function) variable number of functions
---@return (function) composed function that will run all functions (accepts
--variable number of arguments).
local function apply_all(...)
  local fns = { ... }

  return function(...)
    for _, fn in ipairs(fns) do
      fn(...)
    end
  end
end

--- Composes functions from right to left.
---compose(f1, f2, ..., fn) returns a function that, when called,
---applies fn, then fn-1, ..., finally f1 to the arguments.
---@vararg (function) variable number of functions
---@return (function) composed Returns the composed function or identity function if no arguments are given.
local function compose(...)
    local funcs = { ... }
    local n = #funcs

    if n == 0 then
        -- Identity function: returns whatever arguments it receives.
        return function(...) return ... end
    end

    return function(...)
        local result = { ... }
        -- Apply functions from last to first
        for i = n, 1, -1 do
            local f = funcs[i]
            -- Unpack the current result as arguments to f
            result = { f(table.unpack(result)) }
        end
        -- Return the final result(s), unpacking the table
        return table.unpack(result)
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

--- Map keys of a table.
---@param iteratee (fun(value: any, key: string, table: table): string) function to transform keys of a table.
---@param table (table) Dict-like table.
---@return (any) element
local function tbl_map_keys(iteratee, table)
  local result = {}

  for key, value in pairs(table) do
    result[iteratee(value, key, table)] = value
  end

  return result
end

--- Map values of a table.
---@param iteratee (fun(value: any, key: string, table: table): any) function to transform values of a table.
---@param table (table) Dict-like table.
---@return (any) element
local function tbl_map_values(iteratee, table)
  local result = {}

  for key, value in pairs(table) do
    result[key] = iteratee(value, key, table)
  end

  return result
end


--- Extend list.
--Doesn't modify the initial list and accepts variable number of parameters.
---@param initial_list (any[]) List to extend.
---@vararg (any[]) Lists to extend with.
---@return (any[]) extended_list Extended list.
local function list_deep_extend(initial_list, ...)
  local args = { ... }
  local result = vim.deepcopy(initial_list)

  for _, values in ipairs(args) do
    vim.list_extend(result, values)
  end

  return result
end

--- Set mode.
---@param mode ('x') Mode to set. Currently only x mode is supported.
local function set_mode(mode)
  if mode == 'x' then
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v", true, false, true), 'x!', true)
  end
  print(string.format('set_mode: This mode (%s) is not supported yet', mode))
end

local M = {
  -- # Core
  -- Just reuses global prequire, left here for clarity in old modules.
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

  -- # Functional programming.
  apply_all = apply_all,
  compose = compose,
  fp = fancyparams,

  -- # File System.
  file = require('ds_omega.utils.file'),
  rename = require('ds_omega.utils.rename'),

  -- # Collections.
  IndexedSet = IndexedSet,
  IndexBy = IndexBy,

  -- * Collection utils. @see also `:h vim.tbl_*`.
  -- TODO: Remove any
  tbl_map_keys = tbl_map_keys,
  -- TODO: Remove any
  tbl_map_values = tbl_map_values,
  tbl_remove_key = tbl_remove_key,
  list_deep_extend = list_deep_extend,

  os = require('ds_omega.utils.os'),

  git = require('ds_omega.utils.git'),

  exec = require('ds_omega.utils.exec'),

  defer = require('ds_omega.utils.defer'),

  Set = require('ds_omega.utils.set').Set,

  SetIntersection = require('ds_omega.utils.set').SetIntersection,

  set_mode = set_mode,

  is_function = is_function,
}

return M
