return {

  'DeadlySquad13/deadly-gruv.nvim',
  -- See `dev.path` in lazy.setup 2nd param.
  dev = require("ds_omega.utils.os").is("Linux"),

  --   '~/nvim/CustomThemes/deadly-gruv.nvim',
  -- [[C:\Users\ds13\.bookmarks\Projects\--personal\NeoVim__DeadyGruv_theme]],
  -- config = function(_, _)
  --   require('ds_omega.config.theme')
  -- end

  dependencies = 'rktjmp/lush.nvim',
}
