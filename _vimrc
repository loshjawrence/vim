" skip loading microsoft windows key editing commands
let skip_loading_mswin=1
" set colorscheme
syntax enable
colorscheme solarized
" turn on keyword color differentiation
set t_Co=256
" turn on search highlighting and set it to blue
set  incsearch ignorecase smartcase hlsearch
hi Search guifg=White guibg=Black
"allow backspace to work normally
set backspace=indent,eol,start
" force min window width
set winwidth=110
"set text to consolas size 11
set guifont=Consolas:h16
set lines=70 columns=140
set tabstop=4     "tabs are at proper location
set expandtab     "don't use actual tab character (ctrl-v)
set shiftwidth=4  "indenting is 4 spaces
set autoindent    "turns it on
set smartindent   "does the right thing (mostly) in programs
set cindent       "stricter rules for C programs
set pastetoggle=<f5> 
set colorcolumn=80
" remap <leader> to spacebar (default \)
noremap <space> <nop>
let mapleader= "\<space>"

"show line num file name leave space for command line
set nocompatible ruler laststatus=2 showcmd showmode number showmatch nowrap

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" example function for tidy up
function TidyUp()
    " save position of cursor
    let origPos = getpos(".")
    " remove trailing whitespace on save
    :%s/\s\+$//e
    " insert a space after every comma, \1 refs stuff inside \(\)
    :%s/,\(\S\)/, \1/g
    " collapse multiple blank lines with one
    :%s#\(\n\n\)\n\+#\1#e
    " replace trailing empty lines
    :%s#\($\n\s*\)\+\%$##e
    "previous command moves cursor, restore its original pos
    call setpos(".", origPos)
    :w
endfunction

" vsvim for visual studio doesn't support some autocmd's, so remap save to tidyUp then save
" vsvim doesn't support functions :(
" nmap :w<cr> :call TidyUp()<cr>
" use e at the end of s/// to ignore error
" remove traliing whitespace, collapse multi new lines with one,
" remove trailing empty lines, return to old cursor pos, write
" vsvim doesn't support end of line match
nmap <c-z> <esc>ma:%s#\s\+$##e<cr>:%s#\(\n\n\)\n\+#\1#e<cr>:%s#\(\n\s*\)\+\%$##e<cr>`a:w<cr>
" an attempt to do get it to work in visual studio
"nmap <c-z> <esc>xu:%s/\s\+$//e<cr>G?\S<cr>:.,$s#\n*##

" call func before write buffer
" leave as examples
"autocmd BufWritePre * exec TidyUp()
"autocmd BufWritePre * :%s/\s\+$//e

" navigate by display lines
nmap j gj
nmap k gk

" allow arrow keys to toggle the current window in split screen mode
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" go to next non-white char on line above and below
" NOT USEFUL
nmap <c-j> jg_
nmap <c-k> kg_
" - go to first non-white char on prev line
" <c-m> go to first non-white char on next line

" yank to end of line
nmap Y y$
" nnoremap B 2b
" nnoremap W 2w
" nnoremap E 2e

"search, go back 1, change in word (n. to apply to next match)
" or visual select then :s/word/otherword/g
nmap <c-c> *Nciw

" should probably just do the above and remove on these
" nmap in word copy to reg 1
nmap <c-y> "1yiw
" paste in word from z reg 1
nmap <c-p> viw"1p

" perform normal mode movement while in insert mode?

" like J, but reverse (for comma sep list)
" NOT USEFUL
nmap U i<cr><esc>k$F,l
" like J, but reverse (for word sep list)
nmap H i<cr><esc>k$B

" make getting out of insert mode easier
" <c-[> is Windows mapping for esc
imap <c-[> <Esc>:w<cr>
" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection
vnoremap Q :norm @q<cr>

" block comment (+) uncomment (_)
" norm runs normoal mode commands in specified range, when in V mode
" it gets fed the lines you selected
vmap + :norm ^i// <cr>
vmap _ :norm ^xxx<cr>

" open file under cursor in vsplit
nmap <c-w><c-f> <c-w>vgf

" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" possibly useful nomral mode keys:
" ; will repeat t/T/f/F (movement to and find) commonds!
" <c-w><c-w> cycle split windows
" - goes to first nonwhite prev line
" <c-m> goes to first nonwhite next line
" K will search in man pages for the command under cursor
" :sh will open a shell
" di{ to delete method body, can do this with these as well: " ( [ ' {
" :windo diffthis (diff windows in current tab, :diffoff! to turn it off)
" :g/^\s*$/d global delete lines containing regex(whitespace-only lines)
" :v/error\|warn\|fail/d opposite of global delete(g!//d) keep the lines containing the regex(error or warn or fail)
" :tab sball -> convert everything to tabs
" gt (next tab) gT(prev tab) #gt (jump to tab #)
