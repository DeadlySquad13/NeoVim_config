local tpipeline_settings = {
  tpipeline_autoembed = 0,
  tpipeline_fillcentre = 1,
  --tpipeline_preservebg = 1,

  -- Unfortunately, it overwrite laststatus=3 and it's crisp borders so setting
  --   them manually:
  tpipeline_clearstl = 1,
}

-- Settings crisp borders.
local tpipeline_related_settings = {
  fillchars = vim.o.fillchars .. ',' .. 'stlnc:-,stl:-',
}

for name, value in pairs(tpipeline_settings) do
  vim.g[name] = value;
end

for name, value in pairs(tpipeline_related_settings) do
  vim.o[name] = value;
end

