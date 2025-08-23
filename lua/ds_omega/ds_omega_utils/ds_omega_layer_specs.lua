local M = {}

--- Initialize layer specs from LazySpec. Doesn't apply plugins.
---@param specs LazySpecImport[][] Specs with `import`s relative to ds_omega configs route.
M.init = function(specs)
    return vim.tbl_map(
        function(module_specs)
            return vim.tbl_extend("force", module_specs,
                { import = 'ds_omega.config.' .. module_specs.import })
        end,
        specs
    )
end

return M
