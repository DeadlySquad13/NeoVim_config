set nocompatible
" General.
" Bash doesn’t load your .bashrc unless it’s interactive.
set shellcmdflag=-ic

" - Enable settings for specific filetypes.
filetype plugin on
set encoding=utf-8

" - Delay before showing message in ms (which-key).
set timeoutlen=500

" Don't parse long lines for syntax highlight.
set synmaxcol=256
syntax sync minlines=256

" Support for embedded scripts (for example, lua in init.vim)
" - Syntax highlighting.
let g:vimsyn_embed='l'
" - Folding. a: augroups, f - functions.
"let g:vimsyn_folding='af'

" Behave like smartcase when adding word to dictionary.
if has('syntax')
  set spellcapcheck=
endif

set spell spelllang=en_us,ru_ru
" Think of camelCased words as separate words (camel and Cased will be parsed). 
set spelloptions=camel

" Insert only one space after joining lines ending with '.', '?'...
set nojoinspaces

" Gutter.
set number relativenumber

set noswapfile

" Number of lines visible before edge of viewport.
set scrolloff=5
set sidescrolloff=3

" To much hassle with setting nice wrapping, too much inconsistencies across
"   different environments. Just format text yourself and make people on
"   github happier.
" In case someone sends you unformatted text, format it or use horizontal
"   commands.
set nowrap

" - Minimal configuration:
"set autoindent
"set smartindent   " Do smart autoindenting when starting a new line
set shiftwidth=2  " Set number of spaces per auto indentation
set expandtab     " When using <Tab>, put spaces instead of a <tab> character

" - Good to have for consistency.
set tabstop=2   " Number of spaces that a <Tab> in the file counts for
set softtabstop=2
set smarttab    " At <Tab> at beginning line inserts spaces set in shiftwidth

"syntax on
"filetype plugin indent on

set fileformat=unix

" - Persistant undo.
set undodir=~/.config/.nvim/undo
set undofile

" - Persistant buffers.
set hidden

" - Try to reuse windows / tabs when switching buffers.
set switchbuf=usetab

" Motions that are allowed to cross line boundaries.
"   Go the end of the previous line / start of the next line easier.
set whichwrap+=h,l

" Give freedom to visual mod by allowing it to travel when there's no text.
if has('virtualedit')
  set virtualedit=block
endif

" Plugins.
call plug#begin('~/.vim/plugged')
  " General.
  Plug 'folke/which-key.nvim'
  " * Integration.
  " - With system.
  Plug 'majkinetor/vim-omnipresence'
  " - With browser.
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
  " * Open and write files with sudo.
  Plug 'lambdalisue/suda.vim'

  Plug 'tpope/vim-repeat'
  Plug 'tomtom/tinykeymap_vim'

  " * Starting page.
  "Plug 'mhinz/vim-startify'
  Plug 'glepnir/dashboard-nvim'

  " * Sessions.
  "Plug 'rmagatti/auto-session'

  " * Session management.
  "Plug 'rmagatti/session-lens'

  " * Russian layout.
  Plug 'powerman/vim-plugin-ruscmd'

  " LSP.
  Plug 'neovim/nvim-lspconfig'

  " * Snippets.
  Plug 'SirVer/ultisnips'
  " - Collections of snippets.
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'

  " * Autocomplete
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " for ultisnips users.
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  " - Python formatter.
  Plug 'tell-k/vim-autopep8'

  "" For vsnip users.
  "Plug 'hrsh7th/cmp-vsnip'
  "Plug 'hrsh7th/vim-vsnip'

  " For luasnip users.
  " Plug 'L3MON4D3/LuaSnip'
  " Plug 'saadparwaiz1/cmp_luasnip'

  " For snippy users.
  " Plug 'dcampos/nvim-snippy'
  " Plug 'dcampos/cmp-snippy'

  " Coding.
  " * Brackets.
  Plug 'windwp/nvim-autopairs'

  " * Comments.
  Plug 'preservim/nerdcommenter'

  " * Surround.
  Plug 'tpope/vim-surround'

  " * Find.
  Plug 'gennaro-tedesco/nvim-peekup'

  " * Batching.
  Plug 'terryma/vim-expand-region'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " * Permutations.
  Plug 'tpope/vim-abolish'

  " * Formatting.
  Plug 'junegunn/vim-easy-align'

  " * Motion.
  Plug 'tjdevries/train.nvim'
  Plug 'ggandor/lightspeed.nvim'

  " # Targets.
  Plug 'wellle/targets.vim'
  " Textobj-user extensions.
  Plug 'kana/vim-textobj-user'
  " - Columns.
  Plug 'idbrii/textobj-word-column.vim'
  " - Indented paragraph.
  Plug 'pianohacker/vim-textobj-indented-paragraph'
  " - Indents.
  Plug 'kana/vim-textobj-indent'

  " * Case delimited and _ delimited words.
  Plug 'chaoren/vim-wordmotion'

  " # Navigation.
  " * Inside  file.
  " * Across files.
  Plug 'kevinhwang91/rnvimr'
  Plug 'preservim/nerdtree'

  " * Telescope deps.
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  " - Jumping to file under cursor.
  Plug 'aklt/rel.vim'

  " Markdown.
  " Plug 'plasticboy/vim-markdown'
  Plug 'SidOfc/mkdx'
  " * Preview.
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
  " Visuals.
  " * Highlight range of an exmode command.
  Plug 'winston0410/cmd-parser.nvim'
  Plug 'winston0410/range-highlight.nvim'

  " * Workspace.
  Plug 'Pocco81/TrueZen.nvim'
  Plug 'folke/twilight.nvim'
  " * Status line.
  Plug 'vim-airline/vim-airline'
  " * Theme.
  Plug 'morhetz/gruvbox'
  Plug 'sainnhe/gruvbox-material'
  Plug 'vim-airline/vim-airline-themes'
  " - Helpers for creating a theme.
  Plug 'tjdevries/colorbuddy.nvim'

  " * Highlight colors.
  Plug 'norcalli/nvim-colorizer.lua'
  " * Hide cursorline during moving, highlight words under cursor.
  Plug 'yamatsum/nvim-cursorline'
  " * Brackets.
  Plug 'p00f/nvim-ts-rainbow'
  " * Indents.
  Plug 'lukas-reineke/indent-blankline.nvim'
  " * Icons. (!) Should be loaded last (after nerd-tree, airline, etc...).
  "   Nerd patched fonts required.
  Plug 'ryanoasis/vim-devicons' 
call plug#end()

" General keybindings.
let mapleader=' '
let maplocalleader='\'

" Integration with system.
let g:omnipresence_hotkey = 'f11'

" Search for item under cursor in vim docs (:help).
" - 'investigate help'
noremap <leader>gih K

" - Search for tags.
nnoremap <leader>st :%s;<\w*>\(<\\\w*>\)\?;;g<left><left>

"source 'plug-config.vim'
" Starting screen.
" * Dashboard
" - Select which fuzzy search plugins to apply.
let g:dashboard_default_executive='telescope'
" - Custom sections (commands).
"let g:dashboard_custom_section={
  "\ 'edit_config': {
      "\ 'description': [' Edit config                 SPC e c'],
      "\ 'command': ':e $MYVIMRC' }
  "\ }
