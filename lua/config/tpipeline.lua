return {
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
}
