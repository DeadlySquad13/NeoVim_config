local prequire = require('ds_omega.utils').prequire

local sj_is_available, sj = prequire('sj')

if not sj_is_available then
  return 
end

-- Keymappings used during the search are in settings.
return {
  n = {
    ['/'] = { sj.run, 'Search and jump' },
    ['?'] = { function() sj.run({ forward_search = false }) end, 'Search and jump backwards' },
    ['<Leader>'] = {
      -- Default bindings that we have overriden in case you just want to iterate over search results.
      ['/'] = { '/', 'Search' },
      ['?'] = { '?', 'Search backwards' },

      -- Conflicts with substitute.
      -- Like a leap but a little bit different.
      -- s = { function() sj.run({ search_scope = 'visible_lines' }) end, 'Search and jump across visible lines' },
      -- S = { function() sj.run({ search_scope = 'visible_lines', forward_search = false }) end, 'Search and jump across visible lines backwards' },
    },
  },
}
