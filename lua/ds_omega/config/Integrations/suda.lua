return {
    'lambdalisue/suda.vim',

    opts = {
        smart_edit = 1
    },

    config = function(_, opts)
       local prequire = require('ds_omega.utils').prequire

       local setters_is_available, setters = prequire('ds_omega.utils.setters')

       if not setters_is_available then
         return
       end 

       setters.set_global_variables(opts, 'suda')
    end
}
