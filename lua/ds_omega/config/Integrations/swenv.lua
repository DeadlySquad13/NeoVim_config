---@type LazySpec
return {
    "AckslD/swenv.nvim",

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local swenv_is_available = prequire('swenv')

        if not swenv_is_available then
          return
        end

        local swenv = require('swenv')
        

        -- Integration with project_nvim root detection. If .venv is present at
        -- root folder, swenv will automatically activate this environment.
        -- TODO: Currently this snippet throws errors in pixi projects.
        -- At the same time we already have virtual environment activated in
        -- our Pixi template project via direnv so there's no much need it this
        -- autocmd. Solve this issue if there's a need it this feature in other
        -- projects.
        -- local project_nvim_is_available = prequire('project_nvim')

        -- if project_nvim_is_available then
        --     vim.api.nvim_create_autocmd("FileType", {
        --         pattern = { "python" },
        --         callback = function()
        --             require('swenv.api').auto_venv()
        --         end
        --     })
        -- end

        swenv.setup(opts)
    end,
}
