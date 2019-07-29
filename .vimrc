

" To jump to vim docs put word over cursor or highlight it with combo viW and press K
" or :h theKeywordOfIntereset

let baseDataFolder="~/.vim"

noremap <space> <nop>
let mapleader="\<space>" " Map the leader key to space bar

if has("win32")
    set guifont=Consolas:h10
else
    " set guifont=Ubuntu:h10
endif

" The different events you can listen to http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-execute
" autocmd-events for executing : commands (full explanations: autocmd-events-abc)

" So git bash or whatever doesn't throw up errors everywhere when it needs you to edit a commit message
if v:progname == 'vi'
  set noloadplugins
endif

filetype plugin indent on  " try to recognize filetypes and load rel' plugins
set formatoptions=rqj " Type :help fo-table (or hit K when cursor over fo-table) to see what the different letters are for formatoptions
set formatoptions-=o " Type :help fo-table (or hit K when cursor over fo-table) to see what the different letters are for formatoptions
set nocompatible " vim, not vi
syntax on        " syntax highlighting
syntax enable    " syntax highlighting
set signcolumn=yes " Always draw the signcolumn so errors don't move the window left and right
set nrformats-=octal
set number              " Show line numbers
" set relativenumber    " Need to learn to touchtype number row to use this effectively. Slows down terminals. EasyMotion seems faster than this or search could ever be.
set background=dark     " tell vim what the background color looks like
set backspace=indent,eol,start " allow backspace to work normally
set history=200         " how many : commands to save in history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set hlsearch           " do incremental searching
set incsearch           " do incremental searching
set nowrapscan          " Don't autowrap to top of tile on searches
set ignorecase
set smartcase
set laststatus=2        " Always display the status line
set autowrite           " Automatically :write before running commands
set magic               " Use 'magic' patterns (extended regular expressions).
set guioptions=         " remove scrollbars on macvim
set noshowmode          " don't show mode as airline already does
set mouse=a             " enable mouse (selection, resizing windows)
set nomodeline          " Was getting annoying error on laptop about modeline when opening files, duckduckgo said to turn it off
" let tabspaces=4
" set tabstop=$tabspaces           " Use 4 spaces for tabs.
" set shiftwidth=$tabspaces        " Number of spaces to use for each step of (auto)indent.
" set expandtab           " insert tab with right amount of spacing
set shiftround          " Round indent to multiple of 'shiftwidth'
set termguicolors       " enable true colors
set hidden              " enable hidden unsaved buffers
silent! helptags ALL    " Generate help doc for all plugins
" set iskeyword+=-        " as-asdf-asdf-asdf-a-fd
set enc=utf-8 fenc=utf-8 termencoding=utf-8 " set UTF-8 encoding
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set nobackup
set nowritebackup
set noswapfile
set splitbelow " :sp defaults down
set splitright " :vs defaults right
set ttyfast           " should make scrolling faster
set lazyredraw        " should make scrolling faster
set diffopt+=vertical " Always use vertical diffs
set visualbell " visual bell for errors
set wildignorecase
set wildmenu                        " enable wildmenu
set wildmode=list:longest,list:full " configure wildmenu
set textwidth=80
set nowrap                          " Don't word wrap
set clipboard+=unnamedplus " To ALWAYS use the system clipboard for ALL operations
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.

if has('gui')
  " Turn off scrollbars. (Default on macOS is "egmrL").
  set winaltkeys=no
  set guioptions-=L
  set guioptions-=R
  set guioptions-=b
  set guioptions-=l
  set guioptions-=r
  set guioptions-=T
  set guioptions-=m
endif


" sort of worked but enter has issues for re-highl old searches
" autocmd CmdlineEnter * set nohlsearch
" autocmd CmdlineLeave * set hlsearch

" FILETYPE
" Associate filetypes with other filetypes
autocmd BufRead,BufNewFile *.shader set filetype=c
autocmd BufRead,BufNewFile *.vert   set filetype=c
autocmd BufRead,BufNewFile *.frag   set filetype=c
autocmd BufRead,BufNewFile *.md     set filetype=markdown

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
" add support for comments in json (jsonc format used as configuration for many utilities)
autocmd FileType json syntax match Comment +\/\/.\+$+

" notify if file changed outside of vim to avoid multiple versions
autocmd FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