"let g:dashboard_custom_section={
      "\ 'a': {'description': [ "  Find File                        leader f f" ], 'command': "Telescope find_files"},
      "\ 'b': {'description': [ "  Recents                          leader f h" ], 'command': "Telescope oldfiles"},
      "\ 'c': {'description': [ "  Find Word                        leader f g" ], 'command': "Telescope live_grep"},
      "\ 'd': {'description': [ "  New File                         leader e n" ], 'command': "DashboardNewFile"},
      "\ 'e': {'description': [ "  Bookmarks                        leader m  " ], 'command': "Telescope marks"},
      "\ 'f': {'description': [ "  Load Last Session                leader l  " ], 'command': "SessionLoad"},
      "\ 'g': {'description': [ "  Update Plugins                   leader u  " ], 'command': "PlugUpdate"},
      "\ 'h': {'description': [ "  Settings                         leader e v" ], 'command': "edit $MYVIMRC"},
      "\ 'i': {'description': [ "  Exit                             leader q  " ], 'command': "exit"}
    "\ }
let s:dashboard_shortcut={}

let s:dashboard_shortcut['last_session'] = 'SPC s l'
let s:dashboard_shortcut['find_history'] = 'SPC f h'
let s:dashboard_shortcut['find_file'] = 'SPC f f'
let s:dashboard_shortcut['new_file'] = 'SPC c n'
let s:dashboard_shortcut['change_colorscheme'] = 'SPC t c'
let s:dashboard_shortcut['find_word'] = 'SPC f a'
let s:dashboard_shortcut['book_marks'] = 'SPC f b'

let s:dashboard_shortcut_icon={
  \'last_session': ' ',
  \'find_history': ' ',
  \'find_file': ' ',
  \'new_file': ' ',
  \'change_colorscheme': ' ',
  \'find_word': ' ',
  \'book_marks': ' '
\}

lua << EOF
-- Don't understand how to get it from vim.
local leader = 'Space'
local localleader = '\\'

local dashboard_items = {
  edit_config = {
    description = {
      icon = '',
      action = 'Edit vim config                     ',
      shortcut = leader..' e v'
    },
    command = 'edit $MYVIMRC'
  },
  find_history = {
    description = {
      icon = '',
      action = 'Recently opened files               ',
      shortcut = leader..' o r'
    },
    command = ''
  },
  find_file = {
    description = {
      icon = '',
      action = 'Find file                           ',
      shortcut = leader..' o f'
    },
    command = ''
  },
  new_file = {
    description = {
      icon = '',
      action = 'New file                            ',
      shortcut = leader..' o n'
    },
    command = ''
  },
  change_colorscheme = {
    description = {
      icon = '',
      action = 'Change colorscheme                  ',
      shortcut = leader..' s t'
    },
    command = ''
  },
  find_word = {
    description = {
      icon = '',
      action = 'Find word                           ',
      shortcut = leader..' f w'
    },
    command = ''
  },
  bookmarks = {
    description = {
      icon = '',
      action = 'Jump to bookmarks                   ',
      shortcut = leader..' g b'
    },
    command = ''
  }
}

local dashboard_custom_section = {}

for key, item in pairs(dashboard_items) do
  local description = item.description
  local icon = description.icon
  local action = description.action
  local shortcut = description.shortcut

  local command = item.command

  dashboard_custom_section[key] = {
    description = { icon..' '..action..shortcut },
    command = command
  }
end

vim.g.dashboard_custom_section = dashboard_custom_section
EOF

augroup Dashboard
     autocmd! * <buffer>
     autocmd User dashboardReady let &l:stl = 'Dashboard'
     autocmd User dashboardReady nnoremap <buffer> <leader>qe :exit<cr>
     "autocmd User dashboardReady nnoremap <buffer> <leader>u <cmd>PackerUpdate<CR>
     autocmd User dashboardReady nnoremap <buffer> <leader>l <cmd>SessionLoad<CR>
augroup END

" - Custom header.
let g:dashboard_custom_header=[
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                    ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣶⣿⡟⠀                   ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣦⣄⠀⣀⣠⣤⣤⣶⣶⣶⣶⣶⣴⣾⣿⣿⣿⣿⣿⣿⡟⠁⠀                   ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡿⠯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿⣿⣿⣿⡟⠀⠀    ___  ___________',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⡀⢨⣿⣿⡃⠀⠀⠀⠀ / _ \/ __<  /_  /',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀/ // /\ \ / //_ < ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢫⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀/____/___//_/____/ ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢃⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣇⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⢇⣿⣿⣿⣿⡈⣻⡝⢿⣿⣿⢿⣟⣹⣁⢀⠘⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢙⠇⣿⣿⣿⠻⣿⣿⠢⠁⠉⠛⠛⠻⣿⣿⠿⠋⠓⠹⢋⡽⢹⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡎⢾⡏⢠⠍⢡⣳⡟⠀⠀⠀⠀⠀⠀⠁⠉⠀⠠⢆⠐⠍⠒⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⡘⠐⠁⠀⢁⡋⠄⠀⠀⠀⠀⠀⠀⠀⠀⠁⠒⡀⠂⠀⠀⢹⣿⣿⣿⣿⡿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⣻⣄⣣⡀⠻⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠡⠀⠀⠀⠀⣸⣿⣿⣿⣿⠃⠡⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣄⠀⠀⠈⠳⣦⠉⠀⠀⠀⢀⠠⡰⠁⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⡀⠀⠓⠠⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⢸⣟⣀⡑⢄⠀⠀⢻⡇⣴⣶⣿⡆⡈⠀⠀⠀⠀⣰⣿⣿⣿⣿⡿⢀⡟⠁⠀⠀⠀⠐⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠁⠀⠀⠈⠙⣾⠀⣀⡼⢸⣿⣿⣿⣿⣿⡀⠀⠀⣸⣿⣿⣿⣿⡟⣠⡟⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡌⠀⠀⠀⠀⠀⠘⢸⠑⡁⢸⣿⣿⣿⣿⣿⠀⠉⠁⢸⣿⣿⣿⣿⣷⣿⠁⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠶⠁⠀⠀⠀⠈⠀⡇⠀⠀⠁⠸⣹⣿⡿⡿⣿⠀⠀⠀⢸⣿⣿⣿⣿⠏⣿⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠇⠀⠀⠀⠀⢱⠀⠀⠀⠀⠆⢿⣣⡄⠀⣺⠀⠀⠀⠘⣿⣿⣿⡟⢰⡇⡇⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣆⢠⠀⠀⠀⣀⡜⠀⠀⠀⠀⢀⣆⣿⡶⠾⢻⠀⠀⠀⠀⢸⣿⣿⣧⣸⣧⡃⠀⢀⣀⣠⣤⣄⡀⡆⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡷⣄⠀⠀⠇⠀⠀⠀⠀⢺⣿⡿⠀⠀⢀⠀⠀⠀⠀⠈⣿⣿⠛⣿⣯⠖⠊⠉⠀⠀⠀⣼⠙⠢⡀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⢠⣇⠈⠳⡼⠀⠀⠀⠀⠀⢸⣿⠃⡆⠀⢸⠀⠀⠀⠀⠀⢻⣿⣴⠟⠀⠀⠀⠀⠀⠀⣰⣿⠀⠀⡁⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⢿⠀⠀⠃⠀⠀⠀⠠⠄⢻⠇⢀⠁⠀⢸⠀⠀⠀⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⠠⣸⢸⡤⠊⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠤⡈⠀⠀⠀⠀⠀⠀⢸⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢛⡟⠦⠤⠂⠀⠀⣠⠗⡏⠁⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠁⠀⠀⠀⠀⠀⠀⢸⡀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡌⠢⠀⠀⠀⣰⣿⣔⣀⣀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡈⠀⠀⠀⠀⠀⠀⠀⢸⣷⣇⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⢘⠀⠀⠀⣰⣿⣏⢌⠀⠀⠀⠆             ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣦⣴⣿⡀⠀⠀⠀⠀⠀⠀⢸⡇⠀⣰⣿⣿⣷⣼⣀⡀⠜⠲⠀⠀⠀⠀⠀⠀⠀⠀     ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⡀⠀⠀⠀⠀⠀⠠⠛⠛⠋⠙⠿⣿⣷⡀⠀⠀⠀⠀⠀⠘⢀⣼⣿⣿⣿⣿⡝⠃⠀⠀⣼⠀⠀    ⠀⠀   ⠀ ',
  \'⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣴⣶⣄⠀⠀⠀⣠⣷⣶⣶⣶⣶⣶⣶⣿⣷⡄⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋     ',
  \'⠀⠀⠀⠀⠀⠀⢀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀      ',
  \'⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠉          '
\]

