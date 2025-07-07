local utils = require("ds_omega.config.keymappings._common.utils")

local cmd = utils.cmd

local Diff = {}

Diff.keymappings = {
    -- Be careful not to overlap with diagnostics severity keymappings.
    n = {
        d = { cmd '.DiffviewFileHistory --follow %', 'Line diff history' },

        h = { cmd 'DiffviewFileHistory', 'Repo diff history' },
        f = { cmd 'DiffviewFileHistory --follow %', 'File diff history' },

        s = { cmd 'DiffviewOpen', 'Repo diff (aka git Status)' },
        l = {
            r = { cmd('DiffviewOpen'), 'Diff against index' },
            R = { cmd('DiffviewOpenDsOmega origin/CURRENT'), 'Diff against remote version of the current branch' },

            l = { cmd('DiffviewOpenDsOmega DEFAULT'), 'Diff local main' },
            L = { cmd('DiffviewOpenDsOmega origin/DEFAULT'), 'Diff against remote origin/main' },

            f = { cmd('DiffviewOpenDsOmega FEATURE'), 'Diff local feature branch' },
            F = { cmd('DiffviewOpenDsOmega origin/FEATURE'), 'Diff against remote feature branch' },

            e = { cmd('DiffviewOpenDsOmega EPIC'), 'Diff local epic branch' },
            E = { cmd('DiffviewOpenDsOmega origin/EPIC'), 'Diff against remote epic branch' },

            -- Very similar to simple `DiffviewOpen`. Made just for
            -- completeness sake.
            c = { function()
                -- TODO: Add dropdown by fetching existing remote branches.
                vim.ui.input({ prompt = 'Enter local branch' }, function(input)
                    vim.cmd.DiffviewOpen({ args = { input } })
                end)
            end, 'Input and Diff against local branch' },
            C = { function()
                -- TODO: Add dropdown by fetching existing remote branches.
                -- Some autocompletion exists on Diffview but it doesn't list
                -- everything for some reason.
                vim.ui.input({ prompt = 'Enter remote branch' }, function(input)
                    vim.cmd.DiffviewOpen({ args = { 'origin/' .. input .. '..HEAD' } })
                end)
            end, 'Input and Diff against remote branch' }
        },

        n = { cmd 'diffget', 'Diff get' },
        c = { cmd 'diffput', 'Diff put' },
    },

    x = {
        d = { "<Esc><Cmd>'<,'>DiffviewFileHistory --follow %<Cr>", 'Visual selection diff history' },
    },
}

return Diff
