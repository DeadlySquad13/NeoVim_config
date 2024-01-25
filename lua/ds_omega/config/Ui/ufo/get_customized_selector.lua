local prequire = require('ds_omega.utils').prequire

local ufo_is_available, ufo = prequire('ufo')

if not ufo_is_available then
    return
end

local function provider_selector(bufnr)
    local function handle_fallback_exception(err, providerName)
        if type(err) == 'string' and err:match('UfoFallbackException') then
            return ufo.getFolds(providerName, bufnr)
        else
            return require('promise').reject(err)
        end
    end

    return ufo.getFolds('lsp', bufnr):catch(function(err)
        return handle_fallback_exception(err, 'treesitter')
    end):catch(function(err)
        return handle_fallback_exception(err, 'indent')
    end)
end


-- Lsp -> Treesitter -> Indent.
local function get_customized_selector(bufnr, filetype, buftype)
    return provider_selector
end

return get_customized_selector
