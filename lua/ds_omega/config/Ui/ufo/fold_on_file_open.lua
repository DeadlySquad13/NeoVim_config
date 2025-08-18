local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd
local prequire = require('ds_omega.utils').prequire

local M = {}

local LINES_VISIBLE_ON_ONE_VIEWPORT = 100

local function get_import_ranges(ranges)
    return vim.tbl_filter(function(range) return range.kind == 'imports' end, ranges)
end

---@param import_ranges table
---@return number
local function count_import_range_lines(import_ranges)
    local import_ranges_lines = 0
    for _, import_range in ipairs(import_ranges) do
        import_ranges_lines = import_ranges_lines + import_range.endLine - import_range.startLine
    end

    return import_ranges_lines
end

local function get_ranges_to_fold(ranges, foldlevelstart)
    local ranges_to_fold = {}
    local current_foldlevel = 0
    local enclosing_fold_endlines = { 0 }

    for _, range in ipairs(ranges) do
        for i in ipairs(enclosing_fold_endlines) do
            if range.endLine < enclosing_fold_endlines[#enclosing_fold_endlines - i + 1] then
                current_foldlevel = current_foldlevel + 1

                table.insert(enclosing_fold_endlines, range.endLine)
                break
            else
                current_foldlevel = current_foldlevel - 1
                table.remove(enclosing_fold_endlines)
            end
        end

        if current_foldlevel >= foldlevelstart then
            table.insert(ranges_to_fold, range)
        end
    end

    return ranges_to_fold
end

-- TODO: Add options:
-- - something like foldlevelstart=6,
-- - fold with indent or treesitter while lsp is loading (may drag),
-- Features:
-- - don't fold it if file is not big enough (fits in current window),
-- - fold only some areas (for example, always fold imports even if everything
-- fits in one window).
-- - disable fold on file open if you've modified fold since start.
---
---@param bufnr
---@param provider string|'lsp'|'treesitter'|'indent'|function Either provider
---or function that will return provider. See `provider_selector` for more
---details.
local function applyFoldsAndThenCloseAllFolds(bufnr, provider)
    local ufo_is_available, ufo = prequire('ufo')

    if not ufo_is_available or not ufo then
        return
    end

    require("async")(function()
        -- make sure buffer is attached
        ufo.attach(bufnr)
        -- `getFolds` return Promise if providerName == 'lsp'. `provider_selector` has `getFolds` inside too.
        local ok, ranges

        if type(provider) == "string" then
            ok, ranges = pcall(await, ufo.getFolds(bufnr, provider))
        elseif type(provider) == 'function' then
            ok, ranges = pcall(await, provider(bufnr))
        end

        if not ok or not ranges then
            -- Default fold if something is wrong with `provider_selector`. Note that
            -- our `provider_selector` can fallback to "indent" inside too.
            local ranges = await(ufo.getFolds(bufnr, "indent"))
            local ok = ufo.applyFolds(bufnr, ranges)
            if ok then
                ufo.closeAllFolds()
            end
            return
        end

        -- "Intellectual" fold.
        local import_ranges = get_import_ranges(ranges)

        local imports_were_folded = ufo.applyFolds(
            bufnr,
            import_ranges
        )
        if imports_were_folded then
            ufo.closeAllFolds()
        end

        -- How many lines do import ranges occupy on screen when folded.
        local import_ranges_lines = count_import_range_lines(import_ranges)

        if vim.api.nvim_buf_line_count(bufnr) - import_ranges_lines < LINES_VISIBLE_ON_ONE_VIEWPORT then
            return
        end

        -- local ranges_to_fold = get_ranges_to_fold(P(ranges), 2)

        ok = ufo.applyFolds(bufnr, ranges)
        if ok then
            ufo.closeAllFolds()
        end
    end)
end

M.FoldOnFileOpenGroup = create_augroup('FoldOnFileOpen', { clear = true })

M.autocmds = {}

M.setup_autocmds = function()
    local restore_autocmd_id = require('ds_omega.autocommands.restore_view').autocmds.restore
    if restore_autocmd_id then
        vim.api.nvim_del_autocmd(restore_autocmd_id)
    end

    M.autocmds.indent = create_autocmd("BufReadPost", {
        group = M.FoldOnFileOpenGroup,
        pattern = "*",
        callback = function(e)
            local ok = pcall(vim.cmd.loadview)
            if ok then
                -- It's quite fragile in cases where multiple lsps are used.
                -- TODO: How to delete only for current buffer / separate
                -- LspAttach per lsp instance?
                if not M.autocmds.lsp_deleted then
                    vim.api.nvim_del_autocmd(M.autocmds.lsp)
                    M.autocmds.lsp_deleted = true
                end

                return
            end

            local bufnr = e.buf or vim.api.nvim_get_current_buf()
            -- Perform waterfall provider from best to worst until success.
            -- applyFoldsAndThenCloseAllFolds will fallback to simplest default provider if nothing succeeds.
            local provider_selector = require('ds_omega.config.Ui.ufo.get_customized_selector').get_customized_selector()
            applyFoldsAndThenCloseAllFolds(bufnr, provider_selector)
        end,
    })
    M.autocmds.lsp = create_autocmd("LspAttach", {
        group = M.FoldOnFileOpenGroup,
        pattern = "*",
        callback = function(e)
            local bufnr = e.buf or vim.api.nvim_get_current_buf()
            -- Perform only lsp folding because we're sure it will try all
            -- possible variants earlier (in autocmd above).
            -- applyFoldsAndThenCloseAllFolds will fallback to simplest default provider if nothing succeeds.
            applyFoldsAndThenCloseAllFolds(bufnr, "lsp")
        end,
    })
    M.autocmds.lsp_deleted = false
end

return M
