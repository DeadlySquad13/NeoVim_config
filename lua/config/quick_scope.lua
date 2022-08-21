local constants = require('constants')
local bt, ft = constants.buftypes, constants.filetypes
local list_deep_extend = require('utils').list_deep_extend

return {
  qs_buftype_blacklist = list_deep_extend(bt.unmodifiable, bt.terminals),
  qs_filetype_blacklist = list_deep_extend(ft.unmodifiable, ft.filetrees),
}
