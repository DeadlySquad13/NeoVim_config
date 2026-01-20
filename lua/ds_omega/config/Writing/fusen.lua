local K = require('ds_omega.config.keymappings._common.constants').keymappings
---@type LazySpec
return {
    'walkersumida/fusen.nvim',

    event = 'VimEnter',

    opts = {
        annotation_display = {
            mode = 'eol',
        },
        mark = {
            hl_group = 'Comment', --[[ 'FusenMark', ]]
        },
        save_file = require('ds_omega.constants.env').KBN .. '/fusen_marks.json',

        keymaps = require('ds_omega.config.keymappings._common.utils').add_prefix_to_values(
            K.leader_left .. 'a',
            {
                add_mark = 'a',
                clear_mark = 'l',
                clear_buffer = 'L',
                clear_all = 'D', -- Don't really need.
                next_mark = K.next,
                prev_mark = K.previous,
                list_marks = 'n',
            }),
    },
}
