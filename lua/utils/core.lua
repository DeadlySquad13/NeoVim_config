local packer = require('packer')

local layer_utils = {}
layer_utils.use_plugin = function(plugin_settings, plugin_config)
  local configuration = vim.tbl_extend(
    'error',
    plugin_settings,
    { config = plugin_config }
  )
  packer.use(configuration)
end

--- Allows to use custom functions inside (removed custom override).
---@param specification
---@return
local function startup(specification)
  local plugins_callback = specification[1]
  local plugins_config = specification.config
  local layers = specification.layers

  packer.init(plugins_config)
  packer.reset()

  setfenv(
    plugins_callback,
    vim.tbl_extend('force', getfenv(), {
      use = packer.use,
      use_plugin = layer_utils.use_plugin,
      use_rocks = packer.use_rocks,
    })
  )
  local status, err = pcall(
    plugins_callback,
    packer.use,
    layer_utils.use_plugin,
    packer.use_rocks
  )

  for layer_name, layer_plugins in pairs(layers) do
    local Layer = require('ds_omega.layers.' .. layer_name)

    for _, plugin_name in ipairs(layer_plugins) do
      layer_utils.use_plugin(
        Layer.plugins[plugin_name],
        Layer.configs[plugin_name]
      )
    end
  end

  if not status then
    log.error('Failure running setup function: ' .. vim.inspect(err))
    error(err)
  end

  if plugins_config.snapshot ~= nil then
    packer.rollback(plugins_config.snapshot)
  end

  return packer
end

return {
  startup = startup,
}
