-- Somehow fixes fallback behaviour during tab in nvim-cmp
--   (otherwise ultisnips tries to expand even if it can't and throws error,
--   preventing *normal* fallback --- tab).
--vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)';
-- - Defining it explicitly so that it can be used with
--   UltiSnips-visual-placeholder
vim.g.UltiSnipsExpandTrigger = '<c-tab>';
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)';
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)';
vim.g.UltiSnipsListSnippets = '<c-x><c-s>';
vim.g.UltiSnipsRemoveSelectModeMappings = 0;

-- - Optimizing `provider#python3#Call()` by hardcoding python path (which
--   python).
vim.g.loaded_python_provider = 1;
vim.g.python_host_skip_check = 1;
vim.g.python_host_prog = '/usr/bin/python';
vim.g.python3_host_skip_check = 1;
vim.g.python3_host_prog = '/usr/bin/python';


