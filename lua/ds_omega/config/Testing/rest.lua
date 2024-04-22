return {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim", "vhyrro/luarocks.nvim" } },
    
    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local rest_nvim_is_available, rest_nvim = prequire('rest-nvim')

        if not rest_nvim_is_available then
          return
        end

        rest_nvim.setup(opts)
    end,
}
