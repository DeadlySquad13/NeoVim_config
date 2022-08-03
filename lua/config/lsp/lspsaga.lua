local prequire = require('utils').prequire

local lspsaga_is_available, lspsaga = prequire('lspsaga')

if not lspsaga_is_available then
  return
end

lspsaga.init_lsp_saga()
