local M = {}

---@param command string
---@return string `<Cmd>..command..<CR>`
M.cmd = function(command)
    return table.concat({ '<Cmd>', command, '<CR>' })
end

---@param try_cmd string
---@param catch? string
---@param catch_cmd? string
M.get_pcmd = function(try_cmd, catch, catch_cmd)
    local pcommand = { 'try', try_cmd }
    if catch and catch:find('^E%d+$') then
        table.insert(pcommand, table.concat {
            'catch ', [[/^Vim\%((\a\+)\)\=:]], catch, [[:/]]
        })
    else
        table.insert(pcommand, 'catch')
    end
    if catch_cmd and catch_cmd ~= '' then
        table.insert(pcommand, catch_cmd)
    end
    table.insert(pcommand, 'endtry')
    return table.concat(pcommand, ' | ')
end

---@param try_cmd string
---@param catch? string
---@param catch_cmd? string
M.pcmd = function(try_cmd, catch, catch_cmd)
    return M.cmd(M.get_pcmd(try_cmd, catch, catch_cmd))
end

--- For cases when keymappings need to be defined in a flat table in a format:
--- { keymapping = action }
---@param prefix (string)
---@param keymappings (table) In a format: { <prefix>keymapping = action }
M.add_prefix = function(prefix, keymappings)
    local result = {}

    for key, keymapping in pairs(keymappings) do
        result[prefix .. key] = keymapping
    end

    return result
end

--- For cases when keymappings need to be defined in a flat table in a format
--- that is sometimes defined by some plugins:
--- { action_name = keymapping }
---@param prefix (string)
---@param keymappings (table) In a format: { action_name = <prefix>keymapping }
M.add_prefix_to_values = function(prefix, keymappings)
    local result = {}

    for key, keymapping in pairs(keymappings) do
        result[key] = prefix..keymapping
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
--- Transform to hydra keymappings
---@param keymappings WhichKey-like keymappings
---@return Hydra-like keymappings
M.transform_to_hydra = function(keymappings)
    return vim.tbl_map(
        function(key)
            local keymapping = keymappings[key]
            return { key, keymapping[1], { desc = keymapping[2] } }
        end,
        vim.tbl_keys(keymappings)
    )
end


return M
