local Hydra = require('hydra')

local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd
local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

---@param command (string)
local function qf(command)
    return cmd('c' .. command)
end

local QuicfixList = {}

QuicfixList.hydra = Hydra({
    name = 'Quickfix list',
    config = {
        hint = {
            border = 'rounded',
            offset = -1
        }
    },
    mode = 'n',
    heads = {
        { keymappings.next,     qf 'next' },
        { keymappings.previous, qf 'previous' },
        { '[',                  qf 'old' },
        { ']',                  qf 'newer' },
    }
})

return QuicfixList
