set nocompatible " vim, not vi
syntax on        " syntax highlighting
syntax enable    " syntax highlighting

" neoterm said to do this
filetype off
let &runtimepath.=',~/.vim/bundle/neoterm'

filetype plugin indent on  " try to recognize filetypes and load rel' plugins
noremap <space> <nop>
let mapleader="\<SPACE>" " Map the leader key to SPACE
" Type :help fo-table (or hit K when cursor over fo-table) to see what the different letters are for formatoptions
set formatoptions=rqj
set guifont=Consolas:h9    " set text to consolas, size
set background=dark     " tell vim what the background color looks like
set backspace=2         " Backspace deletes like most programs in insert mode
set history=100         " how many : commands to save in history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set laststatus=2        " Always display the status line
set autowrite           " Automatically :write before running commands
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set guioptions=         " remove scrollbars on macvim
set noshowmode          " don't show mode as airline already does
set mouse=a             " enable mouse (selection, resizing windows)
set iskeyword+=-        " treat dash separated words as a word text object
set nomodeline          " Was getting annoying error on laptop about modeline when opening files, duckduckgo said to turn it off

set tabstop=4           " Use 4 spaces for tabs.
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent.
set expandtab           " insert tab with right amount of spacing
set shiftround          " Round indent to multiple of 'shiftwidth'
set termguicolors       " enable true colors
set hidden              " enable hidden unsaved buffers
silent! helptags ALL    " Generate help doc for all plugins

set ttyfast           " should make scrolling faster
set lazyredraw        " should make scrolling faster

" visual bell for errors
set visualbell

" wildmenu
set wildmenu                        " enable wildmenu
set wildmode=list:longest,list:full " configure wildmenu

" text appearance
set textwidth=80
set nowrap                          " Don't word wrap

" trailing whitespace, and end-of-lines. VERY useful!
" Also highlight all tabs and trailing whitespace characters.
" set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
" set list                            " Show problematic characters.
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$\|\t/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$\|\t/

" Numbers
set number " Show line numbers

" set where swap file and undo/backup files are saved
set backupdir=~/.vim//
set directory=~/.vim//

" " persistent undo between file reloads
if has('persistent_undo')
  set undofile
  set undodir=~/.vim//
endif

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" To ALWAYS use the clipboard for ALL operations
" instead of interacting with the '+' and/or '*' registers explicitly
set clipboard+=unnamedplus

" Always use vertical diffs
set diffopt+=vertical

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" add support for comments in json (jsonc format used as configuration for
" many utilities)
autocmd FileType json syntax match Comment +\/\/.\+$+

" notify if file changed outside of vim to avoid multiple versions
au FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

set nocursorline
autocmd InsertEnter * set cursorline
autocmd InsertLeave * set nocursorline

" Plugins. Execute :PlugInstall for any new ones you add
" Auto install the vim-plug pluggin manager if its not there
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle') " Arg specifies plugin install dir
" Bread and butter file searcher.
" <space>f to search for tracked files in git repo.
" Lots of other powerful stuff see git repo for details. Install ripgrep (choco install ripgrep) and do <space>r for a grep search (git aware).
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plug 'w0rp/ale'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'vim-airline/vim-airline'
" let g:airline#extensions#ale#enabled = 1
" Plug 'autozimu/LanguageClient-neovim'
" Plug 'rust-lang/rust.vim'
" Plug 'godlygeek/tabular' " Aligning selected text on some char or regex
" vnoremap  <leader>t<bar>  :Tabularize  /\|<cr>
" vnoremap  <leader>t/      :Tabularize  /\/\/<cr>
Plug 'vim-scripts/star-search' " star search no longer jumps to next thing immediately. Can search visual selections.

Plug 'kassio/neoterm'
Plug 'tomtom/tcomment_vim' " Comment selected lines with gc
Plug 'wellle/targets.vim' " Can target next(n) and last(l) text object: din( cila vin[ etc.

