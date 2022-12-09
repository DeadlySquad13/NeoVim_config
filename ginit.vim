if exists('g:fvim_loaded')
    " good old 'set guifont' compatibility with HiDPI hints...
    if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
      set guifont=Iosevka:h13
    else
      set guifont=Iosevka:h26
    endif
    " Font tweaks
    FVimFontAntialias v:false
    " FVimFontAutohint v:true
    " FVimFontHintLevel 'full'
    FVimFontLigature v:false
    " can be 'default', '14.0', '-1.0' etc.
    " FVimFontLineHeight '-1.0'
    FVimFontSubpixel v:true
    " Disable built-in Nerd font symbols
    " FVimFontNoBuiltinSymbols v:false

    " Try to snap the fonts to the pixels, reduces blur
    " in some situations (e.g. 100% DPI).
    " FVimFontAutoSnap v:true

    set laststatus=3
    set nolist
      
    " Ctrl-ScrollWheel for zooming in/out
    nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
    nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif
