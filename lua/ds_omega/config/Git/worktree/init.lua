return {
    'ThePrimeagen/git-worktree.nvim',

    opts = {},

    config = function(_, opts)
        local prequire = require('ds_omega.utils').prequire

        local telescope_is_available, telescope = prequire('telescope')

        if not telescope_is_available or not telescope then
          return
        end

        telescope.load_extension("git_worktree")
    end
}
