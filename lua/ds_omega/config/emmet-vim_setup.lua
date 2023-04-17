local apply = require('ds_omega.utils').apply;

local emmet_vim_global_variables = {
  -- Disable it, enable it later in autocmd only for specific filetypes.
  user_emmet_install_global = 0,
}

apply.variables.global(emmet_vim_global_variables);
