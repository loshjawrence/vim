:" TODO: search versions of fFtT motions
" i.e. Would this be useful: map f" (and others) as search versions of fFtT 
" movements but finds pairs then you can hit n or N to move about

" skip loading microsoft windows key editing commands
let skip_loading_mswin=1
execute pathogen#infect()
syntax on
filetype plugin indent on
syntax enable
set background=dark
color jb4
" color jellybeans
if has('termguicolors')
  set termguicolors " 24-bit terminal
endif

" Show current line number
set number
" Show relative line numbers
set relativenumber

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Use fuzzy file finder fzf
" (If installed using git: git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install)
set rtp+=~/.fzf

" Toggle between header and source
nnoremap <c-k><c-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" allow saving of marks for a session (save-->:mks!   savenew-->:mks ~/vimfiles/session/mysession.vim   load--> :source path-to-mysession.vim)
" must use captial and 0-9 marks
" see also http://vimdoc.sourceforge.net/htmldoc/motion.html#E20
" http://vimdoc.sourceforge.net/htmldoc/usr_21.html#21.3
set viminfo='1000,f1

" should remove load prompts on external change (ex: git pull)
" Trigger autoread when cursor stops moving
" Trigger autoread when changing buffers inside vim
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" tell ctags to look in current then up one until it finds it
" set tags=./tags,tags;

" just cd to project base dir and :!ctags -R to generate tags file
" set path=$PWD/**

" DOESN"T WORK
" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
" let s:default_path = escape(&path, '\ ') " store default value of 'path'
" autocmd BufRead *
"       \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
"       \ exec "set path-=".s:tempPath |
"       \ exec "set path-=".s:default_path |
"       \ exec "set path^=".s:tempPath |
"       \ exec "set path^=".s:default_path

" don't silently wrap on inc search (use gg or G manually to continue search)
set nowrapscan
" make warnings more obvious (search wrap, etc)
hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None
" turn on keyword color differentiation
set t_Co=256
" turn on search highlighting and set it to blue
set  incsearch ignorecase smartcase hlsearch
" hi Search guifg=Black guibg=Green
"allow backspace to work normally
set backspace=indent,eol,start
" force min window width
set winwidth=110
"set text to consolas size 11
set guifont=Consolas:h12
set lines=70 columns=120
set tabstop=4     "tabs are at proper location
set expandtab     "don't use actual tab character (ctrl-v)
set shiftwidth=4  "indenting is 4 spaces
set autoindent    "turns it on
set smartindent   "does the right thing (mostly) in programs
set cindent       "stricter rules for C programs
set pastetoggle=<f5>
set colorcolumn=80
" let &colorcolumn=join(range(80,300),",")


" remap <leader> to spacebar (default \)
noremap <space> <nop>
let mapleader= "\<space>"

"show line num file name leave space for command line
set nocompatible ruler laststatus=2 showcmd showmode number showmatch nowrap

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" vim treats a sequences of [A-Za-z0-9_] or sequences of non-blank characters separated with white space as a word, sequences of non-blank characters separated with white space as a WORD. You can re-define what word mean to vim:
" set iskeyword-=_

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
nnoremap <c-z> <esc>ma:%s#\s\+$##e<cr>:%s#\(\n\n\)\n\+#\1#e<cr>:%s#\(\n\s*\)\+\%$##e<cr>`a:w<cr>
" an attempt to do get it to work in visual studio
"nmap <c-z> <esc>xu:%s/\s\+$//e<cr>G?\S<cr>:.,$s#\n*##

" call func before write buffer
" leave as examples
"autocmd BufWritePre * exec TidyUp()
"autocmd BufWritePre * :%s/\s\+$//e

" Autoindent for func args will on (
set cino+=(0

" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg
nnoremap <leader>m :Marks<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>

" TagHighlight
nnoremap <leader>u :UpdateTypesFile

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Tabularize plugin, to align this I highlighted then :Tabularize /:Tabularize
" Should definitely checkout https://www.vim.org/scripts/script.php?script_id=294
vnoremap  <leader>tt      :Tabularize  /
nnoremap  <leader>tt      :Tabularize  /
vnoremap  <leader>t<bar>  :Tabularize  /\|<cr>
nnoremap  <leader>t<bar>  :Tabularize  /\|<cr>
vnoremap  <leader>t=      :Tabularize  /^[^=]*\zs=<cr>
nnoremap  <leader>t=      :Tabularize  /^[^=]*\zs=<cr>
vnoremap  <leader>t,      :Tabularize  /,<cr>
nnoremap  <leader>t,      :Tabularize  /,<cr>
vnoremap  <leader>ts      :Tabularize  /\S\+<cr>
nnoremap  <leader>ts      :Tabularize  /\S\+<cr>

" navigate by display lines
nnoremap j gj
nnoremap k gk

" allow arrow keys to toggle the current window in split screen mode
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" yank to end of line
nnoremap Y y$

" perform normal mode movement while in insert mode?

" map redo to U, <c-r> is used in Visual Studio for good refactoring shortcuts
nnoremap U <c-r>

" like J, but reverse (for comma sep list), pick a better letter H is used as a part of the broad page jump trio(H, M, L)
nnoremap K T,i<cr><esc>k$T,

" smooth scroll plugin
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 5)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 5)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 8)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 8)<CR>

" make getting out of insert mode easier
" <c-[> is Windows mapping for esc
inoremap <c-[> <Esc>:w<cr>
nnoremap <c-[> <Esc>:w<cr>

" replay macro (qq to start recording, q to stop)
nnoremap Q @q

" apply macro across visual selection
vnoremap Q :norm @q<cr>

" block comment (+) uncomment (_)
" norm runs normoal mode commands in specified range, when in V mode
" it gets fed the lines you selected
" NOTE: you can't map to c-/
" vmap <c-/> :norm ^i// <cr> 
" vmap <c-?> :norm ^xxx<cr>
" tcommentary.vim (visual mode gc or <c-_><c-_>)

" open file under cursor in vsplit
" nnoremap <c-w><c-f> <c-w>vgf

" forward autocomplete(ctrl-p) mapped to tab
" hit c-p and c-n to navigate list
" doesnt really work right with IDE's like visual studio as they also use tab
" for tab completion
" imap <Tab> <c-p>

" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
onoremap s :normal vs<CR>
" Example: onoremap p i(       The onoremap command tells Vim that when it's waiting for a movement to give to an operator and it sees p, it should treat it like i(. When we ran dp it was like saying "delete parameters", which Vim translates to "delete inside parentheses".

 " Auto generate remappings, targets.vim does this nicely
 " Example: noremap ci, T,ct,
 " Add other text objects to perform ci and ca with
 " n means jump to next pair, l means jump to last pair
 " SINGLE LINE VERSION
 " for charBound in [ "<Bar>", "/", "\\", "'", "`", "\"", "_", ".", ",", "*", "-", "&", "^", "+"]
 "     for editType in ["c", "y"]
 "         execute 'nnoremap ' . editType . 'i'  . charBound . ' T' . charBound . 'ct' . charBound
 "         execute 'nnoremap ' . editType . 'in' . charBound . ' f' . charBound . ';T' . charBound . 'ct' . charBound
 "         execute 'nnoremap ' . editType . 'il' . charBound . ' F' . charBound . ';f' . charBound . 'cT' . charBound
 "     endfor
 " endfor

" SEARCH VERSION
" \d is a number
" . is any char
" \. is .
" \s is white space
" \S in non-white space
" \a is letter
" search quote with some non-white stuff in it /".*\S\+.*"
" search quote with white stuff in it /"\s+"
" search quote with nothing /""
" search quote followed by \ or quote followed by any char /"\\\|".
" nnoremap ci" ?"<CR>vNc""<Esc>:noh<CR>i
" nnoremap cin" /".*\S\+.*"<CR>:noh<CR>iasdf
" nnoremap cil" ?".*\S\+.*"<CR>cs""<Esc>:noh<CR>i


" possibly useful nomral mode keys:
" ; will repeat t and f (line movement to and find) commonds. , will repeat T and F commands (reverse)
" <c-w><c-w> cycle split windows
" - goes to first nonwhite prev line
" <c-m> goes to first nonwhite next line
" K will search in man pages for the command under cursor
" :sh will open a shell
" di{ to delete method body, can do this with these as well: " ( [ ' <
" :windo diffthis (diff windows in current tab, :diffoff! to turn it off)
" :g/^\s*$/d global delete lines containing regex(whitespace-only lines)
" :v/error\|warn\|fail/d opposite of global delete (equivalent to global inverse delete (g!//d)) keep the lines containing the regex(error or warn or fail)
" :tab sball -> convert everything to tabs
" gt (next tab) gT(prev tab) #gt (jump to tab #)
" c-p basic tab completion pulling from a variety of sources
" c-n, c-p open completion prompt (also for prompt navigation, prev, next)
" c-x c-l whole line completion
" c-x c-o syntax aware omnicompletion
" see this for native vim auto complete https://robots.thoughtbot.com/vim-you-complete-me
" clipboard reg 1 yank in word nmode: "1yiw vmode: "
" clipboard reg 1 yank in word nmode: "1yiw vmode: "1y
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" edit file under cursor: gf
" open prevoius file: <c-6> good for toggling .h and .cpp (can also use fzf's :History command)
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg
" :Vex vertical explorer (can navigate and search like normal vim, how to open file in tab?)



" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy
