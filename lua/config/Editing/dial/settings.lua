local prequire = require('utils').prequire

local augend_is_available, augend = prequire('dial.augend')

if not augend_is_available then
  return
end

return {
  -- default augends used when no group name is specified
  default = {
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
  },
}