" Plugins. Execute :PlugInstall for any new ones you add
" Auto install the vim-plug pluggin manager if its not there
" let plugDotVimLocation=baseDataFolder . "autoload/plug.vim"
" if empty(glob(plugDotVimLocation))
" need to do execute with quotes and stuff probably
"   silent !curl -fLo plugDotVimLocation --create-dirs
"         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

call plug#begin(baseDataFolder . '/bundle') " Arg specifies plugin install dir
" Bread and butter file searcher.
" <space>f to search for tracked files in git repo.
" Lots of other powerful stuff see git repo for details. Install ripgrep (choco install ripgrep) and do <space>r for a grep search (git aware).
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Not bad actually
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'
" see http://www.futurile.net/2016/03/19/vim-surround-plugin-tutorial/
" can use with vim-repeat,
" d s <existing char>    Delete existing surround
" c s <existing char> <desiredChar>    Change surround existing to desired
" y s <motion><desiredChar> (as in you-surround) Surround in the motion(ex: iw)
" y ss <desiredChar> Surround the line
" y S <motion><desiredChar>  Surround in the motion , putting the surround chars on lines above and below and indenting text
" y SS <desiredChar>  Surround the line, puttuing the surround chars on lines above and below
" S <desiredChar> Surround when in visual modes (surrounds full selection) with char

" Auto detect tab width
Plug 'tpope/vim-sleuth'

Plug 'tpope/vim-eunuch'
" :Delete: Delete a buffer and the file on disk simultaneously.
" :Unlink: Like :Delete, but keeps the now empty buffer.
" :Move: Rename a buffer and the file on disk simultaneously.
" :Rename: Like :Move, but relative to the current file's containing directory.
" :Chmod: Change the permissions of the current file.
" :Mkdir: Create a directory, defaulting to the parent of the current file.
" :Cfind: Run find and load the results into the quickfix list.
" :Clocate: Run locate and load the results into the quickfix list.
" :Lfind/:Llocate: Like above, but use the location list.
" :Wall: Write every open window. Handy for kicking off tools like guard.
" :SudoWrite: Write a privileged file with sudo.
" :SudoEdit: Edit a privileged file with sudo.

