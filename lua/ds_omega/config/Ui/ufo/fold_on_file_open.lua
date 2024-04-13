local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd
local prequire = require('ds_omega.utils').prequire

local ufo_is_available, ufo = prequire('ufo')

if not ufo_is_available or not ufo then
  return
end

local LINES_VISIBLE_ON_ONE_VIEWPORT = 64

-- TODO: Add options:
-- - something like foldlevelstart=6,
-- - fold with indent or treesitter while lsp is loading (may drag),
-- Features:
-- - don't fold it if file is not big enough (fits in current window),
-- - fold only some areas (for example, always fold imports even if everything
-- fits in one window).
local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
    require("async")(function()
        -- make sure buffer is attached
        ufo.attach(bufnr)
        -- getFolds return Promise if providerName == 'lsp'
        local ok, ranges = pcall(await, ufo.getFolds(bufnr, providerName))
        if ok and ranges then
            P(ranges)
            local import_ranges = vim.tbl_filter(function(range) return range.kind == 'imports' end, ranges)

            local imports_were_folded = ufo.applyFolds(
                bufnr,
                import_ranges
            )
            if imports_were_folded then
                ufo.closeAllFolds()
            end

            -- How many lines do import ranges occupy on screen when folded.
            local import_ranges_lines = 0
            for i, import_range in ipairs(import_ranges) do
                import_ranges_lines = import_ranges_lines + import_range.endLine - import_range.startLine
            end

            if vim.api.nvim_buf_line_count(bufnr) - import_ranges_lines < LINES_VISIBLE_ON_ONE_VIEWPORT then
                return
            end

            ok = ufo.applyFolds(bufnr, ranges)
            if ok then
                ufo.closeAllFolds()
            end
        else
            local ranges = await(ufo.getFolds(bufnr, "indent"))
            local ok = ufo.applyFolds(bufnr, ranges)
            if ok then
                ufo.closeAllFolds()
            end
        end
    end)
end

local FoldOnFileOpenGroup = create_augroup('FoldOnFileOpen', { clear = true })

create_autocmd("BufRead", {
    group = FoldOnFileOpenGroup,
    pattern = "*",
    callback = function(e)
        local bufnr = e.buf or vim.api.nvim_get_current_buf()
        applyFoldsAndThenCloseAllFolds(bufnr, "lsp")
    end,
})
