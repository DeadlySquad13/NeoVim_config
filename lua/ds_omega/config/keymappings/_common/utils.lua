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

M.merge = function(a, b)
    if type(a) ~= 'table' or type(b) ~= 'table' then
        return a
    end

    local result = vim.deepcopy(a)
    for k, v in pairs(b) do
        if type(v) == 'table' and type(result[k] or false) == 'table' then
            M.merge(result[k], v)
        else
            result[k] = v
        end
    end

    return result
end

return M
