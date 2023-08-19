return {
  'Tpope/vim-fugitive',

  config = function (_, _)
    local ds_omega_utils_is_available, ds_omega_utils = prequire('ds_omega.ds_omega_utils')

    if not ds_omega_utils_is_available then
      return
    end

    ds_omega_utils.apply_plugin_keymappings(require('ds_omega.config.Git.fugitive.keymappings'))

   -- Wasn't working, moved it to general_settings.
    -- require('ds_omega.utils.setters').set_global_variables({
      -- Disable global mappings (`y<C-g>` was adding delay to `y` mapping).
      -- fugitive_no_maps = 1,
    -- })
  end,
}
