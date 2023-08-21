return {
  'tiagovla/scope.nvim',

  config = function(_, opts)
    local prequire = require('ds_omega.utils').prequire

    local scope_is_available, scope = prequire('scope')

    if not scope_is_available then
      return 
    end

    scope.setup(opts)

    local telescope_is_available, telescope = prequire('telescope')

    if not telescope_is_available then
      return
    end

    telescope.load_extension("scope")
  end,
}
