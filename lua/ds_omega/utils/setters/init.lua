--- Set global variables `g:<variable>`.
--Mainly for vim plugins. In most cases plugin settings have
--prefix so all variables will be `g:<pluginPrefix>_<variable> `.
---@param variables (table)
---@param prefix? (string) Is prepended with underscore to every variable.
local function set_global_variables(variables, prefix)
  for name, value in pairs(variables) do
    vim.g[not prefix and name or string.format('%s_%s', prefix, name)] = value;
  end
end

--- Set vim settings.
--You can use variables in lua fashion (instead of
--'shift:20,min:20' -> { shift = 20, min = 20 }).
---@param settings (table)
local function set_settings(settings)
  for name, value in pairs(settings) do
    vim.opt[name] = value
  end
end

--- Set local vim settings.
--You can use variables in lua fashion (instead of
--'shift:20,min:20' -> { shift = 20, min = 20 }).
---@param settings (table)
local function set_local_settings(settings)
  for name, value in pairs(settings) do
    vim.opt_local[name] = value
  end
end

return {
  set_global_variables = set_global_variables,
  set_settings = set_settings,
  set_local_settings = set_local_settings,
}
