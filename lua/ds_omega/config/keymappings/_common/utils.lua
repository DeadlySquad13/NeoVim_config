local M = {}

M.cmd = require('hydra.keymap-util').cmd
M.pcmd = require('hydra.keymap-util').pcmd

-- @param prefix (string)
-- @param keymappings (table)
M.add_prefix = function(prefix, keymappings)
  local result = {}

  for key, keymapping in pairs(keymappings) do
    result[prefix .. key] = keymapping
  end

  return result
end

return M
