return {
    'nanotee/zoxide.vim',
    opts = {
        prefix = 'jump',
    },
    -- TODO: Add cmds to lazy load.
    config = function(_, opts)
        local setters = require('ds_omega.utils.setters')

        setters.set_global_variables(opts, 'zoxide')
    end,
}
