-- PATH environment variables defined specifically for vim.
--   Directory variables should end without trailing slash.
local home = vim.fn.getenv('HOME');

-- Resolves to `~/.local/share/nvim`.
local nvim_data = vim.fn.stdpath('data');

local nvim_home = home .. '/.config/nvim';
local nvim_lua = nvim_home .. '/lua';
local nvim_plugins = nvim_lua .. '/plugins.lua';
local nvim_lua_config = nvim_lua .. '/config';
local nvim_keymappings = nvim_lua_config .. '/keymappings';

local npm_global_modules = home .. '/.npm-global/lib/node_modules';
local npm_global_bin = home .. '/.npm-global/bin';

return {
  HOME = home,

  -- Directory where all supplementary data files are stored, such as: undo
  -- history, spell files, sessions...
  NVIM_DATA = nvim_data,

  NVIM_HOME = nvim_home,
  NVIM_LUA = nvim_lua,
  NVIM_PLUGINS = nvim_plugins,
  NVIM_LUA_CONFIG = nvim_lua_config,
  NVIM_KEYMAPPINGS = nvim_keymappings,

  NPM_GLOBAL_MODULES = npm_global_modules,
  NPM_GLOBAL_BIN = npm_global_bin,
}
