let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Files']            },
  \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ ]

let g:startify_bookmarks = [
  \ { 'c': '~/.config/i3/config' },
  \ { 'i': '~/.config/nvim/init.vim' },
  \ { 'z': '~/.zshrc' },
  \ '~/Blog',
  \ '~/Code',
  \ '~/Pics',
\ ]

" - Automatically restart session.
let g:startify_session_autoload = 1
" - Let Startify take care of buffers.
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
" - Save session automatically.
let g:startify_session_persistence = 1
