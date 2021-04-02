" TODO: add tab complete to autocomplete
" On Windows:
" See personal vim repo for disable capslock reg file for windows 10, double click to merge it then restart your computer.
" "bash" in a windows term will use wsl/ubuntu on /mnt/c/
" Terminal shortcuts/tips:
" r-click on menu bar to configure terminal properties like colors/fonts/size,etc
" full screen toggle: alt+enter
" alpha blend: ctrl+shift+mouse scroll

noremap <space> <nop>
let mapleader="\<space>" " Map the leader key to space bar

" The different events you can listen to http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-execute
" autocmd-events for executing : commands (full explanations: autocmd-events-abc)

" So git bash or whatever doesn't throw up errors everywhere when it needs you to edit a commit message
if v:progname == 'vi'
    set noloadplugins
endif

" helps startup speed
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog  = '/usr/bin/python3'
let g:perl_host_prog = '/usr/bin/perl'

filetype plugin indent on  " try to recognize filetypes and load related plugins/settings for those filetypes
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
set noruler               " show the cursor position all the time
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
set noshowmode          " don't show mode
set mouse=a             " enable mouse (selection, resizing windows)
set nomodeline          " Was getting annoying error on laptop about modeline when opening files, duck said to turn it off
set tabstop=4           " Use 4 spaces for tabs.
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent.
set expandtab           " insert tab with right amount of spacing
set shiftround          " Round indent to multiple of 'shiftwidth'
set termguicolors       " enable true colors, if off nvim (not qt) will use default term colors
set hidden              " enable hidden unsaved buffers
silent! helptags ALL    " Generate help doc for all plugins
" set iskeyword+=-        " Add chars that count as word boundaries. test: asdf-asdf
set enc=utf-8 fenc=utf-8 termencoding=utf-8 " set UTF-8 encoding
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set nobackup
set nowritebackup
set noswapfile
set splitbelow " :sp defaults down
" set splitright " :vs defaults right, quickfix edits cycles right split window so turn this off (TODO list usually in the :vs window)
set switchbuf=useopen
set ttyfast           " should make scrolling faster
set lazyredraw        " should make scrolling faster
set diffopt+=vertical " Always use vertical diffs
set visualbell " visual bell for errors

set wildignorecase
set wildmenu                        " enable wildmenu

set textwidth=300
set nowrap                          " Don't word wrap
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

" tell :find to recursively search
set path+=**

" UNIVERSAL CTAGS
" =======================================================
" include inheritance info and signatures of functions
" it seems most of these flags are needed for :h omnicppcomplete
" How to install from source:
" git clone https://github.com/universal-ctags/ctags.git
" cd ctags
" ./autogen.sh
" ./configure
" make
" sudo make install
" ctags --version
" TO SEE A LIST OF LANGS:
" ctags --list-languages
" ========================================================
command! CScope !cscope -bcqR
command! CTags !ctags -R
            \ --languages=C,C++,CMake,CUDA,Javascript,TypeScript
            \ --c++-kinds=+pl
            \ --fields=+iaS
            \ --extras=+q
            \ --exclude='node_modules'
            \ --exclude='Bin'
            \ --exclude='bin'
            \ --exclude='Build'
            \ --exclude='build'
            \ --exclude='out'
            \ --exclude='Out'
            \ --exclude='Data'
            \ --exclude='data'
            \ --exclude='Docs'
            \ --exclude='docs'
            \ --exclude='Documentation'
            \ --exclude='documentation'
            \ --exclude='Docker'
            \ --exclude='docker'
            \ --exclude='Specs'
            \ --exclude='specs'
            \ --exclude='travis'
            \ --exclude='.git'
            \ .
" nnoremap <leader>t :cd %:p:h <bar> CTags<cr>
nnoremap <leader>tc :CTags<cr>:CScope<cr>
nnoremap <c-n> :tn<cr>
nnoremap <c-p> :tp<cr>

" " " setup cscope (need to: sudo apt update -y; sudo apt install cscope)
" if has("cscope")
"     " set to 1 to search tags first instead of cscope database
"     set csto=0
"     " also use tags file
"     set cst
"     " set nocsverb
"     " add any database in current directory
"     if filereadable("cscope.out")
"         silent! cs add cscope.out
"     " else add database pointed to by environment
"     elseif $CSCOPE_DB != ""
"         silent! cs add $CSCOPE_DB
"     endif
"     " set csverb
"     " use qf window, - mean clear prev results for that particular search
"     set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
" endif
" " NOTE: the problem with ctags and cscope is its still not really aware of codebase.
" " if you have same name you have to pick between everything with same name in the
" " lookup files that they generate.
" " therefore, you really want to use language servers instead of this stuff if you can.
" "" cscope jump to a function declaration
" " nnoremap <silent> <C-]> :cs find s <c-r>=expand("<cword>")<cr><cr>1<cr><cr>
" " show a list of where function is called
" " symbol
" nnoremap <silent> <leader>ts :cs find s <c-r>=expand("<cword>")<cr><cr>:bot cw 20<cr>
" " go to def
" nnoremap <silent> <leader>td :cs find g <c-r>=expand("<cword>")<cr><cr>:bot cw 20<cr>
" " functions called by this
" nnoremap <silent> <leader>tb :cs find d <c-r>=expand("<cword>")<cr><cr>:bot cw 20<cr>
" " calling this function
" nnoremap <silent> <leader>tc :cs find c <c-r>=expand("<cword>")<cr><cr>:bot cw 20<cr>
" " places where this symbol is assigned to
" nnoremap <silent> <leader>ta :cs find a <c-r>=expand("<cword>")<cr><cr>:bot cw 20<cr>

