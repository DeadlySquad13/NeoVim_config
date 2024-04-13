return {
  'idbrii/textobj-word-column.vim',
  dependencies = 'kana/vim-textobj-user',
  opts = {
    no_default_key_mappings = 1
  },
  config = function(_, opts)
    local setters = require('ds_omega.utils.setters')

    setters.set_global_variables(opts, 'textobj_wordcolumn')
    vim.fn['textobj#user#map'](
      'wordcolumn',
      {
        word = {
          ['select-i'] = 'Qc',
          ['select-a'] = 'Ec',
        },
        WORD = {
          ['select-i'] = 'QC',
          ['select-a'] = 'EC',
        },
      }
    )
  end
}
