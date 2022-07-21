--- Set global variables `g:<variable>`.
--Mainly for vim plugins.
---@param variables (table)
local function set_global_variables(variables)
  for name, value in pairs(variables) do
    vim.g[name] = value;
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

return {
  set_global_variables = set_global_variables,
  set_settings = set_settings,
}