" jump between version control hunks with [c and ]c. You can preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu respectively.
" can use with vim repeat
Plug 'airblade/vim-gitgutter'
nnoremap ]h <Plug>GitGutterNextHunk
nnoremap [h <Plug>GitGutterPrevHunk

" Check the repo for whats required to be installed(some python stuff)
" Plug 'Shougo/denite.nvim'

" Not reliable (like all ctags trash)
" Tag file management, should use Exhuberant Ctags
Plug 'ludovicchabant/vim-gutentags'
" set statusline+=%{gutentags#statusline()}
" " " Plug 'skywind3000/gutentags_plus' " Need to explore this more, are its search cases common or niche

" Syntax highlighting for a ton of languages
Plug 'sheerun/vim-polyglot'

" LSP for code completion options:
" Need this in the project root/CMakeLists.txt (below the project declaration). Example "root" would be agi-asset-pipeline/
" # Generates a compile_commands.json in /build to be used for Language Servers so that text editors like vim emacs sublime etc can understand c/c++ codebases
" set (CMAKE_EXPORT_COMPILE_COMMANDS ON)
" This will spit out a compile_commands.json in the /build dir.
" Would need to copy this file to the root dir
" LSP for cpp. Just follow this:
" https://clang.llvm.org/extra/clangd/Installation.html
" Windows 10 : https://clang.llvm.org/get_started.html
" https://github.com/autozimu/LanguageClient-neovim/wiki/Recommended-Settings
" another lang server for c: https://github.com/MaskRay/ccls
" worth looking at?: nvim-gdb
" https://github.com/neoclide/coc.nvim
" https://vim.fandom.com/wiki/Using_vim_as_an_IDE_all_in_one
" https://vim.fandom.com/wiki/Omni_completion
" Follow clang-tools install steps here: https://clang.llvm.org/extra/clangd/Installation.html

""" COC
" https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" https://github.com/MaskRay/ccls/wiki/coc.nvim
" " Use release branch
" :checkhealth to see if running
" :CoCInfo
" coc-ccls doesn't just work, use clangd
" "CocInstall coc-tsserver coc-eslint coc-json coc-html coc-css coc-sh coc-rls coc-syntax coc-tag
" :CocUninstall coc-css
" "CocList  commands
" "CocCommand <tab>
" " :CocConfig will edit the config file where you put languageservers usually lives here ~/.config/nvim/coc-settings.json
" :CocList extensions will list your extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
set statusline+=%{coc#status()}
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>ci <Plug>(coc-implementation)
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" To make <cr> select the first completion item and confirm the completion when no item has been selected:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" To make coc.nvim format your code on <cr>, use keymap:
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" THIS REMOVES THE START WINDOW FOR VIM
" WIndows key repeat rate: https://ludditus.com/2016/07/15/microsoft-the-keyboard-repeat-rate-and-sleeping-how-to-work-around-their-idiocy/
" linux search keyboard set to 200ms delay, 40c/s
Plug 'vim-airline/vim-airline' " see 'powerline/fonts' for font installation 'sudo apt install fonts-powerline'
" let g:airline_powerline_fonts = 1
" This is what makes airline amazing:
  let g:airline#extensions#gutentags#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Just display filename
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!|term\:'
  " let g:airline_section_x       (tagbar, filetype, virtualenv)
  " let g:airline_section_y       (fileencoding, fileformat)
  " let g:airline_section_z       (percentage, line number, column number)
let g:airline_section_a = '' " mode.
let g:airline_section_c = '' " filename is already in the airline tabline
let g:airline_section_x = '' " filetype.
let g:airline_section_y = '' " encoding/format.
let g:airline_section_z = '' " positon info.
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='ayu_dark'
" Enable repeat for supported plugins
" Not sure I acutally make use of this
Plug 'tpope/vim-repeat'

" Run git commands from inside vim
Plug 'tpope/vim-fugitive'

" NOTE: has some bugs and seems slow, Multiple cursors
" I have better mappings below with <leader>ew ey Ew Ey
" To make a basic selection, use the Ctrl+N keystroke in normal mode, followed by a motion:
"     c – change text.
"     I – insert at start of range.
"     A – insert at end of range.
" Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_use_default_mapping=0
" " Default mappings except change c-x c-m
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<A-n>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" " let g:multi_cursor_skip_key            = '<C-x>'
" let g:multi_cursor_skip_key            = '<C-m>'
" let g:multi_cursor_quit_key            = '<Esc>'

" Type s and a char of interesst then the colored letters at the char to jump to it.
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys =   'FJDKSLA;GHEIRUWOQPTYNVMCBZX' " should sort from easy to hard (left to right)
let g:EasyMotion_smartcase = 1
" Jump to anywhere you want with minimal keystrokes, with just one key binding. `s{char}{label}`
" overwin can jump across panes. f2 is 2 char search
" This will search before and after cursor over panes
" nmap s <Plug>(easymotion-overwin-f)
" extend the native t,T,f,F commands to all visible lines, not just current line
" nmap f <Plug>(easymotion-f)
" nmap F <Plug>(easymotion-F)
" nmap t <Plug>(easymotion-t)
" nmap T <Plug>(easymotion-T)
" This will search before and after cursor in current pane
nmap s <Plug>(easymotion-s)

" Plug 'godlygeek/tabular' " Aligning selected text on some char or regexK
" vnoremap  <leader>t<bar>  :Tabularize  /\|<cr>
" vnoremap  <leader>t/      :Tabularize  /\/\/<cr>

Plug 'vim-scripts/star-search' " star search no longer jumps to next thing immediately. Can search visual selections.

" Plug 'wincent/scalpel' " leader e for editing word under cursor with comfirms

" :TermainlVSplit bash (needs python3)
" Plug 'tc50cal/vim-terminal'
" Only use this for Ttoggle (term toggle) any way to do this myself?
Plug 'kassio/neoterm' " Only use this for Ttoggle (term toggle) any way to do this myself?
let g:neoterm_autojump = 1
let g:neoterm_autoinsert = 1
let g:neoterm_size = 10

Plug 'majutsushi/tagbar' " good for quickly seeing the symobls in the file so you have word list to search for
" Toggle f8 to see code symbols for file. Need to install Exuberant ctags / Universal ctags via choco(MS Windows))
map <F8> :TagbarToggle<cr>

" Plug 'scrooloose/nerdtree'
" map <F7> :NERDTreeToggle<CR>
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" m is menu

map <F7> :20Lex<CR><c-w><c-l>
        " netwr is possibly than nerdtree
        " How to start in vert line mode
        " Hitting enter on the f1 help line will cycle the commands that it displays on that line
        " <cr>    Netrw will enter the directory or read the file      |netrw-cr|
        "   t    Enter the file/directory under the cursor in a new tab|netrw-t|
        "   v    Enter the file/directory under the cursor in a new   |netrw-v|
        "        browser window.  A vertical split is used.
        "   o    Enter the file/directory under the cursor in a new   |netrw-o|
        "        browser window.  A horizontal split is used.
        "        Useful if you want another netwr window below the current one for differnt parts of the repo
        " <c-h>    Edit file hiding list                                |netrw-ctrl-h|
        " <c-l>    Causes Netrw to refresh the directory listing        |netrw-ctrl-l|
        "   d    Make a directory                                     |netrw-d|
        "   D    Attempt to remove the file(s)/directory(ies)         |netrw-D|
        "   R    Rename the designated file(s)/directory(ies)         |netrw-R|
        "   %    Open a new file in netrw's current directory         |netrw-%|
        "   s    Select sorting style: by name, time, or file size    |netrw-s|
        "   S    Specify suffix priority for name-sorting             |netrw-S|
        "   gb    Go to previous bookmarked directory                  |netrw-gb|
        "   gh    Quick hide/unhide of dot-files                       |netrw-gh|
        "   i    Cycle between thin, long, wide, and tree listings    |netrw-i|
        "   mb    Bookmark current directory                           |netrw-mb|
        "   mc    Copy marked files to marked-file target directory    |netrw-mc|
        "   md    Apply diff to marked files (up to 3)                 |netrw-md|
        "   me    Place marked files on arg list and edit them         |netrw-me| " Decides to open them in the fucking netwr window. vim is terrible
        "   mf    Mark a file                                          |netrw-mf| " Must do one at a time. cant leverage visual select? vim is terrible.
        "   mF    Unmark files                                         |netrw-mF|
        "   mh    Toggle marked file suffices' presence on hiding list |netrw-mh|
        "   mm    Move marked files to marked-file target directory    |netrw-mm|
        "   mp    Print marked files                                   |netrw-mp|
        "   mr    Mark iles using a shell-style |regexp|              |netrw-mr|
        "   mg    Apply vimgrep to marked files                        |netrw-mg|
        "   mu    Unmark all marked files                              |netrw-mu|
        "   p    Preview the file                                     |netrw-p|
        "   P    Browse in the previously used window                 |netrw-P|
        "   qb    List bookmarked directories and history              |netrw-qb|
        "   qF    Mark files using a quickfix list                     |netrw-qF|
        "   qL    Mark files using a |location-list|                     |netrw-qL|
        "   r    Reverse sorting order                                |netrw-r|

" FONT SIZE FONT ZOOM
" neovim seems to work with both
" theres a neovim gtk version that works for linux and windows
Plug 'schmich/vim-guifont' " quickly increase decrease font size in guis
let guifontpp_size_increment=1
let guifontpp_smaller_font_map="<c-->"
let guifontpp_larger_font_map="<c-=>"

" " continuously updated Session.vim
" Plug 'tpope/vim-obession'
Plug 'tpope/vim-commentary'
autocmd FileType c,cpp,javascript,json setlocal commentstring=//\ %s
" dgc will delete comment block, ygc yanks
" gcgc and gcu will uncomment a set of comments
" gcip gci{ will comment those motions

Plug 'kana/vim-altr'
" Use this to toggle .h/cpp buffers without polluting the buffer list
" see https://vi.stackexchange.com/questions/11087/switch-between-header-and-source-files-in-one-buffer
" https://github.com/kana/vim-altr/blob/master/doc/altr.txt
" also consider vim-scripts/a.vim
function! ToggleAndKillOldBuffer()
  let b = bufnr("%")
  silent! update!
  call altr#forward()
  execute "bdelete " . b
endfunction
nnoremap <A-o> :call ToggleAndKillOldBuffer()<CR>

" see https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" There was a comment about making sure .viminfo is read/write
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

 " Can target next(n) and last(l) text object. Adds new delimiter pairs and can target function args with a. Ex: dina cila vina function(cow, mouse, pig) |asdf|asdf| [thing 1] [thing  2]
Plug 'wellle/targets.vim'

" Colorschemes
" for a giant reppo of Colorschemes see flazz/vim-colorschemes
set t_Co=256
Plug 'AlessandroYorba/Alduin'
let g:alduin_Shout_Dragon_Aspect = 1

call plug#end()

" COLORSCHEME must come before whitespace highlighting and other color alterations
" " aludin doesn't allow the whitespace red coloring???
colorscheme alduin " alduin3 has the white tabs for terminal, doesnt work in gvim, alduin2 works in gvim and nvim

" trailing whitespace, and end-of-lines. VERY useful!
" Also highlight all tabs and trailing whitespace characters.
" set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
" set list                            " Show problematic characters.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" SEARCH
" * and # search does not use smartcase
" replace word under cursor in entire file
" test this thing
" test
" testAnother
" testThis
" testSomeVarOther
" testSomeVar
" test this thing
" test
" test THIS thing
" test
" Test
" see s_flags pattern and substitute. /I forces case-sensitive matching
" Visually selected text, don't ignore case
" yank first, % for current file, \V for not having to escape symbols,
" <c-r>" to paste from yank buffer, /I forces case-sensitive matching
" you can prepare a series of commands separated by |. Buy you must escape it
" norm or normal means execute the following key sequence in normal mode.

if has("nvim")
  set inccommand=nosplit " Remove horizontal split that shows a preview of whats changing
endif
" E means edit with confirms, e is no confirm.
" Second letter is source: w is word under cursor, y is yanked text.
" Even with very no magic (\V) modifier, still need to escape / and \ with \
" The \< and \> means don't do a raw string replace but a word replace
" so if you want to replace someVar, it won't touch vars name someVarOther
" edit word in whole file
nnoremap <leader>ew :%s/\V\<<c-r><c-w>\>//gI \|normal <c-o><c-left><c-left><left><left><left><left>
" Edit confirm word in whole file
nnoremap <leader>Ew :,$s/\V\<<c-r><c-w>\>//gIc \|1,''-&&<c-left><left><left><left><left><left>
" edit word under cursor within the visual lines
" gv selects the last vis selection (line, block or select)
vnoremap <leader>ew <Esc>yiwgv:s/\V\<<c-r>"\>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>
" Visually selected text in file
" If mode is visual line mode, edit the prev yank acros the vis lines, else across the whole file
" see :help escape()
" c-r=escape() means paste in the result of escape
vnoremap <expr> <leader>ey mode() ==# "V" ?
      \ ":s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"
      \: "y:%s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"

nnoremap <leader>ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gI <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left>
nnoremap <leader>Ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gIc <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left><left>

" see "h <expr> and :help mode()
" Make A and I work in vis line mode. They already  work in the block bounds so leave that be.
xnoremap <expr> A mode() ==# "V" ? "<c-v>$A" : "A"
xnoremap <expr> I mode() ==# "V" ? "<c-v>^I"  : "I"

" \v search prefix modifier is very magic, \V prefix modifier very no magic. Only \ and / have meaning and must be escaped with \
nnoremap / /\V
vnoremap / /\V

" NAVIGATION WINDOW RESIZE
" Only seems to work for gvim on windows
" might work with neovim-gtk on windows
" neovim-gtk on kubuntu is dead on arrival
" This might work on neovim 0.4
if has("win32") && has("gui_running")
    " Resize window
    set lines=999
    set columns=255
    " grow window horizontally
    nnoremap <s-left> :set columns-=2<cr>
    nnoremap <s-right> :set columns+=2<cr>
    " grow window vertically
    nnoremap <s-down> :set lines-=2<cr>
    nnoremap <s-up> :set lines+=2<cr>
endif

" If you set the winheight option to 999, the current split occupies as much of the screen as possible(vertically)
" and all other windows occupy only one line (I have seen this called "Rolodex mode"):
" set winheight=999
" sideways version:
" set winwidth=999
" To increase a split to its maximum height, use Ctrl-w _.
" To increase a split to its maximum width, use Ctrl-w |.

" I don't wan't to think through vim's 6 different ways to scroll the screen
" Bonus: frees up ctrl e, y, f, b
" For this single sroll setup, it's best to set really fast pollrate (~40 keys/s) and really short delay (~200ms) on the system (this is good to do in general)
nnoremap <silent> <c-e> <nop>
nnoremap <silent> <c-y> <nop>
nnoremap <silent> <c-f> <nop>
nnoremap <silent> <c-b> <nop>
nnoremap <silent> <c-u> 7<c-y>
nnoremap <silent> <c-d> 7<c-e>

" Vert split navigaton
inoremap <c-h> <Esc><c-w>h
inoremap <c-j> <Esc><c-w>j
inoremap <c-k> <Esc><c-w>k
inoremap <c-l> <Esc><c-w>l
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
" TERMINAL
" Go to insert mode when switching to a terminal
au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
" Distinguish terminal by making cursor red
highlight TermCursor ctermfg=red guifg=red
" Ttoggle will start to always fail if that first terminal gets killed
nnoremap <silent> <c-\> :botright Ttoggle<cr>
" Esc quits the termial
" NOTE: This is needed to make fzf and other termal based things not annoying
tnoremap <Esc> <C-\><C-n>:q<cr>
tnoremap <C-\> <C-\><C-n>
" To simulate i_CTRL-R in terminal-mode
tnoremap <expr> <c-r> '<c-\><c-n>"'.nr2char(getchar()).'pi'

" the airline removes term from tabline but must still skip it
function! BufferPrev()
  bprev
  if &buftype == 'terminal'
    bprev
  endif
endfunction
function! BufferNext()
  bnext
  if &buftype == 'terminal'
    bnext
  endif
endfunction
" Cycle tabs in tab bar
nnoremap <silent> <c-a> :call BufferPrev()<cr>
nnoremap <silent> <c-x> :call BufferNext()<cr>
" kill buffer tab
nnoremap <silent> <c-q> :silent! up! <bar> silent! bp! <bar> silent! bd! #<cr>

" Toggle between header and source for c/cpp files
if has("gui_running") || has("nvim")
  " :e file:p is full path of file. the :s are a chain of substitutes the , are the sub delimiters
  " the X123X is just for putting an X123X extension on it.
  " this only works if in the same directory
  " TODO: need a way to save and kill the old buffer if we found a corresponding file
  " See kana/vim-altr
  " nnoremap <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
  " nnoremap <A-a> gT
  " " alt-d will go to next right tab
  " nnoremap <A-d> gt
  " " alt-A will move the current tab to the left
  " nnoremap <A-A> :tabm -1<cr>
  " " alt-D will go to next right tab
  " nnoremap <A-D> :tabm +1<cr>
else
  " NOTE: Escape mappings will cause delay in vim terminal
  " In terminal vi, the alt+a and alt+d keys are actually ^[a and ^[d
  " You can see this by typing the key sequence in a command line after doing a
  " cat followed by enter or sed -n l followed by enter
  " If you type alt-a after that the output will be something like ^[a which is <escape> a
  " if not terminal winodw this would just be noremap <a-a> gT
  " alt-a will go to next left tab
  " Bad to have Esc mappings avoid Alt key since terminal commonly maps Alt to Esc
  " nnoremap <Esc>a gT
  " " alt-d will go to next right tab
  " nnoremap <Esc>d gt
  " " alt-A will move the current tab to the left
  " nnoremap <Esc>A :tabm -1<cr>
  " " alt-D will go to next right tab
  " nnoremap <Esc>D :tabm +1<cr>
  " nnoremap <Esc>o :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
endif


" COLORCOLUMN
" Highlight from 81 on in a different color
" let &colorcolumn=join(range(81,999),",")

" CURSORLINE (can be slower in some terminals)

" purple4 royalblue4 black
" You can also specify a color by its RGB (red, green, blue) values.
" The format is "#rrggbb", where
" :highlight Comment guifg=#11f0c3 guibg=#ff00ff
" hi CursorLine  cterm=NONE ctermbg=royalblue4 ctermfg=NONE
hi cursorline  gui=NONE guibg=purple4 guifg=NONE
hi cursorcolumn  gui=NONE guibg=purple4 guifg=NONE

function! EnterInsertMode()
    hi cursorline  gui=NONE guibg=black guifg=NONE
endfunction
function! LeaveInsertMode()
    hi cursorline  gui=NONE guibg=purple4 guifg=NONE
    silent! update!
endfunction
autocmd InsertEnter * call EnterInsertMode()
autocmd InsertLeave * call LeaveInsertMode()

let g:useCursorline = 1
if g:useCursorline == 1
    set cursorline
    autocmd BufEnter * set cursorline
    autocmd BufLeave * set nocursorline
else
    set nocursorline
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
endif

" Pressing enter flashes the cursoline and column and removes the search highlight
" Was needed for terminals where the cursor was hard to find where linecoloring
" was slow in normal mode so you had to turn it off
function! Flash()
    silent! update!
    set cursorline cursorcolumn
    redraw
    sleep 100m

    set nocursorcolumn
    if g:useCursorline == 0
        set nocursorline
    endif
endfunction
nnoremap <c-[> :silent! call Flash()<cr>:noh<cr>

" Remove whitespace replace tabs with spaces
nnoremap <leader>w mw:%s/\s\+$//e <bar> %s/\t/    /ge<cr>`w`w
" autocmd BufWritePre * %s/\s\+$//e

" Only hit < or > once to tab indent, can be vis selected and repeated like normal with '.'
nnoremap < <<
nnoremap > >>

" Indent whole file, turns out to be too painful even for medium files, just do current scope instead
" nnoremap == gg=G<c-o>
nnoremap == =i{<c-o>


" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection, VG to select until end of file
vnoremap Q :norm @q<cr>

" navigate by display lines
nnoremap j gj
nnoremap k gk

" yank to end of line to follow the C and D convention. vim is terrible
nnoremap Y y$

" Session: save vim session to ./Session.vim, load Session.vim
" Usually just open any text file in root of a repo and type <leader>ss to create Session.vim file in the root of repo.
" Then when I need to load up the seesion again I open the Session.vim file in the root of the repo and type <leader>so to restore my session.
nnoremap <leader>ss :mks!<cr>
nnoremap <leader>so :so Session.vim<cr>:so $MYVIMRC<cr>

" nvim_win_config
" grow splits horizontally
" Shift left/right doesn't work in terminals?
" use ctrl l,r,u,d for term split resize
" use shft l,r,u,d for gui window resize
nnoremap <c-left>  :vert res -2<cr>
nnoremap <c-right> :vert res +2<cr>
" grow splits vertically
nnoremap <c-down> :res -2<cr>
nnoremap <c-up>   :res +2<cr>

" Source the vimrc so we don't have to refresh, edit the vimrc in new tab
nmap <silent> <leader>vs :so ~/.vimrc<cr>
nmap <silent> <leader>ve :vs ~/.vimrc<cr>
nnoremap <leader>qq :wa!<cr>:qa!<cr>

" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :GFiles :Rg
" down / up / left / right
" let g:fzf_layout = { 'down': '~50%' }

" In Neovim, you can set up fzf window using a Vim command
nnoremap <leader>l :BLines<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>t :BTags<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files<cr>
" nnoremap <leader>hh :History<cr>
" nnoremap <leader>h/ :History/<cr>
" nnoremap <leader>h: :History:<cr>
nnoremap <leader>b :Buffers<cr>
" need to install ripgrep or compile it in rust, not available on ubuntu 18.04
nnoremap <leader>r :Rg<cr>

" Useful but better to use the visual select search and repace mappings that I setup (<leader> ey Ey ew Ew)
" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
" vnoremap <silent> s //e<c-r>=&selection=='exclusive'?'+1':''<cr><cr>
"             \:<c-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
" onoremap s :normal vs<cr>

" Pretty Json, can be called like other commands with :
nnoremap <leader>p :%!python -m json.tool


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" look up cfdo, quickfix list, location-list, vimgrep lvimgrep
" ctrl-z will take you back to terminal. fg in terminal will take you back to vim (fg is for foreground)
" gn and gN visually select the current search selction
" gv will go to the last vis selction and select it
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
" wow: https://vim.fandom.com/wiki/Power_of_g
" In the "power of g" how do I do the display context of search across all files in project/pwd to do what sublime does?
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

" jump to tag. / will do fuzzy match
" nnoremap <leader>j :tjump /
"
" list the buffers and prepare open buffer command
" nnoremap gb :ls<CR>:b<space>

" Bad but might have nugget of good idea
" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy


