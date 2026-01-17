local M = {}

M.setup = function()
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
            -- INFO: mini.files conflicts with popup that chooses lsp import option.
            -- It doesn't actually close it, though, but unfocuses at least.
            -- TODO: Change lsp options to remove this import options popup and
            -- then remove this line.
            MiniFiles.close()
            require('ds_omega.utils.rename').on_rename_file(event.data.from, event.data.to)
        end,
    })
end

return M
