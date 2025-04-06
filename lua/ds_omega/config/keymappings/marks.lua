local keymappings = require('ds_omega.config.keymappings._common.constants').keymappings

local usual_marks_keymappings = {
    '<Plug>(Marks-set)',
    'Mark',

    [','] = { '<Plug>(Marks-setnext)', 'Set next mark' },
    d = {
        '<Plug>(Marks-delete)',
        'Delete mark',

        ['-'] = { '<Plug>(Marks-deleteline)', 'Delete mark on current line' },
    },

    [keymappings.next] = { '<Plug>(Marks-next)', 'Next mark' },
    [keymappings.previous] = { '<Plug>(Marks-prev)', 'Previous mark' },
}

local marks_opts = require('ds_omega.config.Navigation.marks').opts

--- Construct keymapping description from bookmark definition.
---@param bookmark Bookmark
local function construct_keymapping_description(bookmark)
    return "Set bookmark "..bookmark.sign..": "..bookmark.virt_text
end

local bookmarks_keymappings = {
    -- '<Plug>(Marks-perview)',
    -- 'Mark preview',

    d = {
        '<Plug>(Marks-delete-bookmark)',
        'Delete bookmark',
    },

    ['a'] = { '<Plug>(Marks-set-bookmark0)', construct_keymapping_description(marks_opts.bookmark_0) },
    ['e'] = { '<Plug>(Marks-set-bookmark1)', construct_keymapping_description(marks_opts.bookmark_1) },
    ['i'] = { '<Plug>(Marks-set-bookmark2)', construct_keymapping_description(marks_opts.bookmark_2) },
    ['h'] = { '<Plug>(Marks-set-bookmark3)', construct_keymapping_description(marks_opts.bookmark_3) },
    ['u'] = { '<Plug>(Marks-set-bookmark4)', construct_keymapping_description(marks_opts.bookmark_4) },
    ['o'] = { '<Plug>(Marks-set-bookmark5)', construct_keymapping_description(marks_opts.bookmark_5) },
    ['y'] = { '<Plug>(Marks-set-bookmark6)', construct_keymapping_description(marks_opts.bookmark_6) },
    ['k'] = { '<Plug>(Marks-set-bookmark7)', construct_keymapping_description(marks_opts.bookmark_7) },
    ['.'] = { '<Plug>(Marks-set-bookmark8)', construct_keymapping_description(marks_opts.bookmark_8) },
    ['q'] = { '<Plug>(Marks-set-bookmark9)', construct_keymapping_description(marks_opts.bookmark_9) },

    [keymappings.next] = { '<Plug>(Marks-next-bookmark)', 'Next bookmark' },
    [keymappings.previous] = { '<Plug>(Marks-prev-bookmark)', 'Previous bookmark' },
}


return {
    usual = usual_marks_keymappings,
    bookmarks = bookmarks_keymappings,
}
