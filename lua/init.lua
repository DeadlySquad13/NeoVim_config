--requirement.
-- It will be added as a simple module pattern (either `path.lua` or
--`path/init.lua`).
---@param path (string) # Folder to add.
local function append_to_package_path(path)
  package.path = path .. '/?.lua;' .. path .. '/?/init.lua;' .. package.path
end

append_to_package_path(require('ds_omega.constants.env').NVIM_AFTER)

-- ## Vanilla modules.
require('ds_omega.utils.global')
require('general_settings')
require('ds_omega.autocommands.restore_view').setup()

require('plugins')

-- ## Modules that depend on plugins.
-- TODO: Move to package manager specs as plugins with proper dependencies.
require('ds_omega.commands')
require('ds_omega.autocommands')
