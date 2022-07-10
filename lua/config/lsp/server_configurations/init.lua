local SERVER_CONFIGURATIONS = 'config.lsp.server_configurations'

local function require_server_configuration(server_name)
  return require(SERVER_CONFIGURATIONS .. '.' .. server_name)
end


local custom_server_configurations = {
  sumneko_lua = require_server_configuration('sumneko_lua'),
  pyright = require_server_configuration('pyright'),

  -- * Web Development.
  tsserver = require_server_configuration('tsserver'),
  cssls = require_server_configuration('cssls'),
  html = require_server_configuration('html'),
  eslint = require_server_configuration('eslint'),
  jsonls = require_server_configuration('jsonls'),

  -- bashls = default_server_config,

  -- Conflicts with prettier formatting in TS files.
  -- stylelint_lsp = utils.base_config_without_formatting,
}

return custom_server_configurations
