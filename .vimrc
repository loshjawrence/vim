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
" nnoremap <leader>ct :cd %:p:h <bar> CTags<cr>
nnoremap <leader>ct :CTags<cr>

" notify if file changed outside of vim to avoid multiple versions
autocmd FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

" Tell vim to use ripgrep as its grep program
" NOTE: --sort path can be used to get consistent order, it will run with 1 thread.
set grepprg=rg\ --vimgrep\ --glob\ !tags

let baseDataFolder="~/.vim"
call plug#begin(baseDataFolder . '/bundle') " Arg specifies plugin install dir

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Jump to buffer if open
let g:fzf_buffers_jump = 1
" disable preview window
let g:fzf_preview_window = ''
" Allow passing other args to Rg command
" Example, :Rg '#include "Shader.h"' -g "*{.cpp,.h}"
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
" choco install ripgrep fd fzf
" USE FD https://github.com/sharkdp/fd
" put in .bashrc for fd/other things
"in your ~/.bashrc, or somthing like 6:37 of https://www.youtube.com/watch?v=qgG5Jhi_Els
" see .bashrc in personal vim repo

" These two are for flippling between dec hex oct bin
" magnum is just a dependency of radical
" Plug 'glts/vim-magnum'
" Plug 'glts/vim-radical'

Plug 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

Plug 'majutsushi/tagbar'
nnoremap <F8> :TagbarToggle<CR>

" fzf plugin shortcuts :Marks :Tags :Buffers :History :History: :History/ :Files :Rg :GFiles :Windows
" files in `git ls-files``
nnoremap <leader>f :GFiles<cr>
" all files under pwd (recursive)
nnoremap <leader>F :Files<cr>
" tags in open buffers
nnoremap <leader>t :BTags<cr>
" all tags (pulled from ctags i think)
nnoremap <leader>T :Tags<cr>
" Don't really need this with buffers-as-tabs setup
nnoremap <leader>b :Buffers<cr>

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
let g:EasyMotion_keys =   'ASDGHKLQWERTYUIOPZXCVBNMFJ;' " should sort from easy to hard (left to right)
" This will search before and after cursor in current pane
nmap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)
nnoremap S <nop>

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
Plug 'anott03/nvim-lspinstall'
" lspconfig got rid of :LspInstall so you need anott03's plugin
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" :TSInstallInfo lists all the languages
" :TSInstall c cpp bash lua typescript html c_sharp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" No forward jump, Can search visual selections.
Plug 'vim-scripts/star-search'

" Only use this for Ttoggle (term toggle)
Plug 'kassio/neoterm'
let g:neoterm_autojump = 1
let g:neoterm_autoinsert = 1
let g:neoterm_size = 40

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
colorscheme alduin2

Plug 'sheerun/vim-polyglot'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'akinsho/nvim-bufferline.lua'
call plug#end()

" NOTE: Must go after plug#end()
lua require'colorizer'.setup()
:lua << EOF
require'bufferline'.setup{
    -- override some options from their defaults
    options = {
        tab_size = 10,
        show_buffer_close_icons = false,
    };
}
EOF

" Add the terminal to unlisted buffers so that buffer line doesnt show it
" NOTE: Tried all the Buf* stuff but only this one seemed to work
" and so it only gets removed from buffer line when you leave the terminal
autocmd BufLeave bash* setlocal nobuflisted

" These commands will honor the custom ordering
" if you change the order of buffers the vim commands :bnext and :bprevious
" will not respect the custom ordering
nnoremap <silent><a-l> :BufferLineCycleNext<CR>
nnoremap <silent><a-h> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline
nnoremap <silent><a-s-l> :BufferLineMoveNext<CR>
nnoremap <silent><a-s-h> :BufferLineMovePrev<CR>

" kill buffer tab
nnoremap <silent> <a-q> :silent! up! <bar> silent! bd! <bar> call BufferLineCycleNext() <cr>

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
command! -nargs=+ MyCdo execute 'silent cfdo! <args>' | cfdo update | cclose | execute 'normal! `A'
nnoremap <leader>as :MyGrep "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
nnoremap <leader>am :MyGrep ""<left>
nnoremap <leader>aw :let @w = "<c-r><c-w>" <bar> MyGrep "<c-r><c-w>" "-w"<cr>
" NOTE: rg's idea of word boundary is different from vim.
" But <leader>rs command will not remove vim word boundary regex from the / register if it's there
" things around the word if you * searched it. similar for rw if done in the quickfix window over your word.
" :h cword
" :h s_flags (I is dont ignore, e is continue on error, g is all instances on line, c is confirm)
" when doing something like :s//red/ the first arg is assumed to be previous search
nnoremap <leader>rs :MyCdo %s/<c-r>=substitute(substitute(@/, '\\n$', '', 'g'), '/', '\\/', 'g')<cr>//gIe<left><left><left><left>
nnoremap <leader>rm :MyCdo %s/\VgIe<left><left><left>
" To be used with <leader>aw as it saves word under cursor to w register
nnoremap <leader>rw :MyCdo %s/\V\<<c-r>w\>//gIe<left><left><left><left>

