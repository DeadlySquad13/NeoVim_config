local prequire = require('utils').prequire

local lspconfig_is_available, lspconfig = prequire('lspconfig')
if not lspconfig_is_available then
  return
end

require('config.lsp.lsp-installer')
local server_configurations = require('config.lsp.server_configurations')
local default_server_configuration = require(
  'config.lsp.server_configurations.default'
)

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

    lspconfig[server_name].setup(server_configuration)
  end
end

setup_lsp_servers()

--local ENV = require('global');
-- Setup lspconfig.
--require('nvim-lsp-installer').setup {}
--local lspconfig = require('lspconfig')
--local capabilities, on_attach = require('config.lsp.handlers')
--lspconfig.sumneko_lua.setup {}
--lspconfig.pylsp.setup {}
--local configs = require('lspconfig.configs')

-- local servers = { 'pylsp', 'tsserver', 'vimls' }

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- * Python.
--lspconfig.pylsp.setup {
--on_attach = on_attach,
--settings = {
--pylsp = {
--plugins = {
--pylint = { enabled = true, executable = "pylint" },
--pyflakes = { enabled = false },
--pycodestyle = { enabled = false },
--jedi_completion = { fuzzy = true },
--pyls_isort = { enabled = true },
--pylsp_mypy = { enabled = true },
--}
--}
--},
--capabilities = capabilities
--}

---- * Typescript.
--lspconfig.tsserver.setup {
---- Default values.
--cmd = { ENV:PATH().npm_global_bin .. '/typescript-language-server', "--stdio" },
--filetypes = {
--"javascript", "javascriptreact", "typescript", "typescriptreact"
--},
--init_options = {
--hostInfo = "neovim"
--},
---- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),

--capabilities = capabilities,
--}

---- * Vim.
--lspconfig.vimls.setup {
--cmd = { ENV:PATH().npm_global_modules .. '/vim-language-server/bin/index.js', '--stdio' },

--capabilities = capabilities,

--filetypes = { "vim" },
--init_options = {
--diagnostic = {
--enable = true
--},
---- If you want to speed up index, change gap to smaller and count to
---- greater, this will cause high CPU usage for some time.
--indexes = {
---- Count of files index at the same time.
--count = 3,
---- Index time gap between next file.
--gap = 100,
--projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
---- Index vim's runtimepath files.
--runtimepath = true
--},
--iskeyword = "@,48-57,_,192-255,-#",
--runtimepath = "",
--suggest = {
--fromRuntimepath = true,
--fromVimruntime = true
--},
--vimruntime = ""
--},
--}

---- * Linters (diagnostics).
--lspconfig.diagnosticls.setup {
--capabilities = capabilities,
--cmd = { ENV:PATH().npm_global_bin .. '/diagnostic-languageserver', "--stdio" },

--filetypes = {
--"javascript", "javascriptreact", "typescript", "typescriptreact", "css"
--},

--init_options = {
--filetypes = {
--javascript = "eslint",
--typescript = "eslint",
--javascriptreact = "eslint",
--typescriptreact = "eslint"
--},
--linters = {
--eslint = {
--sourceName = "eslint",
--command = "./node_modules/.bin/eslint",
--rootPatterns = {
--".eslitrc.js",
--".eslitrc",
--"package.json"
--},
--debounce = 100,
--args = {
--"--cache",
--"--stdin",
--"--stdin-filename",
--"%filepath",
--"--format",
--"json"
--},
--parseJson = {
--errorsRoot = "[0].messages",
--line = "line",
--column = "column",
--endLine = "endLine",
--endColumn = "endColumn",
--message = "${message} [${ruleId}]",
--security = "severity"
--},
--securities = {
--[2] = "error",
--[1] = "warning"
--}
--}
--},
--formatters = {
--prettier = {
--command = './node_modules/.bin/prettier',
--args = {'--stdin-filepath', '%filepath'},
--},
--eslint = {
--sourceName = "eslint",
--command = "./node_modules/.bin/eslint",
--rootPatterns = {
--".eslitrc.js",
--".eslitrc",
--"package.json"
--},
--debounce = 100,
--args = {
--"--cache",
--"--stdin",
--"--fix",
--"--stdin-filename",
--"%filepath",
--"--format",
--"json",
--},
--parseJson = {
--errorsRoot = "[0].messages",
--line = "line",
--column = "column",
--endLine = "endLine",
--endColumn = "endColumn",
--message = "${message} [${ruleId}]",
--security = "severity"
--},
--securities = {
--[2] = "error",
--[1] = "warning"
--}
--}
--},
--formatFiletypes = {
--javascript = 'prettier',
--javascriptreact = 'prettier',
--typescript = 'prettier',
--typescriptreact = 'eslint',
--json = 'prettier',
--scss = 'prettier',
--less = 'prettier',
--markdown = 'prettier',
--},
--}
--}

-- * Emmet.
--if not configs.ls_emmet then
--  configs.ls_emmet = {
--    default_config = {
--      cmd = { 'ls_emmet', '--stdio' };
--      filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
--        'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss'};
--      root_dir = function(fname)
--        return vim.loop.cwd()
--      end;
--      settings = {};
--    };
--  }
--end

--lspconfig.ls_emmet.setup{ capabilities = capabilities }
