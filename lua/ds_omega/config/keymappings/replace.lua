-- # Replace. Search and replace mappings.
-- Use    ['<Right>'] = { 'l', 'Right' }, as motion over range for substitute nvim.
local replace_mappings = {
    name = 'Replace',
    -- vnoremap <leader>sw <esc>:%s;\<<c-r><c-w>\>;;g<left><left>
    -- For replacing tags.
    t = { [[:%s;<\w*>\(<\\\w*>\)\?;;g<left><left>]], 'Tag' },
}

return replace_mappings
