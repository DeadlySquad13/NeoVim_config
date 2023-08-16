-- Used available lowercase key pairs in normal mode: https://gist.github.com/romainl/1f93db9dc976ba851bbb
-- General rules:
-- - default `s` and `S` should be remapped as `c` can be used instead.
-- - default `r` and `R` should be remapped as `c` can be used instead.
-- - default `m` and `M` should be remapped as something more valuable can be
-- assigned to it.

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local KEY = CONSTANTS.KEY

-- Split line by delimiter: '<,'>s;\(delimiter\) ;\1\r;g
-- Uppercase all comments and add dot at the end:
--   '<,'>s;^\(-- \w\)\(.*\);\U\1\e\2.;

local comment_mappings = {
    D = { ':Neogen<cr>', 'Create Documentation comment' },
    ['>'] = {
        '<CMD>set operatorfunc=v:lua.___comment_semantically<CR>g@',
        'Comment semantically',
    },
    ['<'] = {
        '<CMD>set operatorfunc=v:lua.___uncomment_semantically<CR>g@',
        'Uncomment semantically',
    },
    ['>>'] = {
        '<cmd>lua ___comment_semantically_current_line()<cr>',
        'Comment semantically current line',
    },
    ['<<'] = {
        '<cmd>lua ___uncomment_semantically_current_line()<cr>',
        'Uncomment semantically current line',
    },
}

local e_mappings = {
    name = 'Edit',
    e = { ':ChooseAndEditConfigs<cr>', 'Choose and Edit configs' },
    -- Open vimrc in vertical split.
    v = { '<cmd>vsplit $MYVIMRC<cr>', 'Vimrc' },
    h = { ':e <c-r>=expand("%:h")<cr>', 'Relative to current file Head', silent = false },
    -- * Snippets.
    -- Relevant snippet engine command will be called to edit snippets
    --   definitions.
    -- TODO: better pass here a function where it's decides how to edit.
    -- - Appropriate for current file.
    s = { '<cmd>SnippetsEdit<cr>', 'Snippets definitions' },
    -- - Choose from all available sources for current file.
    S = { '<cmd>ChooseSnippetsEdit<cr>', 'Choose Snippets definitions' },
}

-- # File.
-- Buffer mappings are mostly used, for now don't know what to place here.
local file_mappings = {
    name = 'File',
}

-- # Go. Movement across files.
local go_mappings = {
    name = 'Go',
    -- * Rel.vim /home/dubuntus/.vim/plugged/rel.vim/plugin/rel.vim
    l = { '<Plug>(Rel)', 'Link' },
}

-- # Help. Show help pages, documentation. Can lead out of the application,
-- for example, in browser.
local help_mappings = {
    name = 'Help',
    -- `<c-r><c-w>` won't work on namespaced commands like
    --   vim.split - it will send you to vim or split depending on your cursor
    --   location. Default command K can work on visually selected text solving
    --   this issue. Unfortunately, I can't get visually selected by myself, it
    --   seems complicated to achieve with marks.
    -- Maybe this might help:
    --   https://github.com/theHamsta/nvim-treesitter/blob/a5f2970d7af947c066fb65aef2220335008242b7/lua/nvim-treesitter/incremental_selection.lua#L22-L30
    -- But here author gets only range, I still don't understand how to get the
    --   text by that range.
    -- Here author gets text somehow but in vimscript:
    --   https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
    --Should be `:set keywordprg=:help` (on Linux will be `:Man` by default!)
    v = { 'K', 'Vim help' },
    m = { ':Man <c-r><c-w><cr>', 'Man page' },
}

-- # Jump. Movement inside file.
local jump_mappings = {
    name = 'Jump',
}