" Toggle f8 to see code symbols for file. Need to install Exuberant ctags / Universal ctags via choco(MS Windows))
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<cr>

" Smooth scrolling
Plug 'yuttie/comfortable-motion.vim'
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 8
let g:comfortable_motion_friction = 3000.0
let g:comfortable_motion_air_drag = 0.0
nnoremap <silent> <c-e> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 0.7)<cr>
nnoremap <silent> <c-y> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -0.7)<cr>
nnoremap <silent> <c-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1)<cr>
nnoremap <silent> <c-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1)<cr>
nnoremap <silent> <c-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 1.5)<cr>
nnoremap <silent> <c-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -1.5)<cr>
" Colorschemes
Plug 'AlessandroYorba/Alduin'
colorscheme alduin2 " alduin3 has the white tabs for terminal, doesnt work in gvim, alduin2 works in gvim and nvim
call plug#end()

" SEARCH
" set ignorecase " ignore case in searches. ic is shorthand. set noic will turn off and set !ic will toggle it
" set smartcase  " use case sensitive if capital letter present or \C
" * and # search does not use smartcase
" replace word under cursor in entire file
" This is sensitive to smartcase ignorecase settings: test the operation on these words below
" test
" Test
nnoremap <leader>sr :%s/<c-r><c-w>//<Left>
" search replace on selected lines
vnoremap <leader>sr :s//<left>
if has("inccomand")
    set inccommand=nosplit " Remove horizontal split that shows a preview of whats changing
endif

" TERMINAL
" Go to insert mode when switching to a terminal
au BufEnter * if &buftype == 'terminal' | startinsert | endif
" Distinguish terminal by making cursor red
highlight TermCursor ctermfg=red guifg=red
inoremap <silent> <c-h> <Esc><c-w>h
inoremap <silent> <c-l> <Esc><c-w>l
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-l> <c-w>l
tnoremap <silent> <c-h> <c-\><c-n><c-w>h
tnoremap <silent> <c-l> <c-\><c-n><c-w>l
" No idea why this repmap works the first time then breaks there after. It manually works
" nnoremap <silent> <leader><leader> :vertical botright Ttoggle<cr><c-w>l
" quickly toggle term with space space
func! s:toggleTerminal()
    func! s:toggleCheckInsert()
        execute "vertical" "botright" "Ttoggle"
        execute "wincmd" "l"
    endfunc

    execute "nnoremap" "<silent>" "<leader><leader>"
                \ ":call <SID>toggleCheckInsert()<cr>"
endfunc
call s:toggleTerminal()
" Esc takes you back to normal mode when in the terminal
tnoremap <esc> <c-\><c-n>
" To simulate i_CTRL-R in terminal-mode
tnoremap <expr> <c-r> '<c-\><c-n>"'.nr2char(getchar()).'pi'

" Toggle between header and source for c/cpp files
nnoremap <c-t> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>

" Press Enter to turn off search highlights, and flash the location of the cursor
function! Flash()
  set cursorline cursorcolumn
  redraw
  sleep 35m
  set nocursorline nocursorcolumn
endfunction
nnoremap <cr> :noh<cr>:call Flash()<cr>

" Only hit < or > once to tab indent, can be vis selected and repeated like normal with '.'
nnoremap < <<
nnoremap > >>

