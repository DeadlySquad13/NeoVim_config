require('general_settings')
require('config.commands')
require('autocommands')
local colorschemas = require('config.theme')
require('ds_omega.utils').load_coloscheme(
  colorschemas.COLORSCHEME_NAME,
  colorschemas.BACKUP_COLORSCHEME_NAME,
  colorschemas.FALLBACK_COLORSCHEME_NAME
)
require('plugins')
