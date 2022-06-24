set nocompatible
" Settings that I don't know how to translate to lua.
" - Enable settings for specific filetypes.
filetype plugin on

" Don't parse long lines for syntax highlight.
set synmaxcol=256
syntax sync minlines=256

" Follow directory according to current buffer. Helps creating files relatively.
set autochdir

" Lua config.
lua << EOF
  require('init');
EOF

" General keybindings.
let mapleader=' '
let maplocalleader='\'

" Integration with system.
let g:omnipresence_hotkey = 'f11'

" Search for item under cursor in vim docs (:help).
" - 'investigate help'
noremap <leader>gih K

" # Custom commands.
" * File related.
" - Move visually selected chunk of text into a new file.
:command! -bang -range -nargs=1 -complete=file MoveWrite  <line1>,<line2>write<bang> <args> | <line1>,<line2>delete _
" - Append visually selected chunk of text to a file.
:command! -bang -range -nargs=1 -complete=file MoveAppend <line1>,<line2>write<bang> >> <args> | <line1>,<line2>delete _

if exists('g:started_by_firenvim')
  " Disable status line.
  set laststatus=0
endif

augroup Dashboard
  autocmd! * <buffer>
  autocmd User dashboardReady let &l:stl = 'Dashboard'
  autocmd User dashboardReady nnoremap <buffer> <leader>qe :exit<cr>
  "autocmd User dashboardReady nnoremap <buffer> <leader>u <cmd>PackerUpdate<CR>
  autocmd User dashboardReady nnoremap <buffer> <leader>l <cmd>SessionLoad<CR>
augroup END

" LSP
" * Autocomplete.
set completeopt=menu,menuone,noselect
let g:autopep8_disable_show_diff=1

" Use omni completion provided by lsp.
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

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

" - Make Y behave similar to D in normal mode.
nnoremap Y y$

" * Open new file in vertical split (similar to built-in <c-w>n).
nnoremap <c-w>v :vnew<cr>

" * Remaping line concatenation for use of j with modifier in non-vim apps.
noremap <a-j> J

" NERDCommenter.
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

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
"set fillchars+=fold:\ 
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
  autocmd BufWinEnter * if &fdm == 'expr' | setlocal foldmethod=syntax | endif
  " Open all folds under cursor.
   "autocmd BufWinEnter * silent normal! zO
augroup END

augroup LspFix
  autocmd!
  autocmd BufWinEnter * :LspStart
augroup END

augroup Markdown
  " Clear all autocommands that were set before that.
  autocmd!
  "autocmd BufNewFile,BufReadPost *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md
   "autocmd Filetype markdown set filetype=markdown
  let g:markdown_fenced_languages = [
    \'sh',
    \'bash=sh',
    \
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

  " * mkdx settings.
  " - Highlighting.
  " - Enable shift+enter to create a new line with indentation but without new
  "   item in list.
  " - Enable dead link detection for external links.
  " - Updates TOC before saving the file.
  " - Enabling folding of inline code blocks and TOC.
  let g:mkdx#settings = { 'highlight': { 'enable': 1 },
    \ 'enter': { 'shift': 1 }, 
    \ 'links': { 'external': { 'enable': 1 } },
    \ 'toc': { 'position': 1, 'text': 'Table of Contents', 'update_on_write': 1 },
    \ 'fold': { 'enable': 1 }}

  " - Concealing things like **bold**.
  autocmd FileType markdown setlocal conceallevel=2 
  " - Disabling concealing on current line for all mods.
  autocmd FileType markdown setlocal concealcursor= 

  " # Markdown Preview.
  " Echo preview page url in command line when open preview page.
  let g:mkdp_echo_preview_url = 1
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

" Visuals.
"Use 24-bit (true-color) mode in Vim/Neovim.
if (has("termguicolors"))
  set termguicolors
endif

" Navigation.
" # Across files.
" * Rnvimr.
" - Make Ranger replace netrw and be the file explorer.
let g:rnvimr_ex_enable = 1
" * Rel.
" - Jump to link (have to define here too because which_key doesn't handle
"   conflicts occured by <unique> mapping of a Rel.vim).
nnoremap <leader>gl <Plug>(Rel)
" - Url encode / decode.
vnoremap <leader>en :!python3 -c 'import sys; from urllib import parse; print(parse.quote_plus(sys.stdin.read().strip()))'<cr>
vnoremap <leader>de :!python3 -c 'import sys; from urllib import parse; print(parse.unquote_plus(sys.stdin.read().strip()))'<cr>

