local cmd = require('ds_omega.config.keymappings._common.utils').cmd

return {
    n = {
        ['<Leader>oI'] = {
            name = "Open Opencode input in...",
            o = { cmd 'OpencodeDsOmega open_input_new_session os', 'Current environment' },
            d = { cmd 'OpencodeDsOmega open_input_new_session docker', 'Isolated docker environment' },
        }
    }
}
