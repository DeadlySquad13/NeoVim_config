---------------------------------------------------------------------------------
------------------------------ File System utils. -------------------------------
---------------------------------------------------------------------------------

---  Most of the basic file system related functionality is implemented in neovim.
-- This module aims to integrate different plugins (mostly telescope) with
-- neovim's api.

local file = {}

file.edit_file = function(path)
  return vim.cmd('e ' .. path)
end

---  Converts path to runtimepath (see `:h runtimepath`) or more specifically to
-- stdpath('config') (see `:h stdpath`).
---@param path (string) Absolute path, for example:
-- `home/dubuntus/.config/nvim/lua/config/incline.lua`
---@return (string) path Path that's truncated at the beginning (as if starting relatively
-- from stdpath('config')):
-- `lua/config/incline.lua`.
file.convert_to_runtimepath = function(path)
  local path_with_truncated_runtimepath = string.gsub(
    path,
    vim.fn.stdpath('config'),
    ''
  )

  -- Removing first slash.
  return path_with_truncated_runtimepath:sub(2)
end
---  Checks if the given path points to a lua module (folder with init.lua
-- inside)
---@param path (string) Absolute path, for example:
-- `home/dubuntus/.config/nvim/lua/config/incline`
---@return (boolean)
file.is_lua_module = function(path)
  local path_relative_to_runtimepath = file.convert_to_runtimepath(path)
  local files_found = vim.api.nvim_get_runtime_file(path_relative_to_runtimepath .. '/init.lua', false) -- Return when a first match found.

  return not vim.tbl_isempty(files_found)
end

-- TODO: Make default_text as regex.
-- TODO: Expand lua_module to other modules as well.

--- Open lua module: if only one file exists, jump to it immediately, otherwise
-- open directory in file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@param search_tabs_opts (table | nil) Search.nvim specific options (will be applied only if search.nvim is available).
---@return unknown
file.open_lua_module = function(path, opts, search_tabs_opts)
  local path_relative_to_runtimepath = file.convert_to_runtimepath(path)
  local files = vim.api.nvim_get_runtime_file(
    path_relative_to_runtimepath .. '/*.lua',
    true
  )

  -- Can just jump to file, it's anyway the only one existing.
  if #files == 1 then
    return file.edit_file(files[1])
  end

  local telescope_picker_opts = vim.tbl_extend('force', { cwd = path }, opts)

  local search_tabs_is_available = prequire('search')

  if search_tabs_is_available then
    local search_tabs = require('search')

    local default_search_tabs_opts = {
      collection = 'files_minimal',
      tab_name = 'Files',
      -- Our custom field.
      collection_tele_opts = telescope_picker_opts,
    }

    return search_tabs.open(
      vim.tbl_extend('force', default_search_tabs_opts, search_tabs_opts)
    )
  end

  local picker = require('telescope.builtin').find_files

  return picker(telescope_picker_opts)
end

---  Depending on target uses appropriate callback.
-- If it's file - opens it, if it's directory - opens file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@param search_tabs_opts (table | nil) Search.nvim specific options (will be applied only if search.nvim is available).
---@return unknown
file.open = function(path, opts, search_tabs_opts)
  if vim.fn.isdirectory(path) == 0 then
    return file.edit_file(path)
  end

  return file.open_lua_module(path, opts, search_tabs_opts)
end

return file