let g:dashboard_custom_footer=[
    \ 'I did your vim operator exercises and my hand ended up stuck inside my ass.
    \ What should I do?',
    \ '',
    \ '                                         - Vim more.'
  \ ]

" Session.
" * Save automatically.
"function! MakeSession()
  "let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  "if (filewritable(b:sessiondir) != 2)
    "exe 'silent !mkdir -p ' b:sessiondir
    "redraw!
  "endif
  "let b:filename = b:sessiondir . '/session.vim'
  "exe "mksession! " . b:filename
"endfunction

"" * Load automatically.
"function! LoadSession()
  "let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  "let b:sessionfile = b:sessiondir . "/session.vim"
  "if (filereadable(b:sessionfile))
    "exe 'source ' b:sessionfile
  "else
    "echo "No session loaded."
  "endif
"endfunction

"" Adding automatons for when entering or leaving Vim
"if(argc() == 0)
  "au VimEnter * nested :call LoadSession()
"endif
"au VimLeave * :call MakeSession()

" LSP
" * Autocomplete.
set completeopt=menu,menuone,noselect
let g:autopep8_disable_show_diff=1

" Use omni completion provided by lsp.
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Ultisnips.
"let g:UltiSnipsExpandTrigger = '<c-g>'
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'             
let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'  
let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
let g:UltiSnipsListSnippets = '<c-x><c-s>'                            
let g:UltiSnipsRemoveSelectModeMappings = 0 
" - Optimizing `provider#python3#Call()` by hardcoding python path (which
"   python).
let g:loaded_python_provider = 1
let g:python_host_skip_check = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_skip_check = 1
let g:python3_host_prog = '/usr/bin/python'

lua <<EOF
  -- Setup nvim-cmp.
  -- config = function()      
  --     vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'      
  --     vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
  --     vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
  --     vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
  --     vim.g.UltiSnipsRemoveSelectModeMappings = 0
  -- end

  -- config()

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local ultisnips_engine = {
    can_jump = function()
      return vim.fn["UltiSnips#CanJumpForwards"]() == 1
    end,

    jump = function()
      return vim.api.nvim_feedkeys(
        t("<Plug>(ultisnips_jump_forward)"), 'm', true
      )
    end,

    can_jump_backwards = function()
      return vim.fn["UltiSnips#CanJumpBackwards"]() == 1
    end,

    jump_backward = function()
      return vim.api.nvim_feedkeys(
        t("<Plug>(ultisnips_jump_backward)"), 'm', true
      )
    end,

    can_expand = function()
      return vim.fn["UltiSnips#CanExpandSnippet"]() == 1
    end,

    expand = function()
      -- Maybe replace with #Anon?
      print('expand!')
      return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
      -- return vim.fn.feedkeys(t("<C-R>=UltiSnips#Anon()<CR>"))
    end,
  }

  local snippets_engine = ultisnips_engine;

  local cmp = require('cmp')
  -- Optional.
  -- local cmp_nvim_ultisnips = require('cmp_nvim_ultisnips').setup {}
  local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

  cmp.setup {
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,

    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
      }, {
        { name = 'buffer' },
      }),

    mapping = {
      ["<Tab>"] = cmp.mapping({
          c = function(fallback)
            if cmp.visible() then
              -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              -- `select = true` enables immediate autocomplete without selection
              --   <c-space><tab> gives the first result.
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            else
              fallback()
            end
          end,

          i = function(fallback)
            if cmp.visible() then
              -- If you haven't started browsing snippets yet, choose next (first).
              -- if not cmp.get_active_entry() then
              --   return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              -- end
              if snippets_engine.can_expand() then
                return snippets_engine.expand()
              end


              return cmp.confirm({ select = true })
            end

            return fallback()
          end,

          s = function(fallback)
            if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
            else
              fallback()
            end
          end
      }),

      -- Just defining function doesn't work.
      ['<c-j>'] = cmp.mapping(
        function(fallback)
          if snippets_engine.can_jump() then
            return snippets_engine.jump()
          end
          
          return fallback()
        end,
        {'i', 'c', 's'}
      ),

      -- Just defining function doesn't work.
      ['<c-k>'] = cmp.mapping(
        function(fallback)
          if snippets_engine.can_jump_backwards() then
            return snippets_engine.jump_backward()
          end
          
          return fallback()
        end,
        {'i', 'c', 's'}
      ),

      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

      ['<C-n>'] = cmp.mapping({
        c = function()
          if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
          else
              vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
          end
        end,

        i = function(fallback)
          if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
          else
              fallback()
          end
        end
      }),

      ['<C-p>'] = cmp.mapping({
        c = function()
          if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
          else
              vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
          end
        end,

        i = function(fallback)
          if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Replace })
          else
              fallback()
          end
        end
      }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),

      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),

      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.close(),
        c = cmp.mapping.close()
      }),
    },
  }

  -- * Enabling support for autopairs.
  -- * If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


  -- ? Is it used only for lisp?.
  -- * Add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure",
  --"clojurescript", "fennel", "janet" }
  cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

  -- Use buffer source for `/`.
  cmp.setup.cmdline('/', {
    completion = { autocomplete = false },
    sources = {
      -- { name = 'buffer' }
      { name = 'buffer', opts = { keyword_pattern = [=[[^[:blank:]].*]=] } }
    }
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    sources = cmp.config.sources({
      { name = 'path' }
      }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local lspconfig = require('lspconfig')
  local configs = require('lspconfig.configs')

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local npm_global_modules_path = vim.fn.getenv 'HOME' .. '/.npm-global/lib/node_modules'

  -- local servers = { 'pylsp', 'tsserver', 'vimls' }

  -- for _, lsp in ipairs(servers) do
  --   lspconfig[lsp].setup {
  --     on_attach = on_attach,
  --     capabilities = capabilities,
  --   }
  -- end

  -- * Python.
  -- lspconfig.pylsp.setup {
  --   capabilities = capabilities
  -- }

  -- * Typescript.
  -- lspconfig.tsserver.setup {
    -- Default values.
    -- cmd = { "typescript-language-server", "--stdio" },
    -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    -- init_options = {
    --   hostInfo = "neovim"
    -- },
      -- root_dir = root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),

    -- capabilities = capabilities,
  -- }

  -- * Vim.
  lspconfig.vimls.setup {
    cmd = { npm_global_modules_path .. '/vim-language-server/bin/index.js', '--stdio' },

    capabilities = capabilities,

    filetypes = { "vim" },
    init_options = {
      diagnostic = {
        enable = true
      },
      -- If you want to speed up index, change gap to smaller and count to
      -- greater, this will cause high CPU usage for some time.
      indexes = {
        -- Count of files index at the same time.
        count = 3,
        -- Index time gap between next file.
        gap = 100,
        projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
        -- Index vim's runtimepath files.
        runtimepath = true
      },
      iskeyword = "@,48-57,_,192-255,-#",
      runtimepath = "",
      suggest = {
        fromRuntimepath = true,
        fromVimruntime = true
      },
      vimruntime = ""
    },
  }

  -- * Emmet.
  --if not configs.ls_emmet then
  --  configs.ls_emmet = {
  --    default_config = {
  --      cmd = { 'ls_emmet', '--stdio' };
  --      filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'haml',
  --        'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less', 'sss'};
  --      root_dir = function(fname)
  --        return vim.loop.cwd()
  --      end;
  --      settings = {};
  --    };
  --  }
  --end

  --lspconfig.ls_emmet.setup{ capabilities = capabilities }
EOF

" * General.
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>

" * Investigation.
" - & is ? in Russian layout.
nnoremap <silent> <leader>gi& <cmd>lua vim.lsp.buf.hover()<CR>
" - Implementation.
nnoremap <silent> <leader>gii <cmd>lua vim.lsp.buf.implementation()<CR>

" - Declaration.
nnoremap <silent> <leader>giD <cmd>lua vim.lsp.buf.declaration()<CR>

" - Type definition.
nnoremap <silent> <leader>git <cmd>lua vim.lsp.buf.type_definition()<CR>

" - Definition.
nnoremap <silent> <leader>gid <cmd>lua vim.lsp.buf.definition()<CR>

" * Searching.
nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>g0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>gW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>


" # Treesitter.
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    -- General.
    'regex',
    'python',
    'lua',

    -- System programming.
    'bash',

    -- Web development.
    'typescript',
    'javascript',
    'css',
    'scss',
    -- - React.
    -- 'jsx',
    'tsx',

    -- C family.
    'cmake',
    'c',
    'cpp',
  },
  ignore_install = { }, -- List of parsers to ignore installing
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {  }, -- list of language that will be disabled

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Brackets.
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
EOF
" Coding
" * Wordmotion.
" relevant only with smart find (for example, from vim-lighspeed)
" \ and overwrites ; of vim-targets.
let g:wordmotion_prefix = ';'

" # Formatting.
" * Easy Align.
" - Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" * Copy all file into system register (*).
nnoremap y% gg"*yG

" * Matching braces.
packadd! matchit

"unmap +
" * Expand region.
call tinykeymap#EnterMap('ExpandRegion', '<a-v>',
      \ { 'name': 'expand region mode' })
call tinykeymap#Map('ExpandRegion', 'v',
      \ 'execute "normal \<Plug>(expand_region_expand)"',
      \ { 'desc': 'Expand selection' })
call tinykeymap#Map('ExpandRegion', 'V',
      \ 'execute "normal \<Plug>(expand_region_shrink)"',
      \ { 'desc': 'Shrink selection' })

" * Surround.
"  HELP: *surround-customizing*, *curly-braces-names*
" - visually select what you want to wrap and then press S- to tigger
"   the - surrounding. It will then prompt you for a 'start' and 'ending' text.
let g:surround_{char2nr('-')} = "\1start: \1\r\2end: \2"
" - **L**ua anonymous function.
let g:surround_{char2nr('la')} = "function() \r end"

" * Create a new line above the current one without exiting normal mode.
map <Leader>O mtO<Esc>`t

" * Create a new line below the current one without exiting normal mode.
map <Leader>o mto<Esc>`t

" * Keep visual mode after indent.
vnoremap > >gv
vnoremap < <gv

" * Select just pasted text in last used mode [if you used linewise selection
" - V, if characterwise - v,..].
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" * Yanking.
" - Keep cursor at the same place after yanking.
vmap y ygv<esc>

" - Make Y behave similar to D in normal mode.
nnoremap Y y$

" * Open new file in vertical split (similar to built-in <c-w>n).
nnoremap <c-w>v :vnew<cr>

" * Remaping line concatenation for use of j with modifier in non-vim apps.
noremap <a-j> J

" * Search and replace:
" - Current word under cursor.
nnoremap <leader>sw :%s;\<<c-r><c-w>\>;;g<left><left>
"vnoremap <leader>sw <esc>:%s;\<<c-r><c-w>\>;;g<left><left>

" NERDCommenter.
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

" * Shortcuts for settings.
" - Open vimrc in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" - Source vimrc.
nnoremap <leader>sv :source $MYVIMRC<cr>

"function! HorizontalScrollMode( call_char )
    "if &wrap
        "return
    "endif

    "echohl Title
    "let typed_char = a:call_char
    "while index( [ 'h', 'l', 'H', 'L' ], typed_char ) != -1
        "execute 'normal! z'.typed_char
        "redraws
        "echon '-- Horizontal scrolling mode (h/l/H/L)'
        "let typed_char = nr2char(getchar())
    "endwhile
    "echohl None | echo '' | redraws
"endfunction

" * Vertical.
nnoremap <c-y> 3<c-y>
nnoremap <c-e> 3<c-e>

" Brackets autopairs.
lua << EOF
  local nvim_autopairs = require('nvim-autopairs')
  nvim_autopairs.setup {
    disable_filetype = { "TelescopePrompt" },
      -- disable when recording or executing a macro
    disable_in_macro = false,
     -- disable when insert after visual block mode
    disable_in_visualblock = false,
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]],"%s+", ""),
    enable_moveright = true,
      -- add bracket pairs after quote
    enable_afterquote = true,
      --- check bracket in same line
    enable_check_bracket_line = true,
    check_ts = false,
      -- map the <BS> key
    map_bs = true,
      -- Map the <C-h> key to delete a pair
    map_c_h = true,
     -- map <c-w> to delete a pair if possible
    map_c_w = false,
  }
EOF

" * Windows.
set splitright

