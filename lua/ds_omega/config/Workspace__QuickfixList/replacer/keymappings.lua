local opts = require('ds_omega.config.Workspace__QuickfixList.replacer.settings')

return {
  n = {
    ['<Leader>q'] = {
      t = { function() require('replacer').run(opts) end, 'Turn on quickfix replacer' },
      w = { function() require('replacer').save(opts) end, 'Save changes from quickfix replacer' },
    }
  },
}
