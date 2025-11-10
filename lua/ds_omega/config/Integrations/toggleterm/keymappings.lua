local cmd = require('ds_omega.config.keymappings._common.utils').cmd

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
            -- TODO: Add count support. For now use open_mapping instead.
            t = {
                cmd 'ToggleTerm',
                'Toggle terminal',
            },
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
                    local broot = Terminal():new(
                        require("ds_omega.utils.os").is("Windows_NT") and {
                            cmd = "br",
                            hidden = false,
                        } or {
                            -- PERF: We have `br` set only in .bashrc that is
                            -- sourced in interactive mode. Of course it also fetches other
                            -- configs. `--login` bash flag maybe better but we
                            -- don't have br here.
                            -- cmd = "br",
                            on_create = function(term)
                                term:send("br")
                            end,
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
}
