local cmd = require('ds_omega.config.keymappings._common.utils').cmd

return {
    n = {
        ['<Leader>ee'] = { cmd 'ChooseAndEditConfigs', 'Choose and Edit configs' },
    },
}
