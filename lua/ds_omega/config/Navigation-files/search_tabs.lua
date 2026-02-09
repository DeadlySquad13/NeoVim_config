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

        local files_cwd_tab = { name = 'Cwd', tele_func = builtin.find_files }
        local files_hidden_tab = { name = 'Hidden', tele_func = builtin.find_files, tele_opts = { no_ignore = false, hidden = true } }
        -- Search for specific string in all (ignored and hidden) files.
        -- Without specific string search is quite slow in some repositories.
        local files_env_tab = { name = 'Envs', tele_func = builtin.find_files, tele_opts = { no_ignore = true, hidden = true, search_file = ".env" } }
        local files_all_tab = { name = 'All', tele_func = builtin.find_files, tele_opts = { no_ignore = true, hidden = true } }

        ---
        ---@return nil|string folder_path If project root is not found, otherwise will return `<root>/.gitlab` even if the folder doesn't exist.
        local function get_gitlab_folder()
            local project_is_available = prequire('project_nvim.project')

            local project = require('project_nvim.project')
            return not project_is_available and nil or project.get_project_root() .. "/.gitlab"
        end

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
                        files_cwd_tab,
                        files_hidden_tab,
                        files_env_tab,
                        files_all_tab,
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
                        files_cwd_tab,
                        files_hidden_tab,
                        files_all_tab,
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

                -- TODO: Add GitLab / GitHub specific files based on heuristics.
                devops_files = {
                    initial_tab = 1,

                    tabs = {
                        { name = 'Docker',         tele_func = builtin.find_files, tele_opts = { no_ignore = false, hidden = true, search_file = 'Dockerfile' } },
                        { name = 'Docker-compose', tele_func = builtin.find_files, tele_opts = { no_ignore = false, hidden = true, search_file = 'docker-compose' } },
                        {
                            name = 'GitLab',
                            tele_func = function()
                                local project_is_available = prequire('project_nvim.project')

                                local project = require('project_nvim.project')
                                local cwd = not project_is_available and nil or project.get_project_root()

                                return builtin.find_files({
                                    no_ignore = false,
                                    hidden = true,
                                    cwd = cwd,
                                    find_command = { "rg", "--files", "--hidden", "--iglob", ".gitlab-ci*" },
                                })
                            end,
                        },
                        {
                            name = 'GitLab folder',
                            tele_func = function()
                                local cwd = get_gitlab_folder()

                                return builtin.find_files({
                                    no_ignore = false,
                                    hidden = true,
                                    cwd = cwd,
                                })
                            end,
                            available = get_gitlab_folder,
                        },
                        {
                            name = 'File browser GitLab',
                            tele_func = function()
                                local cwd = get_gitlab_folder()

                                return extensions.file_browser.file_browser({
                                    no_ignore = false,
                                    hidden = true,
                                    cwd = cwd,
                                })
                            end,
                            available = get_gitlab_folder,
                        },
                        files_env_tab,
                    },
                },
            }
        }
    end,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
}
