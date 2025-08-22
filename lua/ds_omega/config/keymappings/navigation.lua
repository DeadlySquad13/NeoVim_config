local prequire = require('ds_omega.utils').prequire

local function telescope_builtin()
    local _, telescope_builtin = prequire('telescope.builtin')

    return telescope_builtin
end

local KEY = require('ds_omega.config.keymappings._common.constants').KEY

local navigation_mappings = {
    name = 'Navigation',
    -- * Telescope.
    n = {
        function() return telescope_builtin().resume() end,
        'Resume',
    },

    f = {
        function() telescope_builtin().find_files() end,
        'Files in current directory',
        expr = true,
    },
    F = {
        '<Cmd>RnvimrToggle<Cr>',
        'Files via Rnvimr',
    },
    o = {
        function() return telescope_builtin().oldfiles() end,
        'Old files',
        expr = true,
    },

    b = {
        function() return telescope_builtin().buffers() end,
        'Buffers',
        expr = true,
    },

    s = {
        function() return telescope_builtin().git_status() end,
        'Git Status (changed files)',
        expr = true,
    },

    -- S = {
    --   require('session-lens').search_session()
    --   'Session search',
    -- },
    g = {
        function() return telescope_builtin().live_grep() end,
        'Live grep',
        expr = true,
    },

    i = {
        function()
            vim.ui.input({ prompt = 'Query workspace symbol' }, function(input)
                telescope_builtin().lsp_workspace_symbols({ query = input, show_line = true })
            end)
        end,
        "Workspace symbols",
    },

    w = {
        function() return telescope_builtin().grep_string() end,
        'Grep string (word)',
    },

    h = {
        function() return telescope_builtin().help_tags() end,
        'Help tags',
        expr = false,
    },
    ['<S-t>'] = {
        function() return telescope_builtin().treesitter() end,
        'Treesitter',
        expr = true,
    },

    m = {
        function() return telescope_builtin().marks() end,
        'Marks',
        expr = true,
    },

    [KEY.forward_slash] = { ':Neotree<cr>', 'Filetree' },

    e = {
        ':e .',
        'Edit file',
        silent = false,
    },
}

-- Refactor and move into respective plugins when Keymappings__Layout is ready.
local telescope_is_available, telescope = prequire('telescope')

if telescope_is_available and telescope then
    local telescope_extensions = require('telescope').extensions

    local scope_is_available = prequire('scope')

    if scope_is_available then
        local scope_extension = telescope_extensions.scope
        if scope_extension ~= nil and not vim.tbl_isempty(scope_extension) then
            navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
                b = {
                    function() return telescope_builtin().buffers end,
                    'Tab-local Buffers',
                    expr = true,
                },
                B = {
                    scope_extension.buffers,
                    'Global Buffers',
                },
            })
        end
    end

    local bibtex_extension = telescope_extensions.bibtex
    if not vim.tbl_isempty(bibtex_extension) then
        navigation_mappings = vim.tbl_extend("error", navigation_mappings, {
            r = {
                bibtex_extension.bibtex,
                'Reference item',
            },
        })
    end

    -- Set live_grep_args instead of builtin live_grep.
    local live_grep_args_extension = telescope_extensions.live_grep_args
    if not vim.tbl_isempty(live_grep_args_extension) then
        navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
            g = {
                live_grep_args_extension.live_grep_args,
                'Live grep with args',
            },
        })
        navigation_mappings = vim.tbl_extend("error", navigation_mappings, {
            G = {
                function() return telescope_builtin().live_grep() end,
                'Live grep',
                expr = true,
            },
        })
    end

    local tabs_extension = telescope_extensions['telescope-tabs']
    if not vim.tbl_isempty(tabs_extension) then
        navigation_mappings = vim.tbl_extend("error", navigation_mappings, {
            t = {
                tabs_extension.list_tabs,
                'Tabs',
            },
        })
    end
end

local search_tabs_is_available = prequire('search')

-- Must be last to overwrite everything!
if search_tabs_is_available then
    local search_tabs = require('search')

    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        b = {
            function() return search_tabs.open({ collection = 'buffers', tab_name = 'Tab-local' }) end,
            'Tab-local Buffers (tab)',
        },
        B = {
            function() return search_tabs.open({ collection = 'buffers', tab_name = 'Global' }) end,
            'Global Buffers (tab)',
        },

        g = {
            function() return search_tabs.open({ collection = 'grep' }) end,
            'Live grep (tab)',
        },
        w = {
            function() return search_tabs.open({ collection = 'grep_string' }) end,
            'Grep string (word)'
        },

        f = {
            function() return search_tabs.open({ collection = 'files', tab_name = 'Cwd' }) end,
            'Files in current directory (tab)'
        },
        p = { -- ? Add non-tab version to navigation? It kinda useful: you don't swap cwd during this command. But it sucks to have so much file command variants :D
            function() return search_tabs.open({ collection = 'files', tab_name = 'Recent project' }) end,
            'Recent project files (tab)'
        },
        ['-'] = {
            function() return search_tabs.open({ collection = 'files', tab_name = 'File browser' }) end,
            'File browser (tab)'
        },
        o = {
            function() return search_tabs.open({ collection = 'files', tab_name = 'Old' }) end,
            'Old files (tab)'
        },
    })

    local live_grep_args_extension = require('telescope').extensions.live_grep_args
    -- Set live_grep_args instead of builtin live_grep.
    if not vim.tbl_isempty(live_grep_args_extension) then
        navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
            g = {
                function() return search_tabs.open({ collection = 'grep', tab_name = 'With args' }) end,
                'Live grep with args (tab)',
            },
            G = {
                function() return search_tabs.open({ collection = 'grep' }) end,
                'Live grep (tab)',
            },
        })
    end
end

return navigation_mappings
