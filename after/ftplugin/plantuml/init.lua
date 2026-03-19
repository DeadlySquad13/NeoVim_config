local apply_bufferlocal_keymappings = require('ds_omega.config.Ui.which_key.utils').apply_bufferlocal_keymappings

local plantuml_cmd = [[<Cmd>:!plantuml "%" -tpng && plantuml "%" -tsvg<Cr>]]
local kroki_cmd = [[<Cmd>:!kroki convert "%" --type plantuml && kroki convert "%" --type plantuml --format png<Cr>]]

apply_bufferlocal_keymappings('n', {
  ['<Cr>'] = {
    -- Unfortunately, includes didn't work when working with kroki in
    -- docker container. Kroki is still ok for most cases so leaving as
    -- fallback.
    --
    -- May be related:
    -- https://github.com/yuzutech/kroki/issues/1638
    vim.fn.executable('plantum') and plantuml_cmd or kroki_cmd,
    'Convert current file to svg and png',
  },
})
