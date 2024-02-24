local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd
local prequire = require('ds_omega.utils').prequire

local ufo_is_available, ufo = prequire('ufo')

if not ufo_is_available or not ufo then
  return
end

local function applyFoldsAndThenCloseAllFolds(bufnr, providerName)
    require("async")(function()
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        -- make sure buffer is attached
        ufo.attach(bufnr)
        -- getFolds return Promise if providerName == 'lsp'
        local ok, ranges = pcall(await, ufo.getFolds(bufnr, providerName))
        if ok and ranges then
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
        applyFoldsAndThenCloseAllFolds(e.buf, "lsp")
    end,
})
