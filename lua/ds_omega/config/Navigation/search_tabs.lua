return {
    "FabianWirth/search.nvim",

    opts = function()
        local builtin = require("telescope.builtin")
        local extensions = require("telescope").extensions

        local prequire = require('ds_omega.utils').prequire

        local project_nvim_is_available, project_nvim = prequire('project_nvim')

        if not project_nvim_is_available then
          return
        end

        return {
            -- TODO: Add choose_target config.
            -- FIX: Add checks on extensions.
            collections = {
                buffers = {
                    initial_tab = 1, -- Tab-local buffers.

                    tabs = {
                        { name = 'Tab-local', tele_func = builtin.buffers },
                        { name = 'Global', tele_func = extensions.scope.buffers },
                    },
                },


                files = {
                    initial_tab = 1, -- Files in current directory.

                    tabs = {
                        { name = 'Files in current directory', tele_func = builtin.files },
                        { name = 'Recent project files', tele_func = function()
                            builtin.files({ cwd = project_nvim.get_recent_projects()[1] })
                        end},
                        { name = 'File browser', tele_func = extensions.file_browser.file_browser },
                        { name = 'Old files', tele_func = builtin.oldfiles },
                    },
                },
            }
        }
    end,

    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
}
