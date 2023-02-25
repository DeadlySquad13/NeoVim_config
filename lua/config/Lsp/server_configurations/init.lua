local servers_with_custom_configurations = {
  'lua_ls',
  'pyright',

  -- * Web Development.
  'tsserver',
  'cssls',
  'html',
  'eslint',
  'jsonls',

  'texlab',
  'gopls',
  'r_language_server',
  -- bashls,

  -- Conflicts with prettier formatting in TS files.
  -- stylelint_lsp,
}

local custom_server_configurations = {}
for _, server_name in ipairs(servers_with_custom_configurations) do
  custom_server_configurations[server_name] = require('config.lsp.server_configurations' .. '.' .. server_name)
end

return custom_server_configurations
