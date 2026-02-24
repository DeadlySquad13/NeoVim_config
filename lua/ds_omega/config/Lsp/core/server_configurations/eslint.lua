local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

local base = vim.tbl_get(vim.lsp.config, 'eslint', 'on_attach')

-- STYLE: Wish for a more functional-style approach.
local function base_on_attach(client, bufnr)

  if not base then
    return
  end

  base(client, bufnr)
end

local function setup_eslint_server_keymappings(_, bufnr)
  local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

  local mappings = {}
  if base then
    mappings.n = {
      ['<Space>fl'] = { require('ds_omega.config.keymappings._common.utils').cmd 'LspEslintFixAll', 'Fix all (Eslint)' },
    }
  end

  ---@type DefaultKeymapOptions
  local options = {
    buffer = bufnr,
  }

  apply_keymappings('n', mappings.n, options)
end
return {
  settings = {
    packageManager = 'yarn',
  },
  on_attach = {
    base_on_attach,
    setup_eslint_server_keymappings,
    -- INFO: Doesn't seem to work. Maybe it's because actual messages are
    -- intercepted by none_ls.
    lsp_handlers.populate_workspace_diagnostics,
  },
}
