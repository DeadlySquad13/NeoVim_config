return {
  enabled = false,
  'ahmedkhalf/project.nvim',

  opts = {
      manual_mode = true,
      scope_chdir = 'win',
  },

  config = function(_, opts)
      local prequire = require('ds_omega.utils').prequire

      local project_nvim_is_available, project_nvim = prequire('project_nvim')

      if not project_nvim_is_available then
        return
      end

      project_nvim.setup(opts)

      local telescope_is_available, telescope = prequire('telescope')

      if not telescope_is_available then
        return
      end

      telescope.load_extension('projects')
  end,
}
