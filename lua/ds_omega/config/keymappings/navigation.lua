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
        ':RnvimrToggle<cr>',
        'Files via Rnvimr'
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

    [KEY.backslash] = { ':Neotree<cr>', 'Filetree' },
}

if not vim.tbl_isempty(telescope_extensions.scope) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        b = {
            telescope_builtin.buffers,
            'Tab-local Buffers',
        },
        B = {
            telescope_extensions.scope.buffers,
            'All Buffers',
        },
    }
    )
end


return navigation_mappings
