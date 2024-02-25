return {
    "AckslD/swenv.nvim",

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local swenv_is_available, swenv = prequire('swenv')

        if not swenv_is_available then
          return
        end

        -- Integration with project_nvim root detection. If .venv is present at
        -- root folder, swenv will automatically activate this environment.
        local project_nvim_is_available = prequire('project_nvim')

        if project_nvim_is_available then
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python" },
                callback = function()
                    require('swenv.api').auto_venv()
                end
            })
        end

        swenv.setup(opts)
    end,
}
