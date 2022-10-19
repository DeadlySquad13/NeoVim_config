-- local utils = require('config.queries.utils')
-- local read_local_query_files, set_query =
-- utils.read_local_query_files, utils.set_query

-- local new_highlight_query = read_local_query_files(
--   'typescript', 'highlights'
-- )

P('captures')
-- set_query('typescript', 'highlights', new_highlight_query)
-- set_query('tsx', 'highlights', new_highlight_query)
require('nvim-treesitter.highlight').set_custom_captures({
  ['function.declaration'] = 'TSFunctionDeclaration',
  ['keyword.export'] = 'TSKeywordExport',
  ['keyword.declaration'] = 'TSKeywordDeclaration',
  ['class'] = 'TSConstructor',
  ['class.builtin.fundamental'] = 'TSClassBuiltinFundamental',
  ['class.builtin.error'] = 'TSClassBuiltinError',
  ['class.builtin.number_or_date'] = 'TSClassBuiltinNumberOrDate',
  ['class.builtin.text_processing'] = 'TSClassBuiltinTextProcessing',
  ['class.builtin.indexed_collection'] = 'TSClassBuiltinIndexedCollection',
  ['class.builtin.keyed_collection'] = 'TSClassBuiltinKeyedCollection',
  ['class.builtin.structured_data'] = 'TSClassBuiltinStructuredData',
  ['class.builtin.control_abstraction'] = 'TSClassBuiltinControlAbstraction',
  ['class.builtin.reflection'] = 'TSClassBuiltinReflection',
})
