local logseq_extmarks = require('ds_omega.modules.logseq.extmarks')

local utils = require('ds_omega.utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

local M = {}

M.Logseq = create_augroup('Logseq', { clear = true })

M.logger = get_logger("Logseq")

M.trusted_keys = {
    LOGSEQ_API_AUTHORIZATION_TOKEN = true,
}

M.prepare_env = function(env_filepath)
    local is_success = require('ds_omega.utils.exec').dotfile(env_filepath, M.trusted_keys)

    local notifier = M.logger:get_notifier({ title = "Logseq. Authorization" })

    if not is_success then
        notifier:info(
            "Set LOGSEQ_API_AUTHORIZATION_TOKEN in the " ..
            env_filepath .. " to use Logseq module")
    end
end

---@alias LogseqOpts {}

---@param opts (LogseqOpts)
M.setup = function(opts)
    M.prepare_env(require('ds_omega.constants.env').NVIM_ENV_FILE)

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