-- # Replace. Search and replace mappings.
-- Use    ['<Right>'] = { 'l', 'Right' }, as motion over range for substitute nvim.
local rename_mappings = {
    name = 'Replace',
    -- vnoremap <leader>sw <esc>:%s;\<<c-r><c-w>\>;;g<left><left>
    -- Don't really remember why I needed it...
    t = { [[:%s;<\w*>\(<\\\w*>\)\?;;g<left><left>]], 'Tag' },
}

-- # Session. Everything related to sessions, saving, sourcing...
-- Change from silent to vim.notify?
local session_mappings = {
    name = 'Session',
    w = { ':w<cr>', 'Write file' },
    v = { ':source $MYVIMRC<cr>', 'Source Vimrc', silent = false },
    V = {
        ':w<cr><cmd>source $MYVIMRC<cr>',
        'Save current file and source Vimrc',
        silent = false,
    },
    -- Source current file (indented for lua file).

    s = { ':source %<cr>', 'Source current file', silent = false },
    S = { ':LuaSnipSource<cr>', 'Source LuaSnip' },
    -- Recompile settings after changing Packer configuration.
    p = {
        ':source $HOME/.config/nvim/lua/plugins.lua<cr>:PackerCompile<cr>',
        'Recompile packer',
        silent = false,
    },
}

-- # Toggle. Mappings that toggle features.
local toggle_mappings = {
    name = 'Toggle',
    f = { ':FocusToggle<cr>', 'Focus' },
    i = {
        function()
          require('incline').toggle()
        end,
        'Incline (winbar)',
    },
    m = { ':FocusMaxOrEqual<cr>', 'Between Maximize and Equal' },
    q = { ':QuickScopeToggle<cr>', 'QuickScope' },
}

local telescope_extensions = require('telescope').extensions

-- TODO: Move to some other mapping.
-- Open something.
local open_mappings = {
    name = 'Open',
    -- * Telescope.
    s = {
        'Telescope persisted', -- telescope_extensions.persisted.persisted,
        'Session',
    },
}

local paste_mappings = { '"+p', 'Paste from clipboard register' }

-- * Rnvimr.
-- nmap <leader><c-\> :RnvimrToggle<cr>

--  " Find files relative to root directory (don't understand how lua functions
--  "   work).
--  "lua <<EOF
--  "my_fd = function(opts)
--    "opts = opts or {}
--    "opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--    "require'telescope.builtin'.find_files(opts)
--  "end
--  "EOF
--

local execute_mappings = { '<Cmd>JupyniumExecuteSelectedCells<Cr>', 'Execute selected cells' }

local yank_mappings = { '"+y', 'Yank into clipboard register' }
-- local yank_mappings = { '<Plug>YADefault', 'Native Yank' } -- Maybe move into localleader?

local z_mappings = {
    h = {
        [CONSTANTS.transitive_catalizator] = { 'Horizontal Scroll Mode' },
    },
}

-- Historically ',' for me is a keybind for settings.
local settings_mappings = {
    name = 'Settings',
    -- Colors.
    C = { '<cmd>highlight<cr>', 'Show highlight groups Colors' },
    --['*'] = { function() vim.fn['SynStack']() end, 'Show highlight groups under the cursor' }
    ['*'] = {
        -- ':TSHighlightCapturesUnderCursor<cr>',
        '<cmd>Inspect<cr>',
        'Show highlight groups under the cursor',
    },
    ['h'] = { ':noh<cr>', 'Turn off the highlight after search' },
}

local c_mappings = {
    -- Can be nested more as this action will be confirmed as soon as you press ':'.
    d = { ':lcd %:h<cr>', 'Change cwd to current file directory' },
    -- m = nil,
    o = nil,
    -- p = nil, -- Used in yanky.
    -- q = nil, -- Used in nvim-recorder (edit macro).
    u = nil,
    y = nil,
}

local d_mappings = {
    c = nil,
    -- m = nil,
    q = nil,
    r = nil,
    s = nil,
    y = nil,
}

