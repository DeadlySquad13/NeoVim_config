local packer = require('packer')
local SetIntersection = require('utils').SetIntersection

local layer_utils = {}
--- 
---@param plugin_settings (table)
---@param plugin_config (table | nil)
---@param layer_ft (table | nil)
---@param module_ft (table | nil)
layer_utils.use_plugin = function(plugin_settings, plugin_config, layer_ft, module_ft)
  local configuration = vim.tbl_extend(
    'error',
    plugin_settings,
    { config = plugin_config }
  )

  -- Can only narrow each other:
  --   predefined plugin configuration ft >= layer ft >= module ft.
  configuration.ft = SetIntersection(SetIntersection(configuration.ft, layer_ft), module_ft)

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

  for layer_name, layers_specification in pairs(layers) do
    local Layer = require('ds_omega.layers.' .. layer_name)

    -- ipairs will iterate only over numeric indices (plugins).
    for _, plugin in ipairs(layers_specification) do
      local plugin_name
      if type(plugin) == 'table' then
        plugin_name = plugin[1]
      else
        plugin_name = plugin
      end

      layer_utils.use_plugin(
        Layer.plugins[plugin_name],
        Layer.configs and Layer.configs[plugin_name] or nil,
        layers_specification.ft
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
