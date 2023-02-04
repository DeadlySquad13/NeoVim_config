--- Add folder to the list of possible paths which is used during module
--requirement.
-- It will be added as a simple module pattern (either `path.lua` or
--`path/init.lua`).
---@param path (string) # Folder to add.
local function append_to_package_path(path)
  package.path = path .. '/?.lua;' .. path .. '/?/init.lua;' .. package.path
end

append_to_package_path(require('constants.env').NVIM_AFTER)
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