local g_mappings = {
    -- I moved comment mappings to <Leader>c as it seems more ergonomic.
    c = { '<Cmd>e <cfile><Cr>', 'Edit file corresponding to a word under cursor' },
    l = nil,
    y = nil,
    b = nil,
}

local r_mappings = {
    ['<Right>'] = { 'r', 'Replace' },
    l = { 'r', 'Replace' },
}

local y_mappings = {
    c = nil,
    d = nil,
    -- m = nil,
    o = nil,
    p = nil,
    -- q = nil, -- Used in nvim-recorder (yank macro).
    r = nil,
    u = nil,
}

local z_mappings = {
    q = nil,
    -- p = nil, -- Used in yanky.
}

local buffer_mappings_module = require('ds_omega.config.keymappings.buffer')
local buffer_mappings, change_buffer_mappings = buffer_mappings_module[1], buffer_mappings_module[2]

local leader_mappings = {
    name = 'Leader',
    -- a = a_mappings,
    b = buffer_mappings,
    c = comment_mappings,
    -- d = d_mappings,
    e = e_mappings,
    f = file_mappings,
    g = go_mappings,
    h = help_mappings,
    -- i = i_mappings,
    j = jump_mappings,
    -- k = k_mappings,
    -- l = l_mappings,
    m = { 'm', 'Mark' },
    -- Navigation. Helps find things, used as lookup table (navigation panel).
    n = require('ds_omega.config.keymappings.navigation'),
    o = { 'mto<Esc>`t', 'Create a new line below the current', },
    p = paste_mappings,
    -- q = q_mappings,
    r = rename_mappings,
    s = session_mappings,
    t = toggle_mappings,
    -- u = u_mappings,
    -- v = v_mappings,
    -- w = w_mappings,
    x = execute_mappings,
    y = yank_mappings,
    z = z_mappings,
    O = { 'mtO<Esc>`t', 'Create a new line above the current', },
    [','] = settings_mappings,
    ['<Leader>'] = {
        name = 'Previous', -- and repeat?

        c = { ':<Up>', 'Command' },
        b = { '<C-6>', 'Buffer' },
        w = { '<C-w>p', 'Window' },
    }
}

local common_mappings = vim.tbl_extend('error', change_buffer_mappings, {
    w = { '<Plug>(smartword-w)', 'w' },
    b = { '<Plug>(smartword-b)', 'b' },
    e = { '<Plug>(smartword-e)', 'e' },
    ge = { '<Plug>(smartword-ge)', 'ge' },

    -- Make default layout more ergonomic.
    H = { '^', 'Go to the beginning of the line' },
    J = { '}', 'Go one paragraph down' },
    K = { '{', 'Go one paragraph up' },
    L = { '$', 'Go to the end of the line' },
    ['}'] = { 'J', 'Join lines' },

    ['^'] = { 'H', 'Move cursor to the top of the screen' },
    ['$'] = { 'L', 'Move cursor to the bottom of the screen' },

    -- Alternate mappings (functions simillar to `g`).
    [':'] = {
        name = 'Alternate',
    },
    ['h'] = { ':', 'Enter command line mode' },
    ['k'] = { '/', 'Search'},
    -- Swap mark jumps.
    ["'"] = { '`', 'Jump to position' },
    ['`'] = { "'", 'Jump to position linewise' },
    ["''"] = { '``', 'Jump to last position' },
    ["``"] = { "''", 'Jump to last position linewise' },
})

local nmode_mappings = vim.tbl_extend('error', common_mappings, {
        name = 'Main',
        -- a = a_mappings,
        -- b = b_mappings,
        c = c_mappings,
        -- d = d_mappings,
        -- e = e_mappings,
        -- f = f_mappings,
        g = g_mappings,
        -- h = h_mappings,
        -- i = i_mappings,
        -- j = j_mappings,
        -- k = k_mappings,
        -- l = l_mappings,
        -- m = m_mappings,
        -- n = n_mappings,
        -- o = o_mappings,
        -- p = paste_with_indent,
        -- P = paste_before_with_indent,
        -- q = q_mappings,
        r = r_mappings,
        -- s = s_mappings,
        -- t = t_mappings,
        -- u = u_mappings,
        -- v = v_mappings,
        --w = w_mappings,
        -- x = x_mappings,
        -- y = y_mappings,
        -- z = z_mappings,

        -- ['<C-w>'] = require('ds_omega.config.keymappings.window'),
        ['<leader>'] = leader_mappings,
    })

