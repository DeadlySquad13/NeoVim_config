---@type LazySpec
return {
    -- "FabianWirth/search.nvim",
    "DeadlySquad13/search.nvim",

    dev = false,

    opts = function()
        local builtin = require("telescope.builtin")
        local extensions = require("telescope").extensions

        local project_nvim_is_available = prequire('project_nvim')

        local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
        local K = CONSTANTS.keymappings

        return {
            mappings = {
                next = {
                    -- FIX: Currently there're a lot of normal mode mappings
                    -- starting with [ or ] that apply in telescope too even
                    -- though we don't need them in that context.
                    { K.next_global, "n" },
                    { "<Tab>",       "i" },
                },
                prev = {
                    { K.previous_global, "n" },
                    { "<S-Tab>",         "i" },
                },
            },
            -- TODO: Add choose_target config.
            -- FIX: Add checks on extensions.
            collections = {
                buffers = {
                    initial_tab = 1, -- Tab-local buffers.

                    tabs = {
                        { name = 'Tab-local', tele_func = builtin.buffers },
                        { name = 'Global',    tele_func = extensions.scope.buffers },
                    },
                },


                files = {
                    initial_tab = 1, -- Files in current directory.

                    tabs = {
                        { name = 'Cwd',    tele_func = builtin.find_files },
                        { name = 'Hidden', tele_func = builtin.find_files, tele_opts = { no_ignore = true, hidden = true } },
                        not project_nvim_is_available and nil or {
                            name = 'Recent project',
                            tele_func = function(_)
                                local project_nvim = require('project_nvim')

                                return builtin.find_files({ cwd = project_nvim.get_recent_projects()[1] })
                            end,
                            available = function()
                                local recent_projects = require('project_nvim').get_recent_projects()

                                return recent_projects and not vim.tbl_isempty(recent_projects)
                            end,
                        },
                        { name = 'File browser', tele_func = extensions.file_browser.file_browser },
                        { name = 'Old',          tele_func = builtin.oldfiles },
                    },
                },

                files_minimal = {
                    initial_tab = 1, -- Files in current directory.

                    tabs = {
                        { name = 'Cwd',    tele_func = builtin.find_files },
                        { name = 'Hidden', tele_func = builtin.find_files, tele_opts = { no_ignore = true, hidden = true } },
                        { name = 'File browser', tele_func = extensions.file_browser.file_browser },
                    },
                },

                grep = {
                    initial_tab = 1,

                    tabs = {
                        { name = 'Grep',          tele_func = builtin.live_grep },
                        { name = 'With args',     tele_func = extensions.live_grep_args.live_grep_args },
                        { name = 'Hidden',        tele_func = builtin.live_grep,                       tele_opts = { additional_args = { '--hidden' } } },
                        { name = 'In open files', tele_func = builtin.live_grep,                       tele_opts = { grep_open_files = true } },
                    },
                },

                grep_string = {
                    initial_tab = 1,

                    -- Doesn't show word in a name like Telescope does because of search tabs `name`.
                    tabs = {
                        { name = 'Grep string',   tele_func = builtin.grep_string },
                        { name = 'Hidden',        tele_func = builtin.grep_string, tele_opts = { additional_args = { '--hidden' } } },
                        { name = 'In open files', tele_func = builtin.grep_string, tele_opts = { grep_open_files = true } },
                    },
                },
            }
        }
    end,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
}
