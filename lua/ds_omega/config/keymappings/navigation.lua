local telescope_builtin = require('telescope.builtin')
local telescope_extensions = require('telescope').extensions

local KEY = require('ds_omega.config.keymappings._common.constants').KEY

local navigation_mappings = {
    name = 'Navigation',
    -- * Telescope.
    n = {
        telescope_builtin.resume,
        'Resume'
    },

    f = {
        telescope_builtin.find_files,
        'Find in current directory',
    },
    F = {
        '<Cmd>RnvimrToggle<Cr>',
        'Files via Rnvimr',
    },
    o = {
        telescope_builtin.oldfiles,
        'Old files',
    },

    b = {
        telescope_builtin.buffers,
        'Buffers',
    },

    -- s = {
    --   require('session-lens').search_session()
    --   'Session search',
    -- },
    g = {
        telescope_builtin.live_grep,
        'Live grep',
    },

    h = {
        telescope_builtin.help_tags,
        'Help tags',
    },
    t = {
        telescope_builtin.treesitter,
        'Treesitter',
    },

    [KEY.forward_slash] = { ':Neotree<cr>', 'Filetree' },

    e = {
        ':e ./',
        'Edit file',
    },
}

local scope_extension = telescope_extensions.scope
if not vim.tbl_isempty(scope_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        b = {
            telescope_builtin.buffers,
            'Tab-local Buffers',
        },
        B = {
            scope_extension.buffers,
            'All Buffers',
        },
    })
end

-- local projects_extension = telescope_extensions.projects
-- if not vim.tbl_isempty(projects_extension) then
--     navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
--         p = {
--             projects_extension.projects,
--             'Projects',
--         },
--     })
-- end

local file_browser_extension = telescope_extensions.file_browser
if not vim.tbl_isempty(file_browser_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        ['-'] = {
            file_browser_extension.file_browser,
            'File browser',
        },
    })
end

return navigation_mappings
