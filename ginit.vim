if exists('g:GuiLoaded')
    call GuiWindowMaximized(1)
    GuiPopupmenu 0
    GuiTabline 0

    if has("win32")
        GuiFont! Consolas:h11
        nnoremap <c-6> <c-^>
    else
        " Doesn't work
        GuiFont Monospace:h8
    endif

    source $MYVIMRC
endif
