--local utils = require('ds_omega.utils');
--local create_augroup = utils.create_augroup;
--local create_autocmd = utils.create_autocmd;

---- NOTE: clear option - clears previously created autocommands in augroup.

--local snippets = create_augroup('CustomSnippets', { clear = true });

--local BufEarlyEnter = { 'BufNewFile', 'BufReadPost' }
---- Encapsulating some options that are commonly used by snippet autocmds. 
--local snippets_create_autocmd = function(options)
  ---- Will raise an error if you try to overwrite some value in the left table.
  --create_autocmd(BufEarlyEnter, vim.tbl_deep_extend('error', { group = snippets }, options));
--end

--snippets_create_autocmd({
  --desc = 'Added packer.snippets as a main snippet definition source while editing plugins file',

  --pattern = 'plugins.lua',
  --callback = function()
    --require("luasnip.loaders.from_lua").load('./luasnippets/lua.plugins')
  --end,
--});

--snippets_create_autocmd({
  --desc = 'Added jupyter_ascending.snippets as a main snippet definition source while editing python files ending on sync.py',

  --pattern = '*.sync.py',
  --command = 'UltiSnipsAddFiletypes jupyter_ascending.py',
--});
