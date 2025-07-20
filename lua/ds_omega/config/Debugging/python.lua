return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "mfussenegger/nvim-dap-python",
        keys = {
            { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
            { "<leader>dPc", function() require('dap-python').test_class() end,  desc = "Debug Class",  ft = "python" },
        },
        config = function()
            local utils_is_available = prequire('ds_omega.utils')

            if not utils_is_available then
              return
            end

            local utils = require('ds_omega.utils')
            
            -- QUESTION: Is it needed?
            -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#python-dependencies-and-virtualenv
            if vim.fn.has("win32") == 1 then
                require("dap-python").setup(utils.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
            else
                require("dap-python").setup(utils.get_pkg_path("debugpy", "/venv/bin/python"))
                -- require("dap-python").setup(utils.get_pkg_path("debugpy"))
            end
        end,
    },
}
