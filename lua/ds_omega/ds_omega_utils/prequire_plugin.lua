local function prequire_plugin(plugin_name)
  local plugin_is_available, plugin = prequire(plugin_name)

  if not plugin_is_available then
    notify(
      'Plugin `' .. plugin_name .. '` does not exist!',
      vim.log.levels.ERROR,
      {
        title = 'Core',
      }
    )
  end

  return plugin_is_available, plugin
end

return prequire_plugin
