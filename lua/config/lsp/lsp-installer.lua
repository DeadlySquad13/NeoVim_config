local prequire = require('utils').prequire

local lsp_installer_is_available, lsp_installer = prequire('nvim-lsp-installer')

if not lsp_installer_is_available then
  return
end

lsp_installer.setup({})

