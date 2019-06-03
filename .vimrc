" turn on keyword color differentiation
set t_Co=256

syntax on
syntax enable
" Note: on unix-like OS's you must put the .vim color scheme files (in this case alduin2.vim) in
" /usr/share/vim/vim80/colors

colorscheme alduin3

" Plugins. Execute :PlugInstall for any new ones you add
" Auto install the vim-plug pluggin manager if its not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle') " Arg specifies plugin install dir
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " <space>f to search for tracked files in git repo. Lots of other powerful stuff see git repo for details.
Plug 'tomtom/tcomment_vim' " comment selected lines with gc
Plug 'wellle/targets.vim' " cin( cina, etc
Plug 'godlygeek/tabular' " aligning selected text on some char or regex
Plug 'terryma/vim-smooth-scroll' "ctrl-d,u,e,y (if terminal window speed is slow, this will suck)
Plug 'AlessandroYorba/Alduin' "colorscheme
Plug 'majutsushi/tagbar' "toggle f8 to see codebase symbols
Plug 'vim-scripts/star-search' " * search no longer jumps to next thing immediately. Can search visual selections
call plug#end()

nmap <F8> :TagbarToggle<CR>

" set UTF-8 encoding
set enc=utf-8 fenc=utf-8 termencoding=utf-8

" Show current line number, relative line number above/below current line (current line shows file line number), redraw only when needed
" relativenumber makes it a little slower than normal, need to set cursorline
" to get the color highlight in the number column on the current line
set number lazyredraw

" Highlights the  line that's being edited when in insert mode (in some way,depends on color scheme I think)
" To make it more obvious which mode we are in given that we can't edit the
" cursor type for terminal vim
" This is good for tracking the cursor but makes it a little slower(all depends on terminal window redraw speed)
" set cursorline
" hi CursorLine ctermbg=NONE " init to none
" autocmd InsertEnter * hi CursorLine ctermbg=233
" autocmd InsertLeave * hi CursorLine ctermbg=NONE
" This doens't do cursorline in normal mode to make scrolling smoother
set nocursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" Toggle between header and source for c/cpp files (just like visual studio)
nnoremap <c-k><c-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>

" <c-a> and <c-x> commands for inc dec numbers wont interpret any number as octal (ex: c-a on 007 would go up to 010)
set nrformats-=octal

" turn on incremental smartcase search highlighting (don't silently wrap, use gg and G to manually continue search)
set incsearch hlsearch nowrapscan smartcase ignorecase

" Press Enter to turn off search highlights and flash the location of the cursor
function! Flash()
  set cursorline cursorcolumn
  redraw
  sleep 35m
  set nocursorline nocursorcolumn
endfunction
nnoremap <cr> :noh<cr>:call Flash()<cr>

"allow backspace to work normally
set backspace=indent,eol,start

" remap <leader> to spacebar (default '\')
noremap <space> <nop>
let mapleader= "\<space>"

" set text to consolas, size
set guifont=Consolas:h9
set tabstop=2     "tabs are at proper location
set shiftwidth=2  "indenting is 4 spaces
set expandtab     "don't use actual tab character (ctrl-v)

"show line num file name leave space for command line
set nocompatible ruler laststatus=2 showcmd showmode showmatch nowrap wildmenu
" set statusline+=%{FugitiveStatusline()}
set nomodeline " Was getting annoying error on laptop about modeline when opening files, duckduckgo said to turn it off
set visualbell t_vb=    " turn off error beep/flash
set novisualbell " turn off visual bell
" smart indenting
filetype plugin indent on
set autoindent    "turns it on
set smartindent   "does the right thing (mostly) in programs
set cindent       "stricter rules for C programs

" vim treats a sequences of [A-Za-z0-9_] as a `word` (WORD just goes to next whitespace)
" You can re-define what word mean to vim, this removes the _ char from the set
" of contiguous chars that defined a `word`
set iskeyword-=_

" Search replace
" replace in entire file
nnoremap <leader>sr :%s//g<left><left>
" replace on selected lines
vnoremap <leader>sr :s//g<left><left>

" navigate by display lines
nnoremap j gj
nnoremap k gk

" yank to end of line
nnoremap Y y$

" Preformatted comment block (The ' key is used for "go to last pos" but that is taken care of with c-o and c-i)
nnoremap ' O<esc>i/*<esc>50a*<esc>o<esc>50i*<esc>a*/<esc>Vk=o<tab>

" Only hit < or > once to tab indent, can be vis selected and repeated like normal with '.'
nnoremap < <<
nnoremap > >>

