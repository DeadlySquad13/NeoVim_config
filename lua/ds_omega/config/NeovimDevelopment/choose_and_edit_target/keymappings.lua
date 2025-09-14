local cmd = require('ds_omega.config.keymappings._common.utils').cmd

local CONSTANTS = require('ds_omega.config.keymappings._common.constants')
local K = CONSTANTS.keymappings

-- REFACTOR: Generate command name and take description from config?
return {
    n = {
        ['<Leader>e'] = {
            e = { cmd 'ChooseAndEditNeoVimConfigs', 'Choose and Edit NeoVim configs' },
            u = { cmd 'ChooseAndEditUnixDotfiles', 'Choose and Edit Unix Dotfiles' },
            [K.leader_left .. 's'] = { cmd 'ChooseAndEditScripts', 'Choose and Edit Scripts' },
            b = { cmd 'ChooseAndEditBookmarkedLocations', 'Choose and Edit Bookmarked Locations' },

            -- All.
            a = { cmd 'ChooseAndEditAll', 'Choose and Edit (all)' },
        },
    },
}
