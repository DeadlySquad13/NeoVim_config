return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')
        if not ds_omega_utils_is_available then
            return
        end
        local keymappings = require('ds_omega.config.Editing.multicursor.keymappings')
        keymappings.add_layer_keymappings()
        keymappings.add_layer_keymappings = nil
        ds_omega_utils.apply_plugin_keymappings(keymappings)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { link = "Cursor" })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
}
