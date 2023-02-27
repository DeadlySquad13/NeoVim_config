-- Declaring colors.
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- Use treesitter to calculate indentation when possible.

return {
    -- Char to be used to display an indent.
    char = "|",
    -- Exclude certain buffer types.
    buftype_exclude = { 'terminal' },
    filetype_exclude = { 'dashboard', 'neo-tree', 'neo-tree-popup', 'help' },
    show_end_of_line = true,
    space_char_blankline = " ",
    -- Use Treesitter to calculate indentation when possible.
    indent_blankline_use_treesitter = true,
    -- Enable context highlight by Treesitter.
    show_current_context = true,
    show_current_context_start = true,
    -- Assigning colors.
    char_highlight_list = {
        'IndentBlanklineIndent1',
        'IndentBlanklineIndent2',
        'IndentBlanklineIndent3',
        'IndentBlanklineIndent4',
        'IndentBlanklineIndent5',
        'IndentBlanklineIndent6',
    },
}
