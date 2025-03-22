local prequire = require('ds_omega.utils').prequire

local mc_is_available, mc = prequire('multicursor-nvim')

if not mc or not mc_is_available then
    return
end

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local K = CONSTANTS.keymappings

-- Keymappings used during the search are in settings.
return {
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
            s = { function() mc.matchSkipCursor(1) end, 'Add cursor on next-next match' },
            N = { function() mc.matchAddCursor(-1) end, 'Add cursor on previous match' },
            S = { function() mc.matchSkipCursor(-1) end, 'Add cursor on previous-previous match' },
        },

        -- Add and remove cursors with control + left click.
        -- set("n", "<c-leftmouse>", mc.handleMouse)
        -- set("n", "<c-leftdrag>", mc.handleMouseDrag)
        -- set("n", "<c-leftrelease>", mc.handleMouseRelease)

    }
}