"if has('autocmd')
	"" change colorscheme depending on current buffer
	"" if desired, you may set a user-default colorscheme before this point,
	"" otherwise we'll use the Vim default.
	"" Variables used:
		"" g:colors_name : current colorscheme at any moment
		"" b:colors_name (if any): colorscheme to be used for the current buffer
		"" s:colors_name : default colorscheme, to be used where b:colors_name hasn't been set
	"if has('user_commands')
		"" User commands defined:
			"" ColorScheme <name>
				"" set the colorscheme for the current buffer
			"" ColorDefault <name>
				"" change the default colorscheme
		"command -nargs=1 -bar ColorScheme
			"\ colorscheme <args>
			"\ | let b:colors_name = g:colors_name
		"command -nargs=1 -bar ColorDefault
			"\ let s:colors_name = <q-args>
			"\ | if !exists('b:colors_name')
				"\ | colors <args>
			"\ | endif
	"endif
	"if !exists('g:colors_name')
		"let g:colors_name = 'default'
	"endif
	"let s:colors_name = g:colors_name
	"au BufEnter *
		"\ let s:new_colors = (exists('b:colors_name')?(b:colors_name):(s:colors_name))
		"\ | if s:new_colors != g:colors_name
			"\ | exe 'colors' s:new_colors
		"\ | endif
"endif

" Personal settings.
" * Folding.
" - Characters shown on the right of the fold.
" Middle dot 0119·
set fillchars+=fold:\ 
set foldtext=CustomFoldText()

setlocal foldexpr=GetPotionFold(v:lnum)
function! GetPotionFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif
  let this_indent = IndentLevel(a:lnum)
  let next_indent = IndentLevel(NextNonBlankLine(a:lnum))
  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfunction
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction
function! NextNonBlankLine(lnum)
  let numlines = line('$')
  let current = a:lnum + 1
  while current <= numlines
      if getline(current) =~? '\v\S'
          return current
      endif
      let current += 1
  endwhile
  return -2
endfunction
function! CustomFoldText()
  " get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif
  " Width of a viewport.
  "let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let minimalColorColumn = split(&cc, ',')[0]
  let w = minimalColorColumn - 1

  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeFormatted = "    " . foldSize . "ℓ"

  let foldLevelFormatted = repeat(" ~>", v:foldlevel)
  let expansionString = repeat(" ", w -
    \ strwidth(foldSizeFormatted.line.foldLevelFormatted))

  return line . expansionString . foldSizeFormatted . foldLevelFormatted
endfunction

" - Fold settings.
set foldcolumn=3

set foldlevelstart=2
set foldnestmax=3

augroup Folding
  autocmd!
  autocmd BufReadPre * setlocal foldmethod=expr
  "autocmd BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
  " Open all folds under cursor.
  " autocmd BufWinEnter * silent normal! zO
augroup END

augroup Markdown
  " Clear all autocommands that were set before that.
  autocmd!
  "autocmd BufNewFile,BufReadPost *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
   "autocmd Filetype markdown set filetype=markdown
  let g:vim_markdown_fenced_languages = [
    \'css',
    \'sass',
    \
    \'javascript',
    \'js=javascript',
    \'json=javascript',
    \
    \'python',
    \'py=python',
    \
    \'xml',
    \'html'
  \]
  " - Folding
  let g:vim_markdown_folding_level=3

  " - Enabling conceal for ~~strikethroughText~~
  let g:vim_markdown_strikethrough = 1

  " - Disabling autoindentation on `o`.
  let g:vim_markdown_new_list_item_indent = 0

  " - Autofit table of contents.
  let g:vim_markdown_toc_autofit = 1

  " - Enalbe follow the anchors (links) inside file.
  let g:vim_markdown_follow_anchor = 1

  " - Concealing things like **bold**.
  autocmd FileType markdown setlocal conceallevel=2 
augroup END

augroup Python
  " Clear all autocommands that were set before that.
  autocmd!
  " - Sets.
  autocmd FileType python setlocal tabstop=4
  autocmd FileType python setlocal softtabstop=4
  autocmd FileType python setlocal shiftwidth=4
  " - Run.
  autocmd FileType python nnoremap <buffer> <localleader><cr> :!python %<cr>
augroup END

augroup Graphviz
  " Clear all autocommands that were set before that.
  autocmd!
  " - Swap relationships.
  autocmd FileType dot nnoremap <buffer> <localleader>sr ^"yct-<esc>2W"yP"yD^X"yPa<space><esc>
  " - Run: create png from name of the current file and open it.
  autocmd FileType dot nnoremap <buffer> <localleader><cr> :! dotPng %:r<cr>
augroup END

augroup Vim
  " Clear all autocommands that were set before that.
  autocmd!
  "" - Add plugin by formating and surrounding string from github.
  autocmd BufNewFile,BufRead init.vim nmap <localleader>p "*pJJxhXysiW-
    \Plug '<cr>'<cr>>>
augroup END

" * Formatting.
augroup Comments
  autocmd!
  " * Disable auto comment insert on O.
  autocmd BufNewFile,BufRead * setlocal formatoptions-=o
augroup END

" * Highlight on yank.
augroup HighlightYankedText
    autocmd!
    autocmd TextYankPost *  silent! lua require'vim.highlight'.on_yank()
augroup END

" * Preserve last cursor position after revisiting a file.
if has("autocmd")
  autocmd!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Abbreviations.
" # **P**ersons abbreviations (nicknames, names).
iabbrev @@ sasha.pakalo@gmail.com
" * Personal (**me**).
" - 13 for nickname.
iabbrev pme13 DeadlySquad13
" - Re for real.
iabbrev pmeRe Pakalo Alexander

" # Ex-mode.
" Edit file in current directory.
cabbr %% <c-r>=expand('%:p:h')<cr>

" - exec normal.
cabbr exn exec "normal"<left>

" Visuals.
"Use 24-bit (true-color) mode in Vim/Neovim.
if (has("termguicolors"))
  set termguicolors
endif

" * Highlight range of an exmode command.
lua << EOF
local range_highlight = require("range-highlight")
  range_highlight.setup {
    highlight = "Visual",
    highlight_with_out_range = {
      d = true,
      delete = true,
      m = true,
      move = true,
      y = true,
      yank = true,
      c = true,
      change = true,
      j = true,
      join = true,
      ["<"] = true,
      [">"] = true,
      s = true,
      subsititue = true,
      sno = true,
      snomagic = true,
      sm = true,
      smagic = true,
      ret = true,
      retab = true,
      t = true,
      co = true,
      copy = true,
      ce = true,
      center = true,
      ri = true,
      right = true,
      le = true,
      left = true,
      sor = true,
      sort = true
	}
}
EOF
" * Workspace.
lua << EOF
  local true_zen = require("true-zen")

  true_zen.setup {
    ui = {
      bottom = {
        laststatus = 0,
        ruler = false,
        showmode = false,
        showcmd = false,
        cmdheight = 1,
      },

      top = {
        showtabline = 0,
      },

      left = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
      },
    },

    modes = {
      ataraxis = {
        left_padding = 32,
        right_padding = 32,
        top_padding = 1,
        bottom_padding = 1,
        ideal_writing_area_width = {0},
        auto_padding = true,
        keep_default_fold_fillchars = true,
        custom_bg = {"none", ""},
        bg_configuration = true,
        quit = "untoggle",
        ignore_floating_windows = true,

        affected_higroups = {
          NonText = true,
          FoldColumn = true,
          ColorColumn = true,
          VertSplit = true,
          StatusLine = true,
          StatusLineNC = true,
          SignColumn = true,
        },
      },

      focus = {
        margin_of_error = 5,
        focus_method = "experimental"
      },
    },

    integrations = {
      vim_gitgutter = false,
      galaxyline = false,
      tmux = false,
      gitsigns = false,
      nvim_bufferline = false,
      twilight = true,
      vim_airline = false,
      vim_powerline = false,
      vim_signify = false,
      express_line = false,
      lualine = false,
      lightline = false,
      feline = false
    },

    misc = {
      on_off_commands = false,
      ui_elements_commands = false,
      cursor_by_mode = false,
    }
  }
