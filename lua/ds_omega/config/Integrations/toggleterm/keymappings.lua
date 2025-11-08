local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local KEY = CONSTANTS.KEY
local leader_right = CONSTANTS.keymappings.leader_right

local terminal_leader = leader_right .. 't'

local function Terminal()
    local terminal_is_available = prequire('toggleterm.terminal')

    if not terminal_is_available then
        return
    end

    return require('toggleterm.terminal').Terminal
end

return {
    n = {
        [terminal_leader] = {
            -- TODO: Not very ergonomic…
            g = {
                function()
                    local lazygit = Terminal():new({
                        cmd = "lazygit",
                        direction = "float",
                        hidden = false,
                    })

                    lazygit:toggle()
                end,
                "Open lazygit terminal"
            },
            [KEY.forward_slash] = {
                function()
                    local broot = Terminal():new({
                        cmd = "br",
                        hidden = false,
                    })

                    broot:toggle()
                end,
                "Open broot terminal"
            },
            f = {
                function()
                    local file_manager = Terminal():new({
                        cmd = require("ds_omega.utils.os").is("Windows_NT") and "yazi" or "ranger",
                        hidden = false,
                    })

                    file_manager:toggle()
                end,
                "Open file manager (yazi/ranger) terminal"
            },
        }
    },

    terminal_leader = terminal_leader,
}