-- vim.cmd([[:QuickScopeToggle<cr>:execute "normal \<Plug>Lightspeed_f"<cr>]])

local xmode_mappings = vim.tbl_extend('error', common_mappings, {
        name = 'Main',
        ['<leader>'] = {
            name = 'Leader',
            -- a = a_mappings,
            -- b = buffer_mappings,
            c = comment_mappings,
            -- d = d_mappings,
            -- e = e_mappings,
            -- f = file_mappings,
            -- g = go_mappings,
            -- h = help_mappings,
            -- i = i_mappings,
            -- j = jump_mappings,
            -- k = k_mappings,
            -- l = l_mappings,
            -- m = major_mappings,
            -- n = navigation_mappings,
            -- o = o_mappings,
            p = paste_mappings,
            -- q = q_mappings,
            -- r = r_mappings,
            -- s = s_mappings,
            -- t = toggle_mappings,
            -- u = u_mappings,
            -- v = v_mappings,
            -- w = w_mappings,
            x = execute_mappings,
            y = yank_mappings,
            -- z = z_mappings,

            -- [','] = settings_mappings,

            -- Comments.
            -- Unfortunately, gv doesn't work at the end, it gets overriden by
            --   something...
            ['>'] = {
                '<esc><cmd>lua ___comment_semantically(vim.fn.visualmode())<cr>',
                'Comment semantically',
            },
            ['<'] = {
                '<esc><cmd>lua ___uncomment_semantically(vim.fn.visualmode())<cr>',
                'Uncomment semantically',
            },
        },
        -- a = a_mappings,
        -- b = b_mappings,
        c = c_mappings,
        -- d = d_mappings,
        -- e = e_mappings,
        -- f = f_mappings,
        -- g = g_mappings,
        -- h = h_mappings,
        -- i = i_mappings,
        -- j = j_mappings,
        -- k = k_mappings,
        -- l = l_mappings,
        -- m = m_mappings,
        -- n = n_mappings,
        -- o = o_mappings,
        -- p = paste_with_indent,
        -- P = paste_before_with_indent,
        -- q = q_mappings,
        -- r = r_mappings,
        -- s = s_mappings,
        -- t = t_mappings,
        -- u = u_mappings,
        -- v = v_mappings,
        -- w = w_mappings,
        -- x = x_mappings,
        -- y = y_mappings,
        -- z = z_mappings,

        -- ['<c-w>'] = {
        -- [CONSTANTS.transitive_catalizator] = { 'Window Mode' },
        -- }

        --['<c-i>'] = { '<cmd>lua require("luasnip.util.util").store_selection()<cr>gv"_s', 'Store selection and start inserting snippet'},
    })

local imode_mappings = {
    name = 'Main',
    -- Unfortunately, have default <c-t> mapped in
    -- ['<c-m>'] = { '<c-t>', 'Indent once' },
    [KEY.forward_slash] = {
        -- '<esc>:lua require("Comment.api").toggle_current_linewise()<CR>`ti',
        '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
        'Comment current line',
    },
}

local cmode_mappings = {
    name = 'Main',
    ['<C-j>'] = { '<C-n>', 'Next command in history' },
    ['<C-k>'] = { '<C-p>', 'Previous command in history' },
}

return {
    n = nmode_mappings,
    x = xmode_mappings,
    i = imode_mappings,
    c = cmode_mappings,
    o = common_mappings,
}
