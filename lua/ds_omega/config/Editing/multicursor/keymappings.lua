local prequire = require('ds_omega.utils').prequire

local mc_is_available, mc = prequire('multicursor-nvim')

if not mc or not mc_is_available then
    return
end

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local K = CONSTANTS.keymappings

-- Keymappings used during the search are in settings.
return {
    add_layer_keymappings = function()
        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            -- Same keys are also used for `repeat_next` and `repeat_previous`
            -- but I don't yet see any conflicting situations with that. If
            -- we'll need repeats in multicursor context, remap keys here.
            layerSet({ "n", "x" }, K.leader_left .. K.previous, mc.prevCursor)
            layerSet({ "n", "x" }, K.leader_left .. K.next, mc.nextCursor)

            -- Delete the main cursor.
            layerSet({ "n", "x" }, K.leader_left .. "q", mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
    end,
    n = {
        [K.leader_left] = {
            -- Add or skip cursor above/below the main cursor.
            ["<Up>"] = { function() mc.lineAddCursor(-1) end, 'Add cursor up' },
            ["<Down>"] = { function() mc.lineAddCursor(1) end, 'Add cursor down' },
            -- ["<leader><up>"], function() mc.lineSkipCursor(-1) end)
            -- ["<leader><down>"], function() mc.lineSkipCursor(1) end)

            -- Disable and enable cursors.
            ['<Esc>'] = { mc.toggleCursor, 'Toggle cursors' },
        },

        [K.leader_right] = {
            -- Add or skip adding a new cursor by matching word/selection
            n = { function() mc.matchAddCursor(1) end, 'Add cursor on next match' },
            s = { function() mc.matchSkipCursor(1) end, 'Skip cursor on next match' },
            N = { function() mc.matchAddCursor(-1) end, 'Add cursor on previous match' },
            S = { function() mc.matchSkipCursor(-1) end, 'Skip cursor on previous match' },
        },

        -- Add and remove cursors with control + left click.
        -- set("n", "<c-leftmouse>", mc.handleMouse)
        -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
        -- set("n", "<c-leftrelease>", mc.handleMouseRelease)

    }
}