" # Inside file.
" * Matching targets
"  (jumping nicely, but only inside []).
nnoremap ]b :call searchpair('\[','','\]')<cr>
nnoremap [b :call searchpair('\[','','\]','b')<cr>

" * Show group highlights of the item under the cursor.
function! SynStack()
  if !exists("*synstack")
    echo xyi
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Mappings.
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" # Markdown mkdx mappings.
" First, make sure we don't create the default mapping when entering markdown files.
" All plugs can be disabled like this (except insert mode ones, they need "imap" instead of "nmap").
"nmap <Plug> <Plug>(mkdx-wrap-link-n})

" Then create a function to remap manually.
fun! s:MkdxRemap()
    " Regular map family can be used since these are buffer local.
    "nmap <buffer><silent> <leader>wl <Plug>(mkdx-wrap-link-n)
    " Other overrides go here.
endfun

" Finally, add a "FileType" autocommand that calls "s:MkdxRemap()" upon entering markdown filetype.
augroup Mkdx
    au!
    au FileType markdown,mkdx call s:MkdxRemap()
augroup END


" Abbreviations
runtime abbreviations.vim

" # Theme.
" * Settings.
syntax enable
set background=light

"colorscheme gruvbox-material
"highlight Pmenu ctermbg=240 gui=bold
" CursorLineNr doesn't work without it.
set cursorline
"highlight LineNr ctermfg=248 guifg=#bbbbbb
"highlight CursorLineNr ctermfg=137
"highlight Statement ctermfg=186
" * Contrasting.
" - 1. Declarations.
"highlight Identifier cterm=bold ctermfg=32
"highlight Comment gui=italicbold guifg=#5555aa
" * Inconspicious.
"highlight Whitespace guifg=#cccccc
"highlight SpecialKey guifg=#555555

lua << EOF
  -- - Helpers for creating a theme.
  -- require('config.theme')
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
"function! ColorCodeBlocks() abort " {{{1
  "setlocal signcolumn=no

  "sign define codeblock linehl=codeBlockBackground

  "augroup code_block_background
    "autocmd! * <buffer>
    "autocmd InsertLeave  <buffer> call s:place_signs()
    "autocmd BufEnter     <buffer> call s:place_signs()
    "autocmd BufWritePost <buffer> call s:place_signs()
  "augroup END
"endfunction

"function! s:place_signs()
  "let l:continue = 0
  "let l:file = expand('%')

  "execute 'sign unplace * file=' . l:file

  "for l:lnum in range(1, line('$'))
    "let l:line = getline(l:lnum)
    "if l:continue || l:line =~# '^\s*```'
      "execute printf('sign place %d line=%d name=codeblock file=%s',
            "\ l:lnum, l:lnum, l:file)
    "endif

    "let l:continue = l:continue
          "\ ? l:line !~# '^\s*```$'
          "\ : l:line =~# '^\s*```'
  "endfor
"endfunction

"setl signcolumn=no

"hi markdownCodeBlockBG ctermbg=137
"sign define codeblock linehl=markdownCodeBlockBG

"function! MarkdownBlocks()
  "let l:continue = 0
  "execute "sign unplace * file=".expand("%")

  "" iterate through each line in the buffer
  "for l:lnum in range(1, len(getline(1, "$")))
    "" detect the start fo a code block
    "if getline(l:lnum) =~ "^```.*$" || l:continue
      "" continue placing signs, until the block stops
      "let l:continue = 1
      "" place sign
      "execute "sign place ".l:lnum." line=".l:lnum." name=codeblock file=".expand("%")
      "" stop placing signs
      "if getline(l:lnum) =~ "^```$"
        "let l:continue = 0
      "endif
    "endif
  "endfor
"endfunction

"" Use signs to highlight code blocks
"" Set signs on loading the file, leaving insert mode, and after writing it
"au InsertLeave *.md call MarkdownBlocks()
"au BufEnter *.md call MarkdownBlocks()
"au BufWritePost *.md call MarkdownBlocks()

runtime syntax/general/comments.vim

" Filetypes.
" - Config for Wsl.
autocmd BufNewFile,BufReadPost .wslconfig set syntax=sh
" - Config for Wyrd.
autocmd BufNewFile,BufReadPost .wyrdrc set syntax=conf
" - LaTex templates.
autocmd BufNewFile,BufReadPost *.tplx set syntax=tex
" - LaTeX templates for notebook.
autocmd BufNewFile,BufReadPost *.tex.j2 set syntax=tex

