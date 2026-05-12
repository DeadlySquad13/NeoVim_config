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

local chats = {
  "opencode",
  'opencode_output',
  'Avante',
  'copilot-chat',
}

-- Every filetype that is rendered as markdown.
local markdown_dialects = vim.list_extend({
  "opencode",
  'opencode_output',
  'Avante',
  'copilot-chat',
}, {
  "markdown",
})

return {
  start_screens = start_screens,
  filetrees = filetrees,
  unmodifiable = unmodifiable,
  chats = chats,
  markdown_dialects = markdown_dialects,
}
