local M = {}

local function gitlab()
    local gitlab_is_available, gitlab = prequire_plugin('gitlab')
    if not gitlab_is_available or not gitlab then
        return
    end

    return gitlab
end

local comment_key = { 'a', 'A' }

local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

return {
    n = {
        [keymappings.leader_right] = {
            g = {
                s = {
                    function() return gitlab().summary() end,
                    'Show summary for current branch',
                    expr = true,
                },
                g = {
                    function() return gitlab().review() end,
                    'Review current branch',
                    expr = true,
                },
                G = {
                    function() return gitlab().choose_merge_request() end,
                    'Choose merge request',
                    expr = true,
                },
                [comment_key[1]] = {
                    function() return gitlab().create_comment() end,
                    'Add comment on current line',
                    expr = true,
                },
                o = {
                    function() return gitlab().approve() end,
                    'Approve merge request (ok)',
                    expr = true,
                },
                O = {
                    function() return gitlab().revoke() end,
                    'Revoke approval for merge request (not ok)',
                    expr = true,
                },
            },
        },
        ['<Leader>i'] = {
            g = {
                function() return gitlab().move_to_discussion_tree_from_diagnostic() end,
                'Merge request discussion',
                expr = true,
            },
        },
    },
    x = {
        [keymappings.leader_right] = {
            g = {
                [comment_key[1]] = {
                    function() return gitlab().create_multiline_comment() end,
                    'Add multi-line comment on selection',
                    expr = true,
                },
                [comment_key[2]] = {
                    function() return gitlab().create_comment_suggestion() end,
                    'Add multi-line comment suggestion on selection',
                    expr = true,
                },
            },
        },
    },
}
