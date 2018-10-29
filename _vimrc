" TODO:
" Insert preformatted comment block
" Figure out how to compile and jump to errors (:cl :cn :cp (list, next, prev))
" Better syntax highlighitng for c/cpp? Or just work on a good colorscheme
" remap to something useful: - goes to first nonwhite prev line

" skip loading microsoft windows key editing commands
let skip_loading_mswin=1
execute pathogen#infect()
syntax on
filetype plugin indent on
syntax enable
set background=dark
colorscheme alduin
" colorscheme jellybeans
" colorscheme magicka
" colorscheme hybrid
" colorscheme sourcerer
" colorscheme Spink
if has('termguicolors')
  set termguicolors " 24-bit terminal
endif

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

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
" set viminfo='1000,f1

" <c-a> and <c-x> commands for inc dec numbers wont interpret any number as octal (ex: 007 would go up to 010)
set nrformats-=octal

" should remove load prompts on external change (ex: git pull)
" Trigger autoread when cursor stops moving
" Trigger autoread when changing buffers inside vim
set autoread
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime

" dont scan included files during c-n c-p completion
"set complete-=i

set tabpagemax=50
set viminfo^=!
set sessionoptions-=options
" leave at least n lines when scrolling
" set scrolloff=1
set sidescrolloff=5
set display+=lastline
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" Delete comment character when joining commented lines
set formatoptions+=j

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" autocmd FileChangedShellPost *
"   \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

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

" make warnings more obvious (search wrap, etc)
hi WarningMsg ctermfg=white ctermbg=red guifg=White guibg=Red gui=None
" turn on keyword color differentiation
set t_Co=256
" turn on incremental smartcase search highlighting (don't silently wrap, use gg and G to manually continue search)
set incsearch ignorecase smartcase hlsearch nowrapscan
" turn off highlights (turn off matches)
nnoremap <c-m> :noh<cr>

" hi Search guifg=Black guibg=Green
"allow backspace to work normally
set backspace=indent,eol,start
" force min window width
set winwidth=120
"set text to consolas size 11
set guifont=Consolas:h11
set lines=70 columns=120
set tabstop=4     "tabs are at proper location
set expandtab     "don't use actual tab character (ctrl-v)
set shiftwidth=4  "indenting is 4 spaces
set autoindent    "turns it on
set smartindent   "does the right thing (mostly) in programs
set cindent       "stricter rules for C programs
set pastetoggle=<f5>

" vertical bar of color indicating where the line break is
set colorcolumn=80
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
" set textwidth=80
" let &colorcolumn=join(range(80,300),",")

" Open tag in tab, open tag in vsplit
map <c-T> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <a-v> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" remap <leader> to spacebar (default \)
noremap <space> <nop>
let mapleader= "\<space>"

"show line num file name leave space for command line
set nocompatible ruler laststatus=2 showcmd showmode number showmatch nowrap wildmenu

" use the bash shell for shell commands example :!grep 
" Could no longer do :History
" set shell=/usr/bin/env\ bash

set history=1000

" highlight trailing whitespace
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/

" vim treats a sequences of [A-Za-z0-9_] as a `word` (WORD just goes to next whitespace)
" You can re-define what word mean to vim, this removes the _ char from the set
" of contiguous chars that defined a `word`
set iskeyword-=_

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
nnoremap <leader>hh :History<cr>
nnoremap <leader>h/ :History/<cr>
nnoremap <leader>h: :History:<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr>

" TagHighlight
nnoremap <leader>u :UpdateTypesFile<cr>

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
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 3)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 3)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

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
" K will search in man pages for the command under cursor (this has been remapped to to opposite of J)
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
" open prevoius file: <c-6> good for toggling .h and .cpp (can also use fzf's :History command <leader>hh)
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg
" :Vex vertical explorer (can navigate and search like normal vim, how to open file in tab?)
" can turn a split into a tab by doing c-w then T
" zz to center the line you're on in the middle of the screen
" zt to put the line you're on at the top of the screen



" Bad but might have nugget of good idea
" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy
