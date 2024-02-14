return {
    "markonm/traces.vim",

    opts = {
        abolish_integration = true,
    },

    config = function (_, opts)
        local prequire = require('ds_omega.utils').prequire

        local setters_is_available, setters = prequire('ds_omega.utils.setters')

        if not setters_is_available then
          return
        end

        setters.set_global_variables(opts, 'traces')
    end
}
