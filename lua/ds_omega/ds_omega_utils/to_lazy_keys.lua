---@param mode (Mode)
---@param keymappings
---@param custom_options (DefaultKeymapOptions?) Options to pass into mappings.
_to_lazy_keys = function(mode, keymappings, custom_options)
    -- local which_key_mappings_is_available, which_key_mappings = prequire('which-key.mappings')

    -- if not which_key_mappings_is_available or not which_key_mappings then
    --   return
    -- end
    local options_with_defaults = require('ds_omega.config.Ui.which_key.utils').options_with_defaults
    local options = options_with_defaults(custom_options)
    options.mode = mode

    -- REFACTOR: Move out of which_key module.
    -- return P(require('legendary.util.which_key').parse_whichkey(keymappings, options))
    return require('ds_omega.ds_omega_utils.parse_whichkey').parse_whichkey(keymappings, options)

    -- return P(parse_whichkey(keymappings, options))

    -- PERFORMANCE: register is parse + some parsing for UI. We're doing it
    -- twice when using both of these functions in the module. Most likely it's
    -- negligable.
    -- local flattened_keymappings = which_key_mappings.parse(keymappings, options)

    -- return vim.tbl_map(function(keymapping)
    --   keymapping.key = keymapping.key.key

    --   return keymapping
    -- end, flattened_keymappings)
end

---
---@param keymappings (table<Mode, table>)
---@return LazyKeysSpec[]
local function to_lazy_keys(keymappings)
    local result = {}

    for mode, keymappings_for_mode in pairs(keymappings) do
        vim.list_extend(result, _to_lazy_keys(mode, keymappings_for_mode))
    end

    return result
end

return to_lazy_keys
