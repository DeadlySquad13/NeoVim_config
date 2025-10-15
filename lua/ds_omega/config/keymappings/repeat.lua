local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings
local ts_repeat_move_is_available = prequire('nvim-treesitter.textobjects.repeatable_move')

if not ts_repeat_move_is_available then
  return
end

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

local Repeat = {}

Repeat.keymappings = {
    [keymappings.repeat_next] = {
        ts_repeat_move.repeat_last_move, 'Repeat last move',
    },
    [keymappings.repeat_previous] = {
        ts_repeat_move.repeat_last_move_opposite, 'Repeat last move in opposite direction',
    },
}

return Repeat
