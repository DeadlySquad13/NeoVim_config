local cmd = require('hydra.keymap-util').cmd

---@param command (string)
local function search_replace(command)
    return cmd('SearchReplace' .. command)
end

-- # Replace. Search and replace mappings.
-- Use    ['<Right>'] = { 'l', 'Right' }, as motion over range for substitute nvim.
local replace_mappings = {
    name = 'Replace',
    -- vnoremap <leader>sw <esc>:%s;\<<c-r><c-w>\>;;g<left><left>
    -- Don't really remember why I needed it...
    t = { [[:%s;<\w*>\(<\\\w*>\)\?;;g<left><left>]], 'Tag' },


    o = { search_replace 'SingleBufferOpen', "Open" },
    a = { search_replace 'SingleBufferCWord', "Word" },
    A = { search_replace 'SingleBufferCWORD', "CWord" },
    e = { search_replace 'SingleBufferCExpr', "C expression" },
}

return replace_mappings