" notify if file changed outside of vim to avoid multiple versions
autocmd FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

" Tell vim to use ripgrep as its grep program
" NOTE: --sort path can be used to get consistent order, it will run with 1 thread.
" in terminal see rg --help for optoins to ripgrep 12
" set grepprg=rg\ --vimgrep\ --glob\ !tags\ --sort\ path
set grepprg=rg\ --vimgrep\ -g\ 'src/**'\ -g\ 'public/src/**'\ -g\ 'specs/**'

let baseDataFolder="~/.vim"
call plug#begin(baseDataFolder . '/bundle') " Arg specifies plugin install dir

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Jump to buffer if open
let g:fzf_buffers_jump = 1
" disable preview window with '' set it to right with 'right'
let g:fzf_preview_window = ''
" Allow passing other args to Rg command
" Example, :Rg '#include "Shader.h"' -g "*{.cpp,.h}"
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" choco install ripgrep fd fzf
" USE FD https://github.com/sharkdp/fd
" put in .bashrc for fd/other things
" in your ~/.bashrc, or somthing like 6:37 of https://www.youtube.com/watch?v=qgG5Jhi_Els
" see .bashrc in personal vim repo
" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg :GFiles :Windows
" all files under pwd (recursive)
"
" NOTE: calls with fzf#wrap will honor this global setting
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'border': 'horizontal' } }
" run custom, see :h fzf#run

" override the Files command, see fzf-vim-advanced-customization
nnoremap <leader>F :Files<cr>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>,
    \ {
    \   'options': ['--layout=reverse'],
    \   'source': 'fd --no-ignore --hidden --follow --type f'
    \ }, <bang>0)

" files in `git ls-files``
nnoremap <leader>fg :GFiles<cr>
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>,
    \ {
    \   'options': ['--layout=reverse'],
    \ }, <bang>0)

" v:oldfiles
nnoremap <leader>fo :History<cr>
nnoremap <leader>fm :Marks<cr>
nnoremap <leader>b :Buffers<cr>

" will eventually go into nvim proper
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" These two are for flippling between dec hex oct bin
" magnum is just a dependency of radical
" Plug 'glts/vim-magnum'
" Plug 'glts/vim-radical'

Plug 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

Plug 'majutsushi/tagbar'
nnoremap <F8> :TagbarToggle<CR>

" Surrounding things
Plug 'tpope/vim-surround'
" NOTE: If you use the closing version, i.e ),>,},] it will NOT be surrounded by spaces.
" NOTE: behavior of S< is such that it expects a tag enclosure so only S> is able to surround as <>.
" cs'"  This means change surround ' to "
" ds[  This means delete surround [
" When v selected:
" S{  This means surround selection with {
" When V selected:
" S{  This means surround selected LINES with { (open and closed brackets above and below the lines)

" Framework for enabling repeat command on plugin commands
" The plugin itself must explicitly support it though
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
" add more pairs, first line is default
let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''",
            \ '<':'>' }
" Turn off mappings
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutToggle=''

" QUICKFIX LIST
" can dd, visual delete and other things like undo, :v/someText/d (keep lines containing someText) or :g/someText/d (delete lines containing someText)
" used in the mappings for global ack and replace
Plug 'itchyny/vim-qfedit'

" :StartupTime to see a graph of startup timings
Plug 'dstein64/vim-startuptime'

" WIndows key repeat rate: https://ludditus.com/2016/07/15/microsoft-the-keyboard-repeat-rate-and-sleeping-how-to-work-around-their-idiocy/
" linux search keyboard set to 200ms delay, 40c/s

" Type s and a char of interesst then the colored letters at the char to jump to it.
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
" This will search before and after cursor in current pane
nmap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)
nnoremap S <nop>

" If using Tabs instead of buffers as tabs
" when using alt keys make sure you can diasable the corresponding alt-menu key
" in any other IDE's you may use
" vscode has a way to turn off the menu and msvc has a way to turn off certain
" menu items: https://docs.microsoft.com/en-us/visualstudio/ide/how-to-customize-menus-and-toolbars-in-visual-studio?view=vs-2019
" nnoremap <a-l> gt
" nnoremap <a-h> gT
" nnoremap <leader>1 :tabfirst<cr>
" nnoremap <leader>2 2gt
" nnoremap <leader>3 3gt
" nnoremap <leader>4 4gt
" nnoremap <leader>5 5gt
" nnoremap <leader>0 :tablast<cr>

