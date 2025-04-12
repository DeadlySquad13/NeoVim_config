---@type table<string, table<'COLORSCHEME_NAME'|'BACKUP_COLORSCHEME_NAME'|'FALLBACK_COLORSCHEME_NAME', string>>
local M = {}

M.default = {
  COLORSCHEME_NAME = 'deadly-gruv',
  BACKUP_COLORSCHEME_NAME = 'gruvbox-material',
  FALLBACK_COLORSCHEME_NAME = 'shine',
}

M.browser = {
  COLORSCHEME_NAME = 'shine',
  BACKUP_COLORSCHEME_NAME = 'shine',
  FALLBACK_COLORSCHEME_NAME = 'shine',
}

return M