" Indent whole file, turns out to be too painful even for medium files, just do current scope instead
" nnoremap == gg=G<c-o>
nnoremap == =i{<c-o>

" make getting out of insert mode easier
" <c-[> is Windows mapping for esc
inoremap <c-[> <Esc>:w<cr>
nnoremap <c-[> <Esc>:w<cr>

" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection, VG to select until end of file
vnoremap Q :norm @q<cr>

" should remove load prompts on external change (ex: git pull)
" " Trigger autoread when cursor stops moving
" " Trigger autoread when changing buffers inside vim
set autoread
au FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime
" au FocusGained,BufEnter * :checktime

" highlight trailing whitespace in normal mode
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Go to tab by number
noremap <leader>1 :tabfirst<cr>
noremap <leader>0 :tablast<cr>

" In terminal vi, the alt+a and alt+d keys are actually ^[a and ^[d
" You can see this by typing the key sequence in a command line after doing a
" cat followed by enter or sed -n l followed by enter
" If you type alt-a after that the output will be something like ^[a which is <escape> a
" alt-a will go to next left tab
" if not terminal winodw this would just be noremap <a-a> gT
noremap <Esc>a gT
" alt-d will go to next right tab
noremap <Esc>d gt

" Get vimrc to load across a session when vimrc written
" " :so ~/_vimrc will source the vimrc so you don't have to reload
function! UpdateVimRC()
  for server in split(serverlist())
    call remote_send(server, '<Esc>:source ~/.vimrc<CR>')
  endfor
endfunction
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc call UpdateVimRC()
augroup END

" Session: save vim session to ./Session.vim, load Session.vim
" Usually just open any text file in root of a repo and type <leader>ss to create Session.vim file in the root of repo.
" Then when I need to load up the seesion again I open the Session.vim file in the root of the repo and type <leader>so to restore my session.
nnoremap <leader>ss :mks!<cr>
nnoremap <leader>so :source Session.vim<cr>

" smooth scroll plugin, increase the last arg for faster scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 5)<cr>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 5)<cr>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 6)<cr>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 6)<cr>
noremap <silent> <c-y> :call smooth_scroll#up(15, 0, 3)<cr>15j
noremap <silent> <c-e> :call smooth_scroll#down(15, 0, 3)<cr>15k

" Source the vimrc so we don't have to refresh, edit the vimrc in new tab
nmap <silent> <leader>vs :so $MYVIMRC<CR>
nmap <silent> <leader>ve :tabnew $MYVIMRC<CR>

" Less annoying backups (no more swp file in the directory you're working on)
" the "//" at the end of each directory means that file names will be built
" from the complete path to the file with all path separators substituted to
" percent "%" sign. This will ensure file name uniqueness in the preserve directory
set undodir=~/.vim//
set backupdir=~/.vim//
set directory=~/.vim//

" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :GFiles :Rg
nnoremap <leader>m :Marks<cr>
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files<cr>
" nnoremap <leader>hh :History<cr>
" nnoremap <leader>h/ :History/<cr>
" nnoremap <leader>h: :History:<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr> " need to install ripgrep or compile it in rust, not available on ubuntu 18.04

" Tabularize plugin, to align this I highlighted then :Tabularize /:Tabularize
" Should definitely checkout
" https://www.vim.org/scripts/script.php?script_id=294
vnoremap  <leader>tt      :Tabularize  /
vnoremap  <leader>t<bar>  :Tabularize  /\|<cr>
vnoremap  <leader>t=      :Tabularize  /^[^=]*\zs=<cr>
vnoremap  <leader>t,      :Tabularize  /,<cr>
vnoremap  <leader>ts      :Tabularize  /\S\+<cr>
vnoremap  <leader>t/      :Tabularize  /\/\/<cr>

" Type :help fo-table (or hit K when cursor over fo-table) to see what the different letters are for formatoptions
set formatoptions=rqj

" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<cr><cr>
            \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
onoremap s :normal vs<cr>
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
" nnoremap ci" ?"<cr>vNc""<Esc>:noh<cr>i
" nnoremap cin" /".*\S\+.*"<cr>:noh<cr>iasdf
" nnoremap cil" ?".*\S\+.*"<cr>cs""<Esc>:noh<cr>i

"NOTES:
" Re-flow comments by visually selecting it and hit gq
" :qa! quits all without saving
" :wqa! write and quits all
"  with tcomment_vim installed you can comment lines with gc when they are visually selected
" possibly useful nomral mode keys:
" :%!python -m json.tool // Prettify Json files (choco install python)
" <c-w>gf to open file under cursor in a new tab, gf will open file in this tab
" ; will repeat t/T and f/F (line movement to and find) commonds. , will repeat reverse directio direction
" <c-w><c-w> cycle split windows
" c-w + h,j,k, or l will nav to other splits
" c-w + s,v opens the same buffer in a horiz or vert split
" K will search in man pages for the command under cursor (this has been remapped to to opposite of J)
" :sh will open a shell
" di{ to delete method body, can do this with these as well: " ( [ ' <
" daw deletes around(includes white space) word use this instead of db unless you really need db
" :windo diffthis (diff windows in current tab, :diffoff! to turn it off)
" :g/^\s*$/d global delete lines containing regex(whitespace-only lines)
" :g!/error\|warn\|fail/d opposite of global delete (equivalent to global inverse delete (v//d)) keep the lines containing the regex(error or warn or fail)
" :tab sball -> convert everything to tabs
" gt (next tab) gT(prev tab) #gt (jump to tab #)
" :mks! to save Session.vim in current folder
" :source Session.vim to open the Session.vim saved session
" c-n, c-p tab-like completion pulling from variety of sources (also for prompt navigation, prev, next)
" c-x c-l whole line completion
" c-x c-o syntax aware omnicompletion
" see this for native vim auto complete https://robots.thoughtbot.com/vim-you-complete-me
" clipboard reg 1 yank in word nmode: "1yiw vmode: "
" clipboard reg 1 yank in word nmode: "1yiw vmode: "1y
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" edit file under cursor: gf
" open prevoius file: <c-6> good for toggling .h and .cpp (can also use fzf's :History command <leader>hh)
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg :GFiles :Windows
" :Vex vertical explorer (can navigate and search like normal vim, READ THE F1 help looks configurable  to work like a tree)
" can turn a split into a tab by doing c-w then T
" zz to center the line you're on in the middle of the screen
" zt to put the line you're on at the top of the screen
" c-y anc c-e scroll up and down keeping the cursor on the same line
" c-x subtracts 1 from number under curosr c-a adds 1
" zE remove all folds
" [{ ]} will jump to beginning and end of a {} scope
" vip will highlight a block bound by blank lines
" % will jump to (), [], [] on a line
" INSERT MODE MOVEMENT:
" CTRL-W    Delete word to the left of cursor
" CTRL-U    Delete everything to the left of cursor
" CTRL-O    Goes to normal mode to execute 1 normal mode command
" COMMAND MODE:
" ctrl-n, p next previous command in history

" [ COMMANDS (The ] key is the forward version of the [ key)
" [ ctrl-i jump to first line in current and included files that contains the word under the cursor
" [ ctrl-d jumpt to first #define found in current and included files matching the word under cursor
" [/ cursor N times back to start of // comment
" [( cursor N times back to unmatched (
" [{ cursor N times back to unmatched {
" [[ cursor N times back to unmatched [
" [D list all defines found in current and lincluded files matching word under cursor
" [I list all lines found in current and lincluded files matching word under cursor
" [m cursor N times back to start of memeber function
" gD go to def or word under cursor in current file
" gd go to def or word under cursor in current function

" REGISTERS
" :reg to list whats in all the registers
" "" is the unamed register (d,x,s,c) will go there
" "0 is the last yank, 1-9 are the deletes, youngest to oldest
" ". is THE LAST INSTERTED TEXT, GOOD FOR REPEATED PASTES
" "% is the current file name
" ": most recent command. Ex: if you saved with :w then w will be in this reg
" "+ is the system clipboard for copying into and out of vim
" @: uses this register to execute the command again
" "# is the name of the last edited file (what vim uses for c-6)
" "= is the expression regiser: This is easier to understand with an example. If, in insert mode, you type Ctrl-r =, you will see a “=” sign in the command line. Then if you type 2+2 <enter>, 4 will be printed. This can be used to execute all sort of expressions, even calling external commands. To give another example, if you type Ctrl-r = and then, in the command line, system('ls') <enter>, the output of the ls command will be pasted in your buffer
" "/ is the search register, the last thing searched for
" Editing macros since they are stored in registers: For example, if you forgot to add a semicolon in the end of that w macro, just do something like :let @W='i;'. Noticed the upcased W? That’s just how we append a value to a register, using its upcased name, so here we are just appending the command i; to the register, to enter insert mode (i) and add a semicolon.
"If you need to edit something in the middle of the register, just do :let @w='<Ctrl-r w>, change what you want, and close the quotes in the end. Done, no more recording a macro 10 times before you get it right.

" INSERT MODE
" c-w deletes word
" c-u deletes line

" Bad but might have nugget of good idea
" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy
