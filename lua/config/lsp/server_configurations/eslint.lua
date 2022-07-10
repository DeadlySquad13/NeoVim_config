local function setup_eslint_server_keymappings(_, bufnr)
  local apply_keymappings = require('config.which_key.utils').apply_keymappings

  local mappings = {}
  mappings.n = {
    ['<space>fl'] = { '<cmd>EslintFixAll<cr>', 'Lint' },
  }

  ---@type DefaultKeymapOptions
  local options = {
    buffer = bufnr,
  }

  apply_keymappings(mappings.n, 'n', options)
end

return {
  on_attach = {
    setup_eslint_server_keymappings
  }
}
