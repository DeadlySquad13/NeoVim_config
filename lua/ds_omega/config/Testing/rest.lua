return {
    "rest-nvim/rest.nvim",
    ft = "http",
    -- Don't need on Windows. It's also hard to install on it: issues with
    -- luarocks plugin build script (easier to install it on system) and
    -- even after installing it, it will not found all packages but mimetypes.
    -- xml2lua and nvim-nio will not build, lua-curl won't find curl…
    enabled = not require("ds_omega.utils.os").is("Windows_NT"),
    dependencies = {
        {
            "vhyrro/luarocks.nvim",
            priority = 1000,
            config = true,

            opts = {
                rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
            },
        }
    },
    
    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local rest_nvim_is_available, rest_nvim = prequire('rest-nvim')

        if not rest_nvim_is_available then
          return
        end

        rest_nvim.setup(opts)
    end,
}
