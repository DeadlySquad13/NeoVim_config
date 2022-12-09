local prequire = require('utils').prequire

local lspconfig_is_available, lspconfig = prequire('lspconfig')
if not lspconfig_is_available then
  return
end

require('ds_omega.layers.Lsp.lsp_installer')
local server_configurations = require('config.lsp.server_configurations')
local default_server_configuration = require(
  'config.lsp.server_configurations.default'
)

-- Should be Set.
_G.layer_specification_map = nil
local function get_module_specification(layer_specification, name)
  if not _G.layer_specification_map then
    _G.layer_specification_map = {}
    for module_index, module in ipairs(layer_specification) do
      local module_type = type(module)

      if module_type == 'string' then
        _G.layer_specification_map[module_index] = module
      elseif module_type == 'table' then
        _G.layer_specification_map[module[1]] = module
      end
    end
  end

  return _G.layer_specification_map[name]
end


local function get_module_enabled_filetypes()
  local SetIntersection = require('utils').SetIntersection
  local layer_specification = require('layers_specification')['Lsp']

  if not layer_specification then
    return nil
  end


  local module_specification = get_module_specification(layer_specification, 'lsp')
  if not module_specification then
    return layer_specification.ft
  end

  return SetIntersection(layer_specification.ft, module_specification.ft)
end

local lsp_server_name_to_filetypes = {
  cssls = { 'css' },
  eslint = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  html = { 'html' },
  jsonls = { 'json' },
  pylsp = { 'python' },
  pyright = { 'python' },
  sumneko_lua = { 'lua' },
  tsserver = { 'typescript', 'typescriptreact' },
  texlab = { 'tex' },
}

local enabled_filetypes = get_module_enabled_filetypes()
local function is_lsp_server_enabled(lsp_server_name)
  if not enabled_filetypes then
    return true
  end

  local lsp_server_filetypes = lsp_server_name_to_filetypes[lsp_server_name]

  local is_enabled = false
  for _, enabled_filetype in ipairs(enabled_filetypes) do
    is_enabled = vim.tbl_contains(lsp_server_filetypes, enabled_filetype)
    if is_enabled then
      break
    end
  end

  return is_enabled
end

local function add_custom_server_settings(configuration, custom_settings)
  if custom_settings then
    configuration.settings = vim.tbl_extend(
      'force',
      {}, --[[ configuration.settings ]]
      custom_settings
    )
  end
end

local compose = require('utils').compose

local function add_server_on_attach_addons(configuration, on_attach_addons)
  if on_attach_addons then
    configuration.on_attach = compose(
      configuration.on_attach,
      unpack(on_attach_addons)
    )
  end
end

local function setup_lsp_servers()
  for server_name, custom_server_configuration in pairs(server_configurations) do
    if is_lsp_server_enabled(server_name) then
      local server_configuration = default_server_configuration

      -- TODO: use classes.
      add_custom_server_settings(
        server_configuration,
        custom_server_configuration.settings
      )
      add_server_on_attach_addons(
        server_configuration,
        custom_server_configuration.on_attach
      )

      if server_name == 'eslint' then 
        local eslint_config = require("lspconfig.server_configurations.eslint")
        server_configuration.opts ={}
        server_configuration.opts.cmd = { "yarn", "exec", unpack(eslint_config.default_config.cmd) }
      end

      lspconfig[server_name].setup(server_configuration)
    end
  end
end

setup_lsp_servers()
