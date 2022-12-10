local env = require('constants.env')
local convert_to_runtimepath = require('utils').convert_to_runtimepath
local edit_file = require('utils').edit_file

--- Open lua module: if only one file exists, jump to it immediately, otherwise
-- open directory.
---@param path (string) Absolute.
---@return unknown
local function open_lua_module(path)
  local path_relative_to_runtimepath = convert_to_runtimepath(path)
  local files = vim.api.nvim_get_runtime_file(
    path_relative_to_runtimepath .. '/*.lua',
    true
  )

  -- Can just jump to file, it's anyway the only one existing.
  if #files == 1 then
    return edit_file(files[1])
  end

  return require('telescope.builtin').find_files({ cwd = path })
end

local function traverse_keymappings()
  return open_lua_module(env.NVIM_KEYMAPPINGS)
end

local function open_plugins()
  edit_file(env.NVIM_PLUGINS)
end

local function open_layers_specification()
  edit_file(env.NVIM_LAYERS_SPECIFICATION)
end

local function open_vimrc()
  edit_file('$MYVIMRC')
end

local function open_config()
  open_lua_module(env.NVIM_LUA_CONFIG)
end

local function open_general_settings()
  edit_file(env.NVIM_GENERAL_SETTINGS)
end

local function traverse_layers()
  open_lua_module(env.NVIM_LAYERS)
end

local function traverse_autocommands()
  open_lua_module(env.NVIM_AUTOCOMMANDS)
end

local function open_goneovim_settings()
  edit_file(env.GONEOVIM_SETTINGS)
end

local function traverse_after()
  open_lua_module(env.NVIM_AFTER)
end

local function traverse_commands()
  open_lua_module(env.NVIM_COMMANDS)
end

local edit_actions = {
  keymappings = traverse_keymappings,
  plugins = open_plugins,
  layers_specification = open_layers_specification,
  vimrc = open_vimrc,
  config = open_config,
  general_settings = open_general_settings,
  layers = traverse_layers,
  autocommands = traverse_autocommands,
  goneovim = open_goneovim_settings,
  after = traverse_after,
  commands = traverse_commands,
}

local edit_targets = {}

local i = 0

for edit_target, _ in pairs(edit_actions) do
  i = i + 1
  edit_targets[i] = edit_target
end

local choose_and_edit_target = function()
  vim.ui.select(edit_targets, {
    prompt = 'Choose target to edit',
    telescope = require('telescope.themes').get_dropdown(),
  }, function(selected)
    if not selected then
      return
    end
    edit_actions[selected]()
  end)
end

return choose_and_edit_target
