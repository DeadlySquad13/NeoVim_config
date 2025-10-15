local logseq_extmarks = require('ds_omega.modules.logseq.extmarks')

local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local M = {}

M.Logseq = create_augroup('Logseq', { clear = true })

---@alias LogseqOpts {}

---@param opts (LogseqOpts)
M.setup = function(opts)
    create_autocmd({ 'BufRead', 'TextChanged' }, {
        group = M.Logseq,
        desc = "Set extmarks for Logseq reference blocks",
        pattern = { "*.org" },

        callback = function(event_args)
            logseq_extmarks.set_extmark_references(event_args.buf)
        end,
    })
    create_autocmd({ 'BufDelete' }, {
        group = M.Logseq,
        desc = "Clear cached data for Logseq reference blocks that are now longer necessary",
        pattern = { "*.org" },

        callback = function(event_args)
            logseq_extmarks.set_extmark_references(event_args.buf)
        end,
    })
end

return M
