---@class PluginManagerSettings plugin manager settings for the plugin

---@field lua_module (string) Lua module to require during initialization of the plugin.

---@class Module
---@field plugins (table<string, PluginManagerSettings>) Plugin manager settigns for the module.
---@field configs (table<string, table>) Configurations for the mdoule.
