-- PATH environment variables defined specifically for vim.
--   Directory variables should end without trailing slash.
local home = vim.fn.getenv('HOME')
local user_config = home .. '/.config'

local namespace = 'ds_omega'

-- Resolves to `~/.local/share/nvim`.
local nvim_data = vim.fn.stdpath('data')

local nvim_config = vim.fn.stdpath('config')
local nvim_lua = nvim_config .. '/lua'
local nvim_general_settings = nvim_lua .. '/general_settings.lua'
local nvim_plugins = nvim_lua .. '/plugins.lua'
local nvim_layers_specification = nvim_lua .. '/layers_specification.lua'
local nvim_autocommands = nvim_lua .. '/autocommands'
local nvim_constants = nvim_lua .. '/constants' -- Separate and move to config / layer system?
local nvim_lua_config = nvim_lua .. '/ds_omega/config'
local nvim_keymappings = nvim_lua_config .. '/keymappings'
local nvim_commands = nvim_lua_config .. '/commands'

local nvim_layers = nvim_lua .. '/' .. namespace .. '/layers'
local nvim_after = nvim_config .. '/after'
local nvim_queries = nvim_after .. '/queries'

local goneovim_settings = user_config .. '/goneovim/settings.toml'

---@type table<'file'|'messages'|'notify', boolean>
LOG_INTO = require('ds_omega.utils.set').Set({
  -- 'file',
  'messages',
  -- 'notify'
})

return {
  HOME = home,
  USER_CONFIG = user_config,

  NAMESPACE = namespace,

  -- Directory where all supplementary data files are stored, such as: undo
  -- history, spell files, sessions...
  NVIM_DATA = nvim_data,

  NVIM_CONFIG = nvim_config,
  NVIM_GENERAL_SETTINGS = nvim_general_settings,
  NVIM_LUA = nvim_lua,
  NVIM_PLUGINS = nvim_plugins,
  NVIM_LAYERS_SPECIFICATION = nvim_layers_specification,
  NVIM_AUTOCOMMANDS = nvim_autocommands,
  NVIM_CONSTANTS = nvim_constants,
  NVIM_LUA_CONFIG = nvim_lua_config,
  NVIM_KEYMAPPINGS = nvim_keymappings,
  NVIM_COMMANDS = nvim_commands,

  NVIM_LAYERS = nvim_layers,
  NVIM_AFTER = nvim_after,
  NVIM_QUERIES = nvim_queries,

  GONEOVIM_SETTINGS = goneovim_settings,
}