EOF

lua << EOF
  require("twilight").setup {
    dimming = {
      alpha = 0.25, -- amount of dimming
      -- we try to get the foreground from the highlight groups or fallback color
      color = { "Normal", "#ffffff" },
      inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    },
    context = 10, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    -- treesitter is used to automatically expand the visible text,
    -- but you can further control the types of nodes that should always be fully expanded
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "function",
      "method",
      "table",
      "if_statement",
    },
    exclude = {}, -- exclude these filetypes
  }
EOF

" Navigation.
" # Across files.
" * Rnvimr.
" - Make Ranger replace netrw and be the file explorer.
let g:rnvimr_ex_enable = 1
" * Rel.
" - Jump to link (have to define here too because which_key doesn't handle
"   conflicts occured by <unique> mapping of a Rel.vim).
nnoremap <leader>gl <Plug>(Rel)

" # Inside file.
" * Matching targets
"  (jumping nicely, but only inside []).
nnoremap ]b :call searchpair('\[','','\]')<cr>
nnoremap [b :call searchpair('\[','','\]','b')<cr>


" Mappings.
" # Tinykeymap transitive mappings.
let g:tinykeymap#mapleader = ','
let g:tinykeymap#map#transitive_catalizator = '.'

" * Windows.
" Path: /home/dubuntus/.vim/plugged/tinykeymap_vim/autoload/tinykeymap/map/windows.vim
let g:tinykeymap#map#windows#map = '<c-w>' . g:tinykeymap#map#transitive_catalizator
call tinykeymap#Load('windows')

" * ExpandRegion (without catalizator yet, should be enhanced with treesitter).
call tinykeymap#EnterMap('ExpandRegion', '<a-v>', {
      \ 'name': 'expand region mode'
      \ })
" - Mappings.
call tinykeymap#Map('ExpandRegion', 'v',
      \ 'execute "normal \<Plug>(expand_region_expand)"',
      \ { 'desc': 'Expand selection' })
call tinykeymap#Map('ExpandRegion', 'V',
      \ 'execute "normal \<Plug>(expand_region_shrink)"',
      \ { 'desc': 'Shrink selection' })

" * HorizontalScroll.
let g:tinykeymap#map#horizontal_scroll#map =
      \ '<leader>zh' . g:tinykeymap#map#transitive_catalizator

call tinykeymap#EnterMap('HorizontalScroll', g:tinykeymap#map#horizontal_scroll#map, {
      \ 'name': 'horizontal scroll mode'
      \ })

" - Mappings.
call tinykeymap#Map(
      \ 'HorizontalScroll', 'h',
      \ 'execute  "normal! zh"',
      \ { 'desc': 'Left' })
call tinykeymap#Map(
      \ 'HorizontalScroll', 'l',
      \ 'execute  "normal zl"',
      \ { 'desc': 'Right' })
call tinykeymap#Map(
      \ 'HorizontalScroll', 'H',
      \ 'execute  "normal zH"',
      \ { 'desc': 'Left half screen width' })
call tinykeymap#Map(
      \ 'HorizontalScroll', 'L',
      \ 'execute  "normal zL"',
      \ { 'desc': 'Right half screen width' })


" * Show group highlights of the item under the cursor.
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" # Which-key.
lua << EOF
  local which_key = require("which-key")

  local builtin = require('telescope.builtin')

  -- Utilities. {{{
  -- How to specify it programmatically (start and end of the range)?
  local special_symbols = {
    -- Mathematical Alphanumeric Symbols (Range: 1D400—1D7FF).
    A = '𝐀',
    B = '𝐁',
    C = '𝐂',
    D = '𝐃',
    E = '𝐄',
    F = '𝐅',
    G = '𝐆',
    H = '𝐇',
    I = '𝐈',
    J = '𝐉',
    K = '𝐊',
    L = '𝐋',
    M = '𝐌',
    N = '𝐍',
    O = '𝐎',
    P = '𝐏',
    Q = '𝐐',
    R = '𝐑',
    S = '𝐒',
    T = '𝐓',
    U = '𝐔',
    V = '𝐕',
    W = '𝐖',
    X = '𝐗',
    Y = '𝐘',
    Z = '𝐙'
  }

  -- pos - index of a char to replace,
  -- str - string we want to modify,
  -- r - replacement char (char to replace).
  local function replace_char(pos, str, r)
    -- Checking for nil pos (kind of ternary operator). 
    return not pos and str or str:sub(1, pos-1) .. r .. str:sub(pos+1)
  end

  -- Formats first found character according to dictionary of a special symbols.
  -- str - string to format,
  -- char - character to find.
  local function format(str, char) 
    -- - Checking for nil str and characters that will be interpreted wrong (as regex?).
    if (not str or char == '.') then
      return str
    end

    -- - Case insensitive search because we have only capitals in dictionary.
    return replace_char(str:upper():find(char), str, special_symbols[char])
  end

  local function format_mappings_names(mappings, group_mapping_key)
    local formatted_mappings = {} 

    for key, mapping in pairs(mappings) do
      if (key == 'name') then
        -- Now have only capitals in dictionary so uppercasing.
        formatted_mappings[key] = format(mapping, group_mapping_key:upper())
      else
        -- Mapping group.
        if (mapping.name) then
          formatted_mappings[key] = format_mappings_names(mapping, key:upper())
        else
          local mapping_name = mapping[2]

          -- Now have only capitals in dictionary so uppercasing.
          mapping[2] = format(mapping_name, key:upper())
          formatted_mappings[key] = mapping
        end
      end
    end

    return formatted_mappings
  end

  -- Mappings.
  -- # Buffer.
  local buffer_mappings = {
    name = 'Buffer'
  }

  -- # File.
  local file_mappings = {
    name = 'File'
  }

  -- # Go. Movement across files.
  local go_mappings = {
    name = 'Go',
    -- * Rel.vim /home/dubuntus/.vim/plugged/rel.vim/plugin/rel.vim
    l = { "<Plug>(Rel)", "Link" }
  }

  -- # Help. Show help pages, documentation. Can lead out of the application,
  -- for example, in browser.
  local help_mappings = {
    name = 'Help',
  }

  -- # Jump. Movement inside file.
  local jump_mappings = {
    name = 'Jump',
  }

  -- # Toggle. Mappings that toggle features.
  local toggle_mappings = {
    name = 'Toggle',
  }

  -- # Navigation. Helps find things, used as lookup table (navigation panel).
  local navigation_mappings = {
    name = 'Navigation',
    -- * Telescope.
    f = { function() builtin.find_files() end, 'Find in current directory' },
    s = { function() require('session-lens').search_session() end, 'Session Search' },
    g = { function() builtin.live_grep() end, 'Live grep' },
    b = { function() builtin.buffers() end, 'Buffers' },
    h = { function() builtin.help_tags() end, 'Help tags' },
    t = { function() builtin.treesitter() end, 'Treesitter' },
  }

  -- # Major. Like major mode in spacemacs: filetype mappings.
  local major_mappings = {
    name = 'Major',
  }

  -- * Rnvimr.
  -- nmap <leader><c-\> :RnvimrToggle<cr>

--  " Find files relative to root directory (don't understand how lua functions
--  "   work).
--  "lua <<EOF
--  "my_fd = function(opts)
--    "opts = opts or {}
--    "opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
--    "require'telescope.builtin'.find_files(opts)
--  "end
--  "EOF
--
  
  local z_mappings = {
    h = {
      [vim.g['tinykeymap#map#transitive_catalizator']] = { 'Horizontal Scroll Mode' }
    }
  }

  -- Historically ',' for me is a keybind for settings.
  local settings_mappings = {
    name = 'Settings',
    v = { 'Open Vim config' },
    -- Colors.
    c = { '<cmd>highlight<cr>', 'Show highlight groups colors' },
    ['*'] = { function() vim.fn['SynStack']() end, 'Show highlight groups under the cursor' }
  }

  local mappings = {
    name = 'Main',

    ["<leader>"] = {
      name = 'Leader',
      -- a = a_mappings,
      b = buffer_mappings,
      -- c = comment_mappings, -- Not sure, maybe leave <leader><c-/>.
      -- d = d_mappings,
      -- e = e_mappings,
      f = file_mappings,
      g = go_mappings,
      h = help_mappings,
      -- i = i_mappings,
      j = jump_mappings,
      -- k = k_mappings,
      -- l = l_mappings,
      m = major_mappings,
      n = navigation_mappings,
      -- o = o_mappings,
      -- p = p_mappings,
      -- q = q_mappings,
      -- r = r_mappings,
      -- s = s_mappings,
      t = toggle_mappings,
      -- u = u_mappings,
      -- v = v_mappings,
      -- w = w_mappings,
      -- x = x_mappings,
      -- y = y_mappings,
      z = z_mappings,

      [','] = settings_mappings,
    },

    -- a = a_mappings,
    -- b = b_mappings,
    -- c = c_mappings,
    -- d = d_mappings,
    -- e = e_mappings,
    -- f = f_mappings,
    -- g = g_mappings,
    -- h = h_mappings,
    -- i = i_mappings,
    -- j = j_mappings,
    -- k = k_mappings,
    -- l = l_mappings,
    -- m = m_mappings,
    -- n = n_mappings,
    -- o = o_mappings,
    -- p = p_mappings,
    -- q = q_mappings,
    -- r = r_mappings,
    -- s = s_mappings,
    -- t = t_mappings,
    -- u = u_mappings,
    -- v = v_mappings,
    -- w = w_mappings,
    -- x = x_mappings,
    -- y = y_mappings,
    -- z = z_mappings,

    ['<c-w>'] = {
      [vim.g['tinykeymap#map#transitive_catalizator']] = { 'Window Mode' }     
    }
  }

  local options = {
    mode = "n", -- NORMAL mode
    -- prefix: use "<leader>f" for example for mapping everything related to finding files
    -- the prefix is prepended to every mapping part of `mappings`
    prefix = "", 
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  which_key.register(format_mappings_names(mappings, 'M'), options)

  which_key.setup {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `.
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode.
      spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions.
      suggestions = 20, -- how many suggestions should be shown in the list?.
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim.
    -- No actual key bindings are created.
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion.
      motions = true, -- adds help for motions.
      text_objects = true, -- help for text objects triggered after entering an operator.
      windows = false, -- default bindings on <c-w> (shown via tinykeymap transitive)..
      nav = true, -- misc bindings to work with windows.
      z = true, -- bindings for folds, spelling and others prefixed with z.
      g = true, -- bindings for prefixed with g.
      },
    },
    -- Add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above.
    operators = { gc = "Comments" },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way..
      -- For example:.
      -- ["<space>"] = "SPC",.
      -- ["<cr>"] = "RET",.
      -- ["<tab>"] = "TAB",.
    },
    icons = {
      breadcrumb = "~>", -- symbol used in the command line area that shows your active key combo.
      separator = "", -- symbol used between a key and it's label.
      group = "", -- symbol prepended to a group.
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup.
      scroll_up = '<c-u>', -- binding to scroll up inside the popup.
    },
    window = {
      border = "shadow", -- [ none, single, double, shadow ].
      position = "bottom", -- [ bottom, top ].
      margin = { 10, 60, 52, 60 }, -- extra window margin [ top, right, bottom, left ].
      padding = { 1, 1, 1, 1 }, -- extra window padding [ top, right, bottom, left ].
      winblend = 10 -- pseudo transparency.
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns.
      width = { min = 20, max = 50 }, -- min and max width of the columns.
      spacing = 3, -- spacing between columns.
      align = "center", -- align columns left, center or right.
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label.
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate.
    show_help = true, -- show help message on the command line when the popup is visible.
    triggers = "auto", -- automatically setup triggers.
  -- triggers = {"<leader>"} -- or specify a list manually.
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey.
      -- this is mostly relevant for key maps that start with a native binding.
      -- most people should not need to change this.
      i = { "j", "k" },
      v = { "j", "k" },
    },
  }
EOF

" # Theme.
" * Settings.
syntax enable
set background=light

colorscheme gruvbox-material
highlight Pmenu ctermbg=240 gui=bold
" CursorLineNr doesn't work without it.
set cursorline
highlight LineNr ctermfg=248 guifg=#bbbbbb
highlight CursorLineNr ctermfg=137
highlight Statement ctermfg=186
" * Contrasting.
" - 1. Declarations.
highlight Identifier cterm=bold ctermfg=32
highlight Comment gui=italicbold guifg=#5555aa
" * Inconspicious.
highlight Whitespace guifg=#cccccc
"highlight SpecialKey guifg=#555555

" - Helpers for creating a theme.
lua << EOF
  local Color, colors, Group, groups, styles = require('colorbuddy').setup()

  -- Colors.
  local color_palette = {
    red = {
      crimson = '#9d0006',
      engine = '#cc241d',
      venetian = '#fb4934',
    },

    mustard = {
      bronze = '#79740e',
      citron = '#98971a',
      acid = '#b8bb26',
    },

    yellow = {
      philippine_gold = '#b57614',
      goldenrod = '#d79921',
      saffron = '#fabd2f',
    },

    blue = {
      sapphire = '#076678',
      jelly_bean = '#458588',
      morning = '#83a598',
    },

    purple = {
      twilight_lavender = '#8f3f71',
      turkish_rose = '#b16286',
      puce = '#d3869b',
    },

    aquamarine = {
      amazon = '#427b58',
      russian = '#689d6a',
      pistachio = '#8ec07c',
    },

    orange = {
      rust = '#af3a03',
      metallic = '#d65d0e',
      pumpkin = '#fe8019',
    },

    white = {
      white0 = '#f9f5d7',
      white1 = '#fbf1c7',
      white2 = '#f2e5bc',
      tan = '#e0d0a8',
    },

    gray = {
      gray0 = '#ebdbb2',
      gray1 = '#d5c4a1',
      gray2 = '#bdae93',
      gray3 = '#a89984',
      gray4 = '#928374',
    },

    black = {
      black0 = '#7c6f64',
      black1 = '#665c54',
      black2 = '#504945',
      black3 = '#3c3836',
      black5 = '#32302f',
      black6 = '#282828',
      black7 = '#1d2021',
    },
  }

  -- Semantic colors.
  local semantic_palette = {
    informational1 = color_palette.gray.gray1,
    inconspicious0 = color_palette.white.white1
  }

  -- Scope colors.
  Color.new('fold_foreground', semantic_palette.informational1)
  Color.new('fold_background', semantic_palette.inconspicious0)

  -- Scope groups.
  Group.new('FoldColumn', colors.fold_foreground, colors.fold_background)
-- hi FoldColumn guibg=test guifg=Black

  -- Define highlights in terms of `colors` and `groups`
  -- Group.new('Function'        , colors.yellow      , colors.background , styles.bold)
  --  Group.new('luaFunctionCall' , groups.Function    , groups.Function   , groups.Function)

  -- Define highlights in relative terms of other colors
  --  Group.new('Error'           , colors.red:light() , nil               , styles.bold)
EOF

" Highlight colors.
lua <<EOF
  -- Attaches to every FileType mode
  require 'colorizer'.setup()

  -- Attach to certain Filetypes, add special configuration for `html`
  -- Use `background` for everything else.
  -- require 'colorizer'.setup {
  --   'css';
  --   'javascript';
  --   html = {
  --     mode = 'foreground';
  --   }
  -- }

  -- Use the `default_options` as the second parameter, which uses
  -- `foreground` for every mode. This is the inverse of the previous
  -- setup configuration.
  -- require 'colorizer'.setup({
  --   'css';
  --   'javascript';
  --   html = { mode = 'background' };
  -- }, { mode = 'foreground' })

  -- Use the `default_options` as the second parameter, which uses
  -- `foreground` for every mode. This is the inverse of the previous
  -- setup configuration.
  -- require 'colorizer'.setup {
  --   '*'; -- Highlight all files, but customize some others.
  --   css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  --   html = { names = false; } -- Disable parsing "names" like Blue or Gray
  -- }

  -- Exclude some filetypes from highlighting by using `!`
  -- require 'colorizer'.setup {
  --   '*'; -- Highlight all files, but customize some others.
  --   '!vim'; -- Exclude vim from highlighting.
  --   -- Exclusion Only makes sense if '*' is specified!
  -- }
EOF

" # Indents.
lua <<EOF
vim.opt.termguicolors = true
-- Enabling special characters.
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
-- Declaring colors.
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- Use treesitter to calculate indentation when possible.

require("indent_blankline").setup {
  -- Char to be used to display an indent.
  char = "|",
  -- Exclude certain buffer types.
  buftype_exclude = { 'terminal' },
  filetype_exclude = { 'dashboard' },

  show_end_of_line = true,
  space_char_blankline = " ",
  -- Use Treesitter to calculate indentation when possible.
  indent_blankline_use_treesitter = true,
  -- Enable context highlight by Treesitter.
  show_current_context = true,
  show_current_context_start = true,

  -- Assigning colors.
  char_highlight_list = {
    'IndentBlanklineIndent1',
    'IndentBlanklineIndent2',
    'IndentBlanklineIndent3',
    'IndentBlanklineIndent4',
    'IndentBlanklineIndent5',
    'IndentBlanklineIndent6',
  },
}
EOF

" * Rnvimr.
" - Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
" - Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 60

" * NERDTree.
" - Start NERDTree automatically. If a file is specified, move the cursor to
" its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" - Place on the right.
let g:NERDTreeWinPos = "right"


" Color columns indicating width.
"   1 + 2 splits (should be textwidth), 2 splits, 2 + 1 splits, full width - right sidebar, full width.
set colorcolumn=80,115,151,203,235

" # Markdown.
" Use signs to highlight code blocks.
function! ColorCodeBlocks() abort " {{{1
  setlocal signcolumn=no

  sign define codeblock linehl=codeBlockBackground

  augroup code_block_background
    autocmd! * <buffer>
    autocmd InsertLeave  <buffer> call s:place_signs()
    autocmd BufEnter     <buffer> call s:place_signs()
    autocmd BufWritePost <buffer> call s:place_signs()
  augroup END
endfunction

function! s:place_signs()
  let l:continue = 0
  let l:file = expand('%')

  execute 'sign unplace * file=' . l:file

  for l:lnum in range(1, line('$'))
    let l:line = getline(l:lnum)
    if l:continue || l:line =~# '^\s*```'
      execute printf('sign place %d line=%d name=codeblock file=%s',
            \ l:lnum, l:lnum, l:file)
    endif

    let l:continue = l:continue
          \ ? l:line !~# '^\s*```$'
          \ : l:line =~# '^\s*```'
  endfor
endfunction

setl signcolumn=no

hi markdownCodeBlockBG ctermbg=137
sign define codeblock linehl=markdownCodeBlockBG

function! MarkdownBlocks()
  let l:continue = 0
  execute "sign unplace * file=".expand("%")

  " iterate through each line in the buffer
  for l:lnum in range(1, len(getline(1, "$")))
    " detect the start fo a code block
    if getline(l:lnum) =~ "^```.*$" || l:continue
      " continue placing signs, until the block stops
      let l:continue = 1
      " place sign
      execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
      " stop placing signs
      if getline(l:lnum) =~ "^```$"
        let l:continue = 0
      endif
    endif
  endfor
endfunction

" Use signs to highlight code blocks
" Set signs on loading the file, leaving insert mode, and after writing it
au InsertLeave *.md call MarkdownBlocks()
au BufEnter *.md call MarkdownBlocks()
au BufWritePost *.md call MarkdownBlocks()

" # Better comments.
" - Danger.
syn match CommentDanger #"!!.*# | hi specialComment guifg=red
" Examples for settings this for special filetypes
" (or better place the command above into ~/.vim/after/syntax/c.vim)
"au! BufEnter *.c syn match specialComment #//!!.*#  " C files (*.c)
"hi specialComment ctermfg=red guifg=red

" * Semantic Indents (descending order).
syn match CommentSemanticIndent1 #" * .*#| hi CommentSemanticIndent1 guifg=green
syn match CommentSemanticIndent2 #" - .*#| hi CommentSemanticIndent2 guifg=green

" * Reminders.
" - Fix.
syn match CommentFix #" \<[Ff]ix:\?\>.*#| hi CommentFix guifg=blue gui=underline
" - Todo.
syn match CommentTodo #" \<[Tt]odo:\?\>.*#| hi CommentTodo guifg=orange

" - Question.
syn match CommentQuestion #" ? .*#| hi CommentQuestion guifg=blue


