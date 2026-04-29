local M = {}

M.setup = function()
    vim.filetype.add({
        pattern = {
            [".*/*.nix.d.ts"] = "nixts",
        },
    })

    vim.treesitter.language.register("typescript", { "nixts" })
end

return M
