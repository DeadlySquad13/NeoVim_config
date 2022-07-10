local prequire = require('utils').prequire

local fidget_is_available, fidget = prequire('fidget')

if not fidget_is_available then
  return
end

fidget.setup({})
