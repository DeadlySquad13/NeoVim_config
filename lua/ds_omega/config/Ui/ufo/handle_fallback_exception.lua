local log_ufo = log('Ufo')

--- Run ufo.getFolds for specified params if the error was thrown.
---@param err string|UfoFallbackException error
---@param bufnr number
---@param providerName string|'lsp'|'treesitter'|'indent'
local function handle_fallback_exception(err, bufnr, providerName)
    local ufo_is_available = prequire('ufo')

    if not ufo_is_available then
        return
    end

    ---@class Ufo
    local ufo = require('ufo')

    if type(err) == 'string' and err:match('UfoFallbackException') then
        return ufo.getFolds(bufnr, providerName)
    else
        log_ufo(err)

        return require('promise').reject(err)
    end
end

return handle_fallback_exception