" Indent whole file, turns out to be too painful even for medium files, just do current scope instead
" nnoremap == gg=G<c-o>
nnoremap == =i{<c-o>

" make getting out of insert mode easier
" <c-[> is Windows mapping for esc
inoremap <c-[> <c-[>:w<cr>
nnoremap <c-[> <c-[>:w<cr>

" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection, VG to select until end of file
vnoremap Q :norm @q<cr>
" navigate by display lines
nnoremap j gj
nnoremap k gk

" yank to end of line
nnoremap Y y$

" Session: save vim session to ./Session.vim, load Session.vim
" Usually just open any text file in root of a repo and type <leader>ss to create Session.vim file in the root of repo.
" Then when I need to load up the seesion again I open the Session.vim file in the root of the repo and type <leader>so to restore my session.
nnoremap <leader>ss :mks!<cr>
nnoremap <leader>so :so Session.vim<cr>:so $MYVIMRC<cr>

" In terminal vi, the alt+a and alt+d keys are actually ^[a and ^[d
" You can see this by typing the key sequence in a command line after doing a
" cat followed by enter or sed -n l followed by enter
" If you type alt-a after that the output will be something like ^[a which is <escape> a
" if not terminal winodw this would just be noremap <a-a> gT
" alt-a will go to next left tab
" Bad to have Esc mappings avoid Alt key since terminal commonly maps Alt to Esc
" noremap <Esc>a gT
" " alt-d will go to next right tab
" noremap <Esc>d gt
" " alt-A will move the current tab to the left
" noremap <Esc>A :tabm -1<cr>
" " alt-D will go to next right tab
" noremap <Esc>D :tabm +1<cr>
noremap <c-j> gT
noremap <c-k> gt

if has("gui_running")
    " inoremap == 'ignore any other mappings'
    " noremap <A-a> gT
    " noremap <A-d> gt
    " Move the tab left and right in the tab bar
    " noremap <A-A> :tabm -1<cr>
    " noremap <A-D> :tabm +1<cr>

    " comment to enable Alt+[menukey] menu keys (i.e. Alt+h for help)
    set winaltkeys=no " same as `:set wak=no`

    " comment to enable menubar
    set guioptions -=m

    " comment to enable icon menubar
    set guioptions -=T
endif

" Source the vimrc so we don't have to refresh, edit the vimrc in new tab
nmap <silent> <leader>vs :so $MYVIMRC<cr>
nmap <silent> <leader>ve :tabnew ~/.vimrc<cr>

" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :GFiles :Rg
nnoremap <leader>m :Marks<cr>
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files<cr>
" nnoremap <leader>hh :History<cr>
" nnoremap <leader>h/ :History/<cr>
" nnoremap <leader>h: :History:<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>r :Rg<cr> " need to install ripgrep or compile it in rust, not available on ubuntu 18.04

" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<c-r>=&selection=='exclusive'?'+1':''<cr><cr>
            \:<c-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
onoremap s :normal vs<cr>

" Pretty Json, can be called like other commands with :
command! JSONPRETTY %!python -m json.tool


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NOTES 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
" highlighing lines then doing a :w TEST will write those lines to TEST
" :r TEST will put lines from test at the cursor
" :r !ls will put the result of ls at the cursor
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
" @: uses this register to execute the command again
" Editing macros since they are stored in registers: For example, if you forgot to add a semicolon in the end of that w macro, just do something like :let @W='i;'. Noticed the upcased W? 
" That’s just how we append a value to a register, using its upcased name, so here we are just appending the command i; to the register, to enter insert mode (i) and add a semicolon.
" If you need to edit something in the middle of the register, just do :let @w='<Ctrl-r w>, change what you want, and close the quotes in the end. Done, no more recording a macro 10 times before you get it right.
" "" is the unamed register (d,x,s,c) will go there
" "0 is the last yank, 1-9 are the deletes, youngest to oldest
" ". is THE LAST INSTERTED TEXT, GOOD FOR REPEATED PASTES
" "% is the current file name
" ": most recent command. Ex: if you saved with :w then w will be in this reg
" "+ is the system clipboard for copying into and out of vim
" "# is the name of the last edited file (what vim uses for c-6)
" "= is the expression regiser: This is easier to understand with an example. If, in insert mode, you type Ctrl-r =, you will see a “=” sign in the command line. Then if you type 2+2 <enter>, 4 will be printed. 
" This can be used to execute all sort of expressions, even calling external commands. To give another example, if you type Ctrl-r = and then, in the command line, system('ls') <enter>, the output of the ls command will be pasted in your buffer
" "/ is the search register, the last thing searched for

" INSERT MODE
" c-w deletes word
" c-u deletes line

" Bad but might have nugget of good idea
" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy
