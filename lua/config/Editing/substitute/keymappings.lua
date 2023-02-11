local prequire = require('utils').prequire

local substitute_is_available, substitute = prequire('substitute')

if not substitute_is_available or not substitute then
  return
end

-- Though of substitute as replacement so 'r'.
return {
  n = {
    r = { substitute.operator, 'Substitute' },
    rs = { substitute.line, 'Substitute line' },
    R = { substitute.eol, 'Substitute to end of line' },
  },

  x = {
    r = { substitute.visual, 'Substitute', },
  },
}
