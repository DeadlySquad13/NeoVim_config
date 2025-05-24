return {
    "nvim-telescope/telescope-live-grep-args.nvim",

    dependencies = {
        'nvim-telescope/telescope.nvim',
    },

    opts = {
        auto_quoting = true,
    },

    config = function()
        local prequire = require("ds_omega.utils").prequire

        local telescope_is_available, telescope = prequire("telescope")

        if not telescope_is_available then
            return
        end

        telescope.load_extension("live_grep_args")
    end,
}
