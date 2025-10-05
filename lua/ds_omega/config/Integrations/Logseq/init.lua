local M = {}

return {
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/logseq",

    ft = { "org" },

    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function(_, opts)
        local logseq_is_available = prequire('ds_omega.modules.logseq')

        if not logseq_is_available then
            return
        end

        local logseq = require('ds_omega.modules.logseq')

        logseq.setup(opts)
    end,
}
