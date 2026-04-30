return {
    dir = require('ds_omega.constants.env').NVIM_MODULES .. "/typenix",

    config = function(_, opts)
        local typenix_is_available = prequire('ds_omega.modules.typenix')

        if not typenix_is_available then
          return
        end

        local typenix = require('ds_omega.modules.typenix')

        typenix.setup()
    end,
}
