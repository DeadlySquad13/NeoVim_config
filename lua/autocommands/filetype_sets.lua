local utils = require('utils')
local create_augroup, create_autocmd = utils.create_augroup, utils.create_autocmd

-- NOTE: clear option - clears previously created autocommands in augroup.

---  Set settings for files that are not identified as a particular filetype.
local FiletypeSets = create_augroup('FiletypeSets', { clear = true })

---@table<pattern, table<setting_name: setting_value>>
local FILETYPE_SETS = {
  ['.wslconfig'] = { syntax = 'sh' }, -- Wsl config.
  ['.wyrdrc'] = { syntax = 'conf' }, -- Wyrd config.

  -- Latex.
  ['*.tplx'] = { syntax = 'tex' }, -- Templates.
  ['*.tex.j2'] = { syntax = 'tex' }, -- Templates for notebook.

  ['setup.cfg'] = { filetype = 'dosini' }, -- Python module config.
}

for pattern, settings in pairs(FILETYPE_SETS) do
  create_autocmd({ 'BufNewFile', 'BufReadPost' }, {
    group = FiletypeSets,
    desc = 'Set appropriate filetype for a file.',
    pattern = pattern,

    callback = function()
      require('utils.setters').set_settings(settings)
    end
  })
end
