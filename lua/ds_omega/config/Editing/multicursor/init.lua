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

        ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Editing.multicursor.keymappings'))

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ "n", "x" }, "r<left>", mc.prevCursor)
            layerSet({ "n", "x" }, "r<right>", mc.nextCursor)

            -- Delete the main cursor.
            layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

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