" LSP for code completion options:
" Need this in the project root/CMakeLists.txt (below the project declaration). Example "root" would be agi-asset-pipeline/
" # Generates a compile_commands.json in /build to be used for Language Servers so that text editors like vim emacs sublime etc can understand c/c++ codebases
" set (CMAKE_EXPORT_COMPILE_COMMANDS ON)
" This will spit out a compile_commands.json in the /build dir.
" Would need to copy this file to the root dir
" LSP for cpp. Just follow this:
" https://clang.llvm.org/extra/clangd/Installation.html
" Windows 10 : https://clang.llvm.org/get_started.html
" worth looking at?: nvim-gdb
" :checkhealth to see if running
" " Install clang/clangd with: choco install llvm
" https://vim.fandom.com/wiki/Using_vim_as_an_IDE_all_in_one
" https://vim.fandom.com/wiki/Omni_completion
"NOTE: see the minimal vimrc here https://github.com/nvim-lua/completion-nvim/issues/143
" NOTE: for lsps see install steps for installing via npm and pip3
Plug 'anott03/nvim-lspinstall'
" lspconfig got rid of :LspInstall so you need anott03's plugin
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
" :TSInstallInfo lists all the languages
" :TSInstall c cpp bash lua typescript html c_sharp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" " basically a ref searcher without lsp/tags
" " <leader>j pulls up floating window to jump
" " <leader>j pulls up floating window to jump
" Plug 'pechorin/any-jump.vim'

" No forward jump, Can search visual selections.
Plug 'vim-scripts/star-search'

Plug 'voldikss/vim-floaterm'


" Font, size, resize
set guifont=Monospace:h8
let s:fontsize = 9
function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize+a:amount
    :execute "GuiFont! Monospace:h" . s:fontsize
endfunction
noremap <c-=> :call AdjustFontSize(1)<CR>
noremap <c--> :call AdjustFontSize(-1)<CR>

Plug 'tomtom/tcomment_vim'
" gcc toggles line
" gc on selection to toggle
" gcip gci{ etc. will toggle within those motions
" Prevent tcomment from making a zillion mappings (we just want the gc operator).
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''
let g:tcomment_mapleader_comment_anyway=''
let g:tcomment_textobject_inlinecomment=''

" Use this to toggle .h/cpp buffers without polluting the buffer list
" see https://vi.stackexchange.com/questions/11087/switch-between-header-and-source-files-in-one-buffer
" https://github.com/kana/vim-altr/blob/master/doc/altr.txt
" also consider vim-scripts/a.vim
Plug 'kana/vim-altr'
function! ToggleAndKillOldBuffer()
    let b = bufnr("%")
    silent! update!
    call altr#forward()
    execute "bdelete " . b
endfunction
nnoremap <a-o> :call ToggleAndKillOldBuffer()<CR>

Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1
nnoremap <leader>cr :Rooter<cr>

" Can target next(n) and last(l) text object. Adds new delimiter pairs and can target function args with a.
" Ex: dina cila vina function(cow, mouse, pig) |asdf|asdf| [thing 1] [thing  2]
" d2ina skips an arg and deletes the next one
Plug 'wellle/targets.vim'

" Colorschemes
" COLORSCHEME must come before whitespace highlighting and other color alterations
set t_Co=256
Plug 'AlessandroYorba/Alduin'
Plug 'Junza/Spink'
" close to original magicka, could use as base (dark green, black, red, cream)
Plug 'marcelbeumer/spacedust.vim'
" colorscheme alduin
" diff from alduin: baby blue gone, hlsearch is red
colorscheme alduin2
" colorscheme Spink
" colorscheme spacedust
" " Decent default scheme
" colorscheme slate

" Colorscheme designer
" Plug 'lifepillar/vim-colortemplate'

" shouldnt be needed with treesitter
" Plug 'sheerun/vim-polyglot'

Plug 'norcalli/nvim-colorizer.lua'

" Buffers as tabs setup
Plug 'akinsho/nvim-bufferline.lua'

call plug#end()

" " telescope
" lua << EOF
"     local actions = require'telescope.actions'
"     require'telescope'.setup{
"         defaults = {
"             prompt_position = "top",
"             sorting_strategy = "ascending",
"             winblend = 30,
"             mappings = {
"                 i = {
"                     ["<esc>"] = actions.close,
"                     ["<tab>"] = actions.add_selection,
"                     -- atm, there is no way to do open-all-selected without writing your own thing
"                     -- but it is on there todo list to have this built-in
"                     ["<cr>"] = actions.???,
"                 },
"             },
"             -- file_sorter =  require'telescope.sorters'.get_fuzzy_file,
"             -- file_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
"             -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
"             file_sorter =  require'telescope.sorters'.fuzzy_with_index_bias,
"             file_ignore_patterns = {},
"             set_env = { ['COLORTERM'] = 'truecolor' },
"         },
"     }
" EOF
" nnoremap <leader>F :Telescope find_files find_command=fd,--no-ignore,--hidden,--follow previewer=false<cr>
" nnoremap <leader>fo :lua require('telescope.builtin').oldfiles()<cr>
" nnoremap <leader>fm :lua require('telescope.builtin').marks()<cr>
" nnoremap <leader>fg :lua require('telescope.builtin').git_files()<cr>
" " list all finders
" " nnoremap <leader>fp :lua require('telescope.builtin').builtin()<cr>
" " nnoremap <leader>fa :lua require('telescope.builtin').live_grep()<cr>
" " linux man pages
" " nnoremap <leader>fm :lua require('telescope.builtin').man_pages()<cr>
" " plugin user commands
" " nnoremap <leader>fc :lua require('telescope.builtin').commands()<cr>
" " nnoremap <leader>fv :lua require('telescope.builtin').vim_options()<cr>
" " for colorscheme highlights
" " nnoremap <leader>fh :lua require('telescope.builtin').highlights()<cr>


