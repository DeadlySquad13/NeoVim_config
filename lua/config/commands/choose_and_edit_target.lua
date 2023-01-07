local env = require('constants.env')
local convert_to_runtimepath = require('utils').convert_to_runtimepath
local edit_file = require('utils').edit_file

-- TODO: Make default_text as regex.

--- Open lua module: if only one file exists, jump to it immediately, otherwise
-- open directory in file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@return unknown
local function open_lua_module(path, opts)
  local path_relative_to_runtimepath = convert_to_runtimepath(path)
  local files = vim.api.nvim_get_runtime_file(
    path_relative_to_runtimepath .. '/*.lua',
    true
  )

  -- Can just jump to file, it's anyway the only one existing.
  if #files == 1 then
    return edit_file(files[1])
  end

  local picker = require('telescope').extensions.file_browser.file_browser

  return picker(vim.tbl_extend('force', { cwd = path }, opts or {}))
end

---  Depending on target uses appropriate callback.
-- If it's file - opens it, if it's directory - opens file_browser.
---@param path (string) Absolute path.
---@param opts (table | nil) Telescope picker options.
---@return unknown
local function open(path, opts)
  if vim.fn.isdirectory(path) == 0 then
    return edit_file(path)
  end

  return open_lua_module(path, opts)
end

local function traverse_keymappings()
  return open_lua_module()
end

local function open_plugins()
  edit_file()
end

local function open_layers_specification()
  edit_file()
end

local function open_vimrc()
  edit_file()
end

local function open_config()
  open_lua_module()
end

local function open_general_settings()
  edit_file()
end

local function traverse_layers()
  open_lua_module()
end

local function traverse_autocommands()
  open_lua_module()
end

local function open_goneovim_settings()
  edit_file(env.GONEOVIM_SETTINGS)
end

local function traverse_after()
  open_lua_module()
end

local function traverse_commands()
  open_lua_module()
end

local gui_settings_paths = {
  goneovim = env.GONEOVIM_SETTINGS,
  fvim = env.GONEOVIM_SETTINGS,
}

local gui_settings_targets = {}

for gui_settings_target, _ in pairs(gui_settings_paths) do
  table.insert(gui_settings_targets, gui_settings_target)
end

local choose_and_edit_gui_settings = function()
  vim.ui.select(gui_settings_targets, {
    prompt = 'Choose gui settings to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end
    edit_file(gui_settings_paths[selected])
  end)
end

---@class Item
---@field path (string) Path (can be at first index).
---@field opts (table | nil) Telescope picker options.

---@type table<string, Item>
local items = {
  keymappings = { env.NVIM_LUA, opts = { default_text = 'keymappings' } },
  plugins = { env.NVIM_PLUGINS },
  layers_specification = { env.NVIM_LAYERS_SPECIFICATION },
  vimrc = { '$MYVIMRC' },
  config = { env.NVIM_LUA_CONFIG },
  general_settings = { env.NVIM_GENERAL_SETTINGS },
  layers = { env.NVIM_LAYERS },
  autocommands = { env.NVIM_AUTOCOMMANDS },
  gui = choose_and_edit_gui_settings,
  after = { env.NVIM_AFTER },
  commands = { env.NVIM_LUA, opts = { default_text = 'commands' } }
}

local choose_and_edit_target = function()
  vim.ui.select(vim.tbl_keys(items), {
    prompt = 'Choose target to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end

    local selected_item = items[selected]

    if type(selected_item) == 'function' then
      return selected_item() 
    end

    local path = selected_item[1] or selected_item.path
    local opts = selected_item.opts

    open(path, opts)
  end)
end

return choose_and_edit_target
