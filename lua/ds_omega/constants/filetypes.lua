local list_deep_extend = require('ds_omega.utils').list_deep_extend

local start_screens = { 'startify', 'dashboard' }
local filetrees = {
  'neo-tree',
  'nvimtree',
  'nerdtree',
  'chadtree',
  'fern',
}
local unmodifiable = list_deep_extend({ 'qf' }, start_screens)

return {
  filetrees = filetrees,
  unmodifiable = unmodifiable,
}