" NOTE: Must go after plug#end()
:lua << EOF
  require'colorizer'.setup{}
EOF

" nvim-bufferline
" NOTE: Must go after plug#end()
:lua << EOF
  local hlColor = "GreenYellow"
  -- local hlColor = "LemonChiffon3"
  require'bufferline'.setup{
    -- override some options from their defaults
    options = {
        tab_size = 12,
        max_name_length = 40,
        show_buffer_close_icons = false,
    },
    highlights = {
        buffer_selected = {
            guifg = "Black",
            guibg = hlColor,
            gui = "bold",
        },
        -- Accent the split buffer thats not selected
        buffer_visible = {
            guifg = hlColor,
        },
    },
  }
EOF

" Add the terminal to unlisted buffers so that buffer line doesnt show it
" NOTE: Tried all the Buf* stuff but only this one seemed to work
" and so it only gets removed from buffer tabs when you leave the terminal
autocmd BufLeave bash* setlocal nobuflisted

" These commands will honor the custom ordering if you change the order of buffers.
" The vim commands :bnext and :bprevious will not respect the custom ordering.
nnoremap <silent><a-l> :BufferLineCycleNext<CR>
nnoremap <silent><a-h> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline.
nnoremap <silent><a-s-l> :BufferLineMoveNext<CR>
nnoremap <silent><a-s-h> :BufferLineMovePrev<CR>

" kill buffer tab
nnoremap <silent> <a-q> :silent! up! <bar> silent! bd!<cr>

" see https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" There was a comment about making sure .viminfo is read/write
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Change pwd to this files location. local cd (change for current vim 'window') to current file's dir (% is file name :p expands to full path :h takes the head)
nnoremap <leader>cd :lcd %:p:h <bar> pwd <cr>

" mapping nomenclature: e is edit, a is ack, r is replace, s is search, m is manual, w is word, y is yank
" TODO: need proper word boundary versions(aw, rw) for better var name changes.
" NOTE: looks like <args> (the thing after :MyGrep) has to be a space separated list of quoted items
command! -nargs=+ MyGrep mark A | execute 'silent grep! <args>' | bot cw 20
command! -nargs=+ MyGrepCurrentFile mark A | execute 'silent grep! <args> %' | bot cw 20
command! -nargs=+ MyCdo execute 'silent cfdo! <args>' | cfdo update | cclose | execute 'normal! `A'
nnoremap <leader>,as :let @w = "" <bar> MyGrep "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
nnoremap <leader>,aw :let @w = "<c-r><c-w>" <bar> MyGrep "<c-r><c-w>" "-w"<cr>
" " not sure i really need current-file-only version
" nnoremap <leader>,aS :let @w = "" <bar> MyGrepCurrentFile "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
" nnoremap <leader>,aW :let @w = "<c-r><c-w>" <bar> MyGrepCurrentFile "<c-r><c-w>" "-w"<cr>
" mapped to above. if you have something highlighted and it wasnt a word search, it will run the search version.
" otherwise run the word version. a is for current dir of file (<leader>cd) and A is for root (<leader>cr)
" rg from current files directory
nmap <expr> <leader>A v:hlsearch ==# 1 ? @/ =~ "\<" ? "<leader>cd<leader>,aw" : "<leader>cd<leader>,as" : "<leader>cd<leader>,aw"
" rg from root, make sure .gitignore is ignoring things
nmap <expr> <leader>a v:hlsearch ==# 1 ? @/ =~ "\<" ? "<leader>cr<leader>,aw" : "<leader>cr<leader>,as" : "<leader>cr<leader>,aw"

" g*            Like "*", but don't put "\<" and "\>" around the word.
                " :let v:statusmsg = ""
                " :silent verbose runtime foobar.vim
                " :if v:statusmsg != ""
                " :  " foobar.vim could not be found
                " :endif

" NOTE: rg's idea of word boundary is different from vim.
" But <leader>rs command will not remove vim word boundary regex from the / register if it's there
" things around the word if you * searched it. similar for rw if done in the quickfix window over your word.
" :h cword
" :h s_flags (I is dont ignore, e is continue on error, g is all instances on line, c is confirm)
" when doing something like :s//red/ the first arg is assumed to be previous search
nnoremap <leader>,rs :MyCdo %s/<c-r>=substitute(substitute(@/, '\\n$', '', 'g'), '/', '\\/', 'g')<cr>//gIe<left><left><left><left>
" nnoremap <leader>rm :MyCdo %s/\VgIe<left><left><left>
" To be used with <leader>aw as it saves word under cursor to w register
nnoremap <leader>,rw :MyCdo %s/\<<c-r>w\>//gIe<left><left><left><left>
" mapped to above if we took tha as or aw path above do the pick the right rs or rw
nmap <expr> <leader>r @w != "" ? "<leader>,rw" : "<leader>,rs"

" COMPLETION
" " nvim-lsp NOTE: This must go after plug section ----------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect

" lsp config
" https://github.com/neovim/nvim-lspconfig
  " Check that an LSP client has attached to the current buffer:  >
  "     :lua print(vim.inspect(vim.lsp.buf_get_clients()))
  "     :LspInfo
  "     make sure no ERRORS in
  "     :lua vim.cmd('e'..vim.lsp.get_log_path())
