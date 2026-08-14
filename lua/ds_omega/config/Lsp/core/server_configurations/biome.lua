local lsp_handlers = require('ds_omega.config.Lsp.core.handlers')

setup_sort_imports_command = function(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspBiomeFixAll', function()
    -- client:request_sync('workspace/executeCommand', {
    --   -- Source: https://biomejs.dev/assist/actions/organize-imports/#how-to-enable-in-your-editor
    --   command = 'source.organizeImports.biome',
    --   arguments = {
    --     {
    --       uri = vim.uri_from_bufnr(bufnr),
    --       version = vim.lsp.util.buf_versions[bufnr],
    --     },
    --   },
    -- }, nil, bufnr)
    vim.lsp.buf.code_action({
      context = {
        -- only = { "source.organizeImports.biome" },
        only = { "source.fixAll.biome" },
        diagnostics = {},
      },
      apply = true,
    })
  end, {})
end

local function format_with_biome()
  vim.lsp.buf.format({
    filter = function(client) return client.name == 'biome' end,
  })
end


local function setup_biome_server_keymappings(_, bufnr)
  local apply_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_keymappings

  local mappings = {}
  mappings.n = {
    -- TODO: Compose two fix all's into one keymapping (use override
    -- keymappings plugin).
    ['<Space>fb'] = { require('ds_omega.config.keymappings._common.utils').cmd 'LspBiomeFixAll', 'Fix all (Biome)' },
    -- Otherwise conflicts with vtsls
    ['<Space>fn'] = { format_with_biome, 'Format (Biome)' },
  }

  ---@type DefaultKeymapOptions
  local options = {
    buffer = bufnr,
  }

  apply_keymappings('n', mappings.n, options)
end

return {
  on_attach = {
    setup_sort_imports_command,
    setup_biome_server_keymappings,
    -- INFO: Doesn't seem to work. Maybe it's because actual messages are
    -- intercepted by none_ls.
    lsp_handlers.populate_workspace_diagnostics,
  },
}