" " nvim-lsp NOTE: This must go after plug section ----------------------------------------
set completeopt=menuone,noinsert,noselect
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ''
let g:completion_matching_smart_case = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

command! Format execute 'lua vim.lsp.buf.formatting()'

:lua << EOF
  require'nvim-treesitter.configs'.setup {
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "c", "cpp", 'bash', "lua", "typescript", "html", },
    highlight = {
      enable = true,
    },
  }

  local nvim_lsp = require('lspconfig')
  local on_attach_custom = function(_, bufnr)
    require('completion').on_attach()
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap=true, silent=true }
    local cbufn = vim.api.nvim_exec('echo bufnr("%")', true)

    -- see :h lsp
    -- see: https://github.com/nanotee/nvim-lua-guide
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ky', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ki', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kI', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kH', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ka', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kA', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kl', '<cmd>lua vim.lsp.buf.list_workspace_folders()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.get_all()<CR>', opts)

    -- NOTE: this can work (i.e. doesnt matter what dir you are in or what files are opened)
    -- but sometimes doesnt work on things you cant leader>kd on (not sure what causes it to fail)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-K>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>kk', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ds', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua vim.lsp.diagnostic.clear(' .. cbufn .. ')<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-space>', '<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr><cmd>edit<cr>', opts)
  end

  -- NOTE: you can install some language servers with :LspInstall <lsp name, i.e. name in local servers>
  -- see https://github.com/neovim/nvim-lspconfig#configurations
  -- vimls, ccsl
  local servers = {'jsonls', 'clangd', 'tsserver', 'html', 'bashls', 'sumneko_lua', 'cmake'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach_custom,
    }
  end
EOF
" nvim-lsp ----------------------------------------

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
xnoremap <leader>es :s///gI<left><left><left>
" edit last search across whole file
nnoremap <leader>es :%s///gI<left><left><left>

" see "h <expr> and :help mode()
" Make A and I work in vis line mode. They already work in the block bounds so leave that be.
" gv is highlight previous visual selection, `> and `< is jump to end and beg of vis selection
xnoremap <expr> A mode() ==# "V" ? ":norm A" : "A"
xnoremap <expr> I mode() ==# "V" ? ":norm I"  : "I"

" Move visual selections around
" NOTE: `[ and `] are last line edit start/end
xnoremap <a-k> xkP`[V`]
xnoremap <a-j> xp`[V`]
nnoremap <a-k> VxkP
nnoremap <a-j> Vxp
xnoremap <c-k> x{P`[V`]
xnoremap <c-j> x}p`[V`]
" NOTE: for horiz it be nice to find line boundaries or boundary pair first before moving to next space
xnoremap <c-b> xBP`[v`]
xnoremap <c-w> xWP`[v`]
nnoremap <c-b> f<space>vBxBP`[v`]
nnoremap <c-w> f<space>vBxWP`[v`]

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

if has("win32") && has("gui_running")
    " Resize window
    set lines=999
    set columns=255
    " Grow active split horizontally
    nnoremap <s-left> :set columns-=8<cr>
    nnoremap <s-right> :set columns+=8<cr>
    " Grow active split vertically
    nnoremap <s-down> :set lines-=8<cr>
    nnoremap <s-up> :set lines+=8<cr>
endif

" I don't wan't to think through vim's 6 different ways to scroll the screen
" Bonus: frees up ctrl e, y, f, b
" For this single scroll setup, it's best to set really fast pollrate (~40 keys/s) and really short delay (~200ms) on the system (this is good to do in general)
noremap <silent> <c-e> <nop>
noremap <silent> <c-y> <nop>
noremap <silent> <c-f> <nop>
" noremap <silent> <c-b> <nop>
noremap <silent> <c-u> 12<c-y>
noremap <silent> <c-d> 12<c-e>

" NOTE: was cause of slowness at one point
set clipboard+=unnamedplus " To ALWAYS use the system clipboard for ALL operations
" xnoremap <c-y> "+y
" nnoremap <c-p> "+p

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

" TERMINAL
" Go to insert mode when switching to a terminal
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
nnoremap <silent> <leader>vs :wa! <bar> so $MYVIMRC <bar> e<cr>
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
" qaq:g/pattern/y A Copy all lines matching a pattern to register 'a'. qa starts recording a macro to register a, then q stops recording, leaving a empty. y is yank, A is append to register a.
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
