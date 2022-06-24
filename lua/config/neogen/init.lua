local prequire = require('utils').prequire;

local neogen_is_available, neogen = prequire('neogen');

if not neogen_is_available then
  return;
end

local settings_dir = 'config.neogen.settings';

local python = require(settings_dir .. '.python');
local lua = require(settings_dir .. '.lua');

neogen.setup({
  enabled = true,
  input_after_comment = true, -- (default: true) automatic jump (with insert mode) on inserted annotation
  languages = {
    python = python,
    lua = lua,
  },
});
