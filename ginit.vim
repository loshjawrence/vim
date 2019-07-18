if exists('g:GuiLoaded')
    if has("win32")
        Guifont! Consolas:h11:l
    else
        " Can't understand this 
        " Guifont! Ubuntu\ 11
    endif

    GuiPopupmenu 0
    GuiTabline 0

    if has("win32")
        nnoremap <c-6> <c-^>
    endif
endif