:lua << EOF
    ----------------
    -- COMPLETION --
    ----------------
    vim.g.completion_chain_complete_list = {
        default = {
            { complete_items = { 'lsp' } },
            { complete_items = { 'buffers' } },
            { mode = { '<c-p>' } },
            { mode = { '<c-n>' } }
        },
    }
    vim.g.completion_auto_change_source = 1
    vim.g.completion_trigger_on_delete = 1
    vim.g.completion_enable_auto_paren = 1
    vim.g.completion_sorting = 'none' -- none, length, alphabet
    vim.g.completion_enable_auto_hover = 1 -- too laggy atm
    vim.g.completion_timer_cycle = 200 -- default value is 80

    ----------------
    -- TREESITTER --
    ----------------
    require'nvim-treesitter.configs'.setup {
        -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- NOTE: if you get errors related to abi or anything with treesitter
        -- you may have to update your version of neovim, see neovim section of installSteps.txt
        ensure_installed = { "c", "cpp", 'bash', "lua", "typescript", "javascript", "html", "json" },
        highlight = {
            enable = true,
        },
    }

    ----------------
    -- LSPCONFIG  --
    ----------------
    local nvim_lsp = require('lspconfig')
    -- vim.lsp.set_log_level("debug")
    local on_attach = function(client, bufnr)
        require'completion'.on_attach()

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        local cbufnvim = vim.api.nvim_exec('echo bufnr("%")', true)

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        buf_set_keymap('n', 'gk', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        -- rename does not work, but can use *<leader>ar<leader>rs for a more accurate rename over *<leader>as<leader>rs
        -- buf_set_keymap('gs', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        buf_set_keymap('n', 'gr', '<cmd>let @w = "<c-r><c-w>" <bar> lua vim.lsp.buf.references()<cr>', opts)
        buf_set_keymap('n', 'ge', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
        buf_set_keymap('n', 'gw', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    end

    -- Use a loop to conveniently both setup defined servers
    -- and map buffer local keybindings when the language server attaches
    -- tsserver(slow)
    -- see installSteps.txt in vim repo for installing servers via npm and pip3
    -- local servers = { "vimls", "sumneko_lua" }
    local servers = { "html", "clangd", "vimls", "jsonls", "bashls", "cmake", "tsserver", "sumneko_lua" }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup { on_attach = on_attach }
    end

    -- -- NOTE: use these for debug info
    -- -- uncomment vim.lsp.set_log_level("debug") above
    -- -- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
    -- -- :LspInfo
    -- -- to look in the lsp's log:
    -- -- :lua vim.cmd('e'..vim.lsp.get_log_path())
    -- -- Use to debug clang, remove from server list above but remember to put it back when fixed
    -- nvim_lsp.clangd.setup{
    --     cmd = { "clangd", "-j=1", "--log=verbose" };
    --     -- on_attach = on_attach
    -- }
EOF

" Presentation mode. Need a dir full of .vpm files (number them, for example, 00.vpm) and goyo plugin
" in command line: cd dir; nvim *
autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
function SetVimPresentationMode()

    nnoremap <buffer> <right> :n<cr>
    nnoremap <buffer> <left> :N<cr>

    if !exists('#goyo')
        Goyo
    endif
endfunction

" trailing whitespace, and end-of-lines. Very useful if in a code base that requires it.
" Also highlight all tabs and trailing whitespace characters.
" set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
" set list                            " Show problematic characters.
" NOTE see vim-better-whitespace plugin
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Manually remove whitespace, replace tabs with 4 spaces
nnoremap <leader>w mw:%s/\s\+$//ge<cr>:%s/\t/    /ge<cr>:noh<cr>`w

" TODO: lookup new-filetype and ftdetect and create custom types for glsl hlsl
" FILETYPE filetype
" Associate filetypes with other filetypes
autocmd BufRead,BufNewFile *.asm set filetype=asm
autocmd BufRead,BufNewFile *.shader set filetype=cpp
autocmd BufRead,BufNewFile *.vert   set filetype=cpp
autocmd BufRead,BufNewFile *.frag   set filetype=cpp
autocmd BufRead,BufNewFile *.glsl   set filetype=cpp
autocmd BufRead,BufNewFile *.hlsl   set filetype=cpp
autocmd BufRead,BufNewFile *.md     set filetype=markdown
" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
" add support for comments in json (jsonc format used as configuration for many utilities)
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" TERMINAL, terminal, term, floaterm
" Go to insert mode when switching to a terminal
" Distinguish terminal by making cursor red
let g:floaterm_borderchars=''
let g:floaterm_position='right'
let g:floaterm_width=0.40
let g:floaterm_height=1.0
" let g:floaterm_position='bottom'
" let g:floaterm_width=1.0
" let g:floaterm_height=0.40
nnoremap <silent>   <c-\>   :FloatermToggle<CR>
tnoremap <silent>   <c-\>   <C-\><C-n>:FloatermToggle<CR>
" Esc quits the termial
" NOTE: This is needed to make fzf and other termal based things not annoying
tnoremap <Esc> <C-\><C-n>:q<cr>
tnoremap <C-\> <C-\><C-n>
" To simulate i_CTRL-R in terminal-mode
tnoremap <expr> <c-r> '<c-\><c-n>"'.nr2char(getchar()).'pi'

" No fuss terminal colors
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'
highlight TermCursor ctermfg=red guifg=red
nnoremap <silent>   <c-\>   :FloatermToggle<CR>
" Set main floaterm window's background to black
" Set floaterm main and border to black
set winblend=5 " set all floating windows transparent(0-100)
hi Floaterm guibg=black
hi FloatermBorder guibg=black guifg=black

if has("nvim")
    set inccommand=nosplit " Remove horizontal split that shows a preview of whats changing
endif

" SEARCH
" * and # search does not use smartcase
" see s_flags pattern and substitute.  I is dont ignore case, c is confirm.
" NOTE: vim has a gn text object(next search item), star-search plugin (or vim-slash) combined with cgn and . covers alot of cases
" gv selects the last vis selection (line, block or select), does not work with star select since it selects multiple items
" Problem is it follows smartcase settings
" Even with very no magic (\V) modifier, still need to escape / and \ with \
" see :h escape() (escape the chars in teh second arg with backslash)
" <c-r>=escape() means paste the result of escape(), substitute(), etc.
" The \< and \> means don't do a raw string replace but a word replace (only operate on that string if its a stand-alone word)
" so if you want to replace someVar, it won't touch vars named someVarOther

" NOTE: just use * to grab word, vis select lines with word, then <leader>es
" NOTE: under cursor and phrase search works,i.e. word boundary when word under cursor and larger phrase respecting the \V very no magic
" NOTE: leaving first arg blank in substitute will assume last search i.e. the / register
" edit last search within vis selection
xnoremap <leader>,es :s///gI<left><left><left>
xnoremap <leader>,ew :s/<c-r><c-w>//gI<left><left><left>
" edit last search across whole file
nnoremap <leader>,es :%s///gI<left><left><left>
nnoremap <leader>,ew :%s/<c-r><c-w>//gI<left><left><left>
xmap <expr> <leader>e v:hlsearch ==# 1 ? "<leader>,es" : "<leader>,ew"
nmap <expr> <leader>e v:hlsearch ==# 1 ? "<leader>,es" : "<leader>,ew"

" see "h <expr> and :help mode()
" Make A and I work in vis line mode. They already work in the block bounds so leave that be.
" gv is highlight previous visual selection, `> and `< is jump to end and beg of vis selection
xnoremap <expr> A mode() ==# "V" ? ":norm A" : "A"
xnoremap <expr> I mode() ==# "V" ? ":norm I"  : "I"

" " Move visual selections around
" " NOTE: `[ and `] are last line edit start/end
" xnoremap <a-k> xkP`[V`]
" xnoremap <a-j> xp`[V`]
" nnoremap <a-k> VxkP
" nnoremap <a-j> Vxp
" xnoremap <c-k> x{P`[V`]
" xnoremap <c-j> x}p`[V`]
" " NOTE: for horiz it be nice to find line boundaries or boundary pair first before moving to next space
" xnoremap <c-b> xBP`[v`]
" xnoremap <c-w> xWP`[v`]
" nnoremap <c-b> f<space>vBxBP`[v`]
" nnoremap <c-w> f<space>vBxWP`[v`]

function! MakeAFileAndAddToGit(filename)
    execute 'edit ' . a:filename
    write
    execute 'silent !git add ' . a:filename
    " match .c then 0 or 2 p's then end of line
    " see :h pattern-overview
    let hfile=substitute(a:filename, '\.c[p]\{-,2}$', '.h', '')
    if hfile =~ '\.h$'
        execute 'edit ' . hfile
        write
        execute 'silent !git add ' . hfile
    endif
endfunction
" Additional .h file created when .cpp passed in
nnoremap <leader>mf :call MakeAFileAndAddToGit("")<left><left>

" \v search prefix modifier is very magic, \V prefix modifier very no magic. Only \ and / have meaning and must be escaped with \
nnoremap / /\V
vnoremap / /\V

" I don't wan't to think through vim's 6 different ways to scroll the screen
" Bonus: frees up ctrl e, y, f, b
" For this single scroll setup, it's best to set really fast pollrate (~40 keys/s) and really short delay (~200ms) on the system (this is good to do in general)
noremap <silent> <c-e> <nop>
noremap <silent> <c-y> <nop>
noremap <silent> <c-f> <nop>
" noremap <silent> <c-b> <nop>
noremap <silent> <c-u> 12<c-y>
noremap <silent> <c-d> 12<c-e>

" Just annoying
noremap <silent> R <nop>

" Folds
" zR zM open/close all folds
" zo zc open/close fold

" NOTE: was cause of slowness at one point
" set clipboard+=unnamedplus " To ALWAYS use the system clipboard for ALL operations
xnoremap <c-y> "+y
nnoremap <c-p> "+p

" Some default swaps
noremap J }
noremap K {
noremap { J
noremap } K
" noremap H ^
" noremap L $
" noremap $ L
" noremap ^ H

" Split navigation
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

" quickfix list and local list (local list is local to buffer, i think)
nnoremap <a-c>o :copen<cr>
" nnoremap <a-c>c :cclose<cr>
nnoremap <a-n> :cnext<cr>
nnoremap <a-p> :cprevious<cr>
nnoremap <a-s-c>o :lopen<cr>
" nnoremap <a-s-c>c :lclose<cr>
nnoremap <a-s-n> :lnext<cr>
nnoremap <a-s-p> :lprevious<cr>

" COLORCOLUMN
" CURSORLINE (can be slower in some terminals)
" purple4 black
" You can also specify a color by its RGB (red, green, blue) values.
" The format is "#rrggbb", where
" hi Comment guifg=#11f0c3 guibg=#ff00ff
hi cursorline  gui=NONE guibg=purple4 guifg=NONE
hi cursorcolumn  gui=NONE guibg=purple4 guifg=NONE

" TODO: lookup wincents way of highlighting current window
let g:useCursorline = 1
if g:useCursorline == 1
    set cursorline
    autocmd InsertEnter,WinLeave * setlocal nocursorline
    autocmd InsertLeave,VimEnter,WinEnter * setlocal cursorline | silent! update!
else
    set nocursorline
    autocmd InsertEnter * setlocal cursorline
    autocmd InsertLeave * setlocal nocursorline | silent! update!
endif

" Pressing enter flashes the cursoline and column and removes the search highlight
" Was needed for terminals where the cursor was hard to find where linecoloring
" was slow in normal mode so you had to turn it off
function! Flash()
    silent! update!
    set cursorline cursorcolumn
    redraw
    sleep 30m
    set nocursorcolumn
    if g:useCursorline == 0
        set nocursorline
    endif
endfunction
nnoremap <c-[> :silent! call Flash()<cr>:noh<cr>

" Only hit < or > once to tab indent, can be vis selected and repeated like normal with '.'
nnoremap < <<
nnoremap > >>

" indent scope
nnoremap == =i{<c-o>

" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection, VG to select until end of file
vnoremap Q :norm @q<cr>

" navigate by display lines
nnoremap j gj
nnoremap k gk

" yank to end of line to follow the C and D convention.
nnoremap Y y$

" nvim_win_config
" grow splits horizontally
" Shift left/right doesn't work in terminals?
" use ctrl l,r,u,d for term split resize
" use shft l,r,u,d for gui window resize
nnoremap <c-left>  :vert res -8<cr>
nnoremap <c-right> :vert res +8<cr>
" grow splits vertically
nnoremap <c-down> :res -8<cr>
nnoremap <c-up>   :res +8<cr>

" Source the vimrc so we don't have to refresh
" :e is required to actually pick up vimrc changes
" the M is there to center the mouse cursor other wise the screen will scroll when doing :e
nnoremap <silent> <leader>vs :wa! <bar> so $MYVIMRC <cr> M:e<cr>
" Edit the vimrc in a new tab
nnoremap <silent> <leader>ve :vs ~/.vimrc<cr>
" Diff the current local vimrc against master
nmap <silent> <leader>vd <c-\>cd ~/vim<cr>cp ../.vimrc .<cr>git diff<cr>
" Pull latest vimrc, copy it to vimrc location, source it, restart coc
nmap <silent> <leader>vp <c-\>cd ~/vim<cr>git pull<cr>cp .vimrc ..<cr>cd -<cr><c-[><c-[><leader>vs<c-space>
nnoremap <silent> <leader>qq :wa!<cr>:qa!<cr>


" Fomatting
" Pretty Json
nnoremap <leader>p :%!python -m json.tool<cr>
" NOTE xxd is a linux thing
" convert to hex view
nnoremap <leader>xx :%!xxd<cr>
" undo convert to hex view
nnoremap <leader>xr :%!xxd -r<cr>
" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
nnoremap <leader>um :UnMinify<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf works in the linux terminal:
" cd **<tab> (or fzf's alt-c)
" nvim **<tab> (or fzfs' nvim <c-t>)
" <c-r> (linux reverse command search, fzf picks this up automatically)

" tags <c-]>:
" <c-t> will pop through the tag stack, g<c-]> will list ambiguous tag

" vim's autocomplete:
" good stuff documented in ins-completion
" c-x c-n for just this buffer
" c-x c-f for filenames (need to keep hitting the sequence after every slash)
" c-x c-] for tags only
"
" look up cfdo, quickfix list, location-list, vimgrep lvimgrep
" if vim is launched from terminal ctrl-z will take you back to terminal. fg in terminal will take you back to vim (fg is for foreground)
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
" c-r" to paste from register doublequote when in command/search/terminal
" highlighing lines then doing a :w TEST will write those lines to TEST
" :r TEST will put lines from test at the cursor
" :r !ls will put the result of ls at the cursor
" Re-flow comments by visually selecting it and hit gq
" :qa! quits all without saving
" :wqa! write and quits all
"  with tcomment_vim installed you can comment lines with gc when they are visually selected
" possibly useful nomral mode keys:
" ; will repeat t/T and f/F (line movement to and find) commonds. , will repeat reverse directio direction
" c-w + s,v opens the same buffer in a horiz or vert split
" K will search in man pages for the command under cursor (this has been remapped)
" :sh will open a shell
" di{ to delete method body, can do this with these as well: " ( [ ' <
" daw deletes around(includes white space) word use this instead of db unless you really need db
" :windo diffthis (diff windows in current tab, :diffoff! to turn it off)
" :tab sball -> convert buffers to tabs
" :mks! to save Session.vim in current folder
" :source Session.vim to load its session config
" c-n, c-p tab-like completion pulling from variety of sources (also for prompt navigation, prev, next)
" c-x c-l whole line completion
" c-x c-o syntax aware omnicompletion
" see this for native vim auto complete https://robots.thoughtbot.com/vim-you-complete-me
" clipboard reg 1 yank in word nmode: "1yiw vmode: "1y
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" open prevoius file: <c-6> good for toggling .h and .cpp (can also use fzf's :History command <leader>hh)
" paste in word from reg 1: nmode: viw"1p vmode: "1p
" c-x subtracts 1 from number under curosr c-a adds 1
" zE remove all folds
" [{ ]} will jump to beginning and end of a {} scope
" vip will highlight a block bound by blank lines
" % will jump to (), [], [] on a line

" In the "power of g" how do I do the display context of search across all files in project/pwd to do what sublime does?
" https://vim.fandom.com/wiki/Power_of_g
" gD go to def of word under cursor in current file
" gd go to def of word under cursor in current function
" g; goes to last edited position
" gt (next tab) gT(prev tab) #gt (jump to tab #)
" gf will open file under cursor, <c-w>gf to open file under cursor in a new tab
" :g/^\s*$/d - global delete lines containing regex(blank or whitespace-only lines)
" :g/pattern/d _ - fast delete lines matching pattern
" :g!/error\|warn\|fail/d - opposite of global delete (equivalent to global inverse delete (v//d)) keep the lines containing the regex(error or warn or fail)
" :g/pattern/z#.5|echo "==========" - display context, 5 lines, of pattern
" :g/pattern/t$  - copy all lines matching pattern to the end of the file
" :g/pattern/m$  - move all lines matching pattern to the end of the file
" qaq:g/pattern/y A Copy all lines matching a pattern to register 'a'. qa starts recording a macro to register a, then q stops recording, leaving the 'a' reg empty. y is yank, A is append to register a.
" :g/pattern/normal @q - run macro recorded in q on matching lines

" INSERT MODE:
" c-w   Delete word to the left of cursor
" c-u   Delete everything to the left of cursor
" c-o   Goes to normal mode to execute 1 normal mode command
" c-a   Insert last inserted text
" c-y   Hold down to start repeating text from the line above
" c-r{register}   insert text from register (spit out macro register with <c-r>q, edit it and copy back into register after select with "qy)
" COMMAND MODE:
" ctrl-n, p next previous command in history
" c-f will pop up a buffer of previous command history, you can edit like a normal buffer and hit enter to execute
" c-f will do the same thing for / searching
" c-v  followed by an action key, say delete, will insert <Del>

" COMPLETION:
" c-x c-f filepath completion
" c-x c-o "omni" completion, code aware completion
" c-x c-l line completion
" c-x c-d macro completion
" c-x c-i current and included files
" c-x c-] tags

" [ COMMANDS (The ] key is the forward version of the [ key)
" [ ctrl-i jump to first line in current and included files that contains the word under the cursor
" [ ctrl-d jump to first #define found in current and included files matching the word under cursor
" [/ cursor n times back to start of // comment
" [( cursor n times back to unmatched (
" [{ cursor n times back to unmatched {
" [[ cursor n times back to unmatched [
" [D list all defines found in current and included files matching word under cursor
" [I list all lines found in current and included files matching word under cursor
" [m cursor n times back to start of member function

" REGISTERS
" :reg to list whats in all the registers
" @: uses this register to execute the command again
" Editing macros since they are stored in registers: For example, if you forgot to add a semicolon in the end of that w macro, just do something like :let @W='i;'. Noticed the uppercase W
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

" Jump to tag. / will do fuzzy match
" nnoremap <leader>j :tjump /

" list the buffers and prepare open buffer command
" nnoremap <leader>b :ls<CR>:b<space>

" Bad but might have nugget of good idea
" Bind p in visual mode to paste without overriding the current register
" bad: this will put you back to your previous visual selection which is annoying, need to figure out how to go back to where you pasted
" nnoremap p pgvy
"
" quickfix list
" :copen " Open the quickfix window
" :ccl   " Close it
" :cw    " Open it if there are errors, close it otherwise
" :cn    " Go to the next error in the window
" :cnf   " Go to the first error in the next file
"
" Vim script guide :h usr_41.txt

" arg example
" :args *.c
" :argadd file1 file2 file3
" :argdo %s/\<x_cnt\>/x_counter/gIe | update
" others: windo bufdo cdo cfdo ldo
"
" ctags (use Universal ctags)
" use tagbar or c-] or :tag someTag or <leader>t
" :ptag someTag will open a preview window for the tag and put the cursor back where it was so you can keep typing
" use :pclose to close preview window
"
"If you want to complete system functions you can do something like this.  Use
" ctags to generate a tags file for all the system header files:
"     % ctags -R -f ~/.vim/systags /usr/include /usr/local/include
" In your vimrc file add this tags file to the 'tags' option:
"     set tags+=~/.vim/systags

" :Cfilter some-string to filter the quickfix list, :Cfilter will grab entries not matching some-string
" :Cfilter[!] /{pat}/
" :Lfilter[!] /{pat}/
" packadd cfilter

" Toggle header and source
" :e file:p is full path of file. the :s are a chain of substitutes the , are the sub delimiters
" the X123X is just for putting an X123X extension on it.
" this only works if in the same directory
" nnoremap <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
