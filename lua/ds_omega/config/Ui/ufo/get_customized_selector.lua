local ufo_is_available = prequire('ufo')

if not ufo_is_available then
    return
end

---@class Ufo
local ufo = require('ufo')

local M = {}

--- Lsp -> Treesitter -> Indent.
M.provider_selector = function(bufnr)
    local handle_fallback_exception = require('ds_omega.config.Ui.ufo.handle_fallback_exception')

    return ufo.getFolds(bufnr, 'lsp'):catch(function(err)
        -- FIX: For some reason it errors on treesitter throwing error in ufo.
        -- It's handled nicely using this construction but still...
        return handle_fallback_exception(err, bufnr, 'treesitter')
    end):catch(function(err)
        return handle_fallback_exception(err, bufnr, 'indent')
    end)
end


--- Lsp -> Treesitter -> Indent.
---@param _bufnr number Change selector depending on bufnr. Not used.
---@param _filetype string Change selector depending on filetype. Not used.
---@param _buftype  string Change selector depending on buftype. Not used.
---@return function
M.get_customized_selector = function(_bufnr, _filetype, _buftype)
    return M.provider_selector
end

return M
