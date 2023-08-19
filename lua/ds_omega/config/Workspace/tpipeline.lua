return {
  'vimpostor/vim-tpipeline',
  enabled = false,
  -- Broke after this commit.
  -- lock = true,
  -- branch = 'af7fe78523c7c860d00b79383908322fcb5e6133',

  cond = not vim.g.started_by_firenvim,

  opts = {
    tpipeline_autoembed = 0,
    tpipeline_fillcentre = 1,
    --tpipeline_preservebg = 1,

    -- Unfortunately, it overwrite laststatus=3 and it's crisp borders so setting
    --   them manually:
    tpipeline_clearstl = 1,

    vim_settings = {
      -- Settings crisp window borders.
      fillchars = vim.o.fillchars .. ',' .. 'stlnc:-,stl:-',
    }
  },

  config = function(_, opts)
    local tbl_remove_key = require('ds_omega.utils').tbl_remove_key

    local vim_settings = tbl_remove_key(opts, 'vim_settings')

    local setters = require('ds_omega.utils.setters')

    setters.set_global_variables(opts)
    setters.set_settings(vim_settings)
  end
}
