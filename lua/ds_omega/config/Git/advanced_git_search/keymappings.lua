local prequire = require('ds_omega.utils').prequire
local utils_is_available, utils = prequire('ds_omega.config.keymappings._common.utils')

if not utils_is_available then
  return
end

local cmd = utils.cmd

return {
    n = {
        ['<Leader>g'] = {
            n = {
                cmd 'AdvancedGitSearch',
                'Advanced git search',
            }
        }
    }
}
