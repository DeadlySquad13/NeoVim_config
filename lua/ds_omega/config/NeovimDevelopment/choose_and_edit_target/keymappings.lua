local cmd = require('ds_omega.config.keymappings._common.utils').cmd

return {
    n = {
        ['<Leader>e'] = {
            e = { cmd 'ChooseAndEditConfigs', 'Choose and Edit configs' },
            u = { cmd 'ChooseAndEditUnixDotfiles', 'Choose and Edit Unix Dotfiles' },
            rs = { cmd 'ChooseAndEditScripts', 'Choose and Edit Scripts' },
            b = { cmd 'ChooseAndEditBookmarkedLocations', 'Choose and Edit Bookmarked Locations' },

            -- All.
            a = { cmd 'ChooseAndEdit', 'Choose and Edit' },
        },
    },
}
