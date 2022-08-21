-- PATH environment variables defined specifically for vim.
--   Directory variables should end without trailing slash.
local home = vim.fn.getenv('HOME')

local namespace = 'ds_omega'

-- Resolves to `~/.local/share/nvim`.
local nvim_data = vim.fn.stdpath('data')

local nvim_config = vim.fn.stdpath('config')
local nvim_lua = nvim_config .. '/lua'
local nvim_general_settings = nvim_lua .. '/general_settings.lua'
local nvim_plugins = nvim_lua .. '/plugins.lua'
local nvim_layers_specification = nvim_lua .. '/layers_specification.lua'
local nvim_autocommands = nvim_lua .. '/autocommands'
local nvim_lua_config = nvim_lua .. '/config'
local nvim_keymappings = nvim_lua_config .. '/keymappings'

local nvim_layers = nvim_lua .. '/' .. namespace .. '/layers'
local nvim_queries = nvim_lua_config .. '/queries'

return {
  HOME = home,

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
  NVIM_LUA_CONFIG = nvim_lua_config,
  NVIM_KEYMAPPINGS = nvim_keymappings,

  NVIM_LAYERS = nvim_layers,
  NVIM_QUERIES = nvim_queries,
}
