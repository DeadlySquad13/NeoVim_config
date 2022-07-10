local utils = require('utils');
local create_augroup = utils.create_augroup;
local create_autocmd = utils.create_autocmd;

local emmet_vim = create_augroup('EmmetVim', { clear = true });

create_autocmd({ 'FileType' }, {
  group = emmet_vim,

  desc = 'Added emmet to the filetype with html',

  pattern = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
  command = 'EmmetInstall',
});

