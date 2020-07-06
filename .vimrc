" On Windows:
" See personal vim repo for disable capslock reg file for windows 10, double click to merge it then restart.
" Use bash by typing "bash" in any of the terminals and avoid all the pointless headaches.
" bash will use wsl/ubuntu (i think) on /mnt/c/
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

set textwidth=80
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
" local cd (change for current vim 'window') to current file's dir (% is file name :p expands to full path :h takes the head)
nnoremap <leader>cd :lcd %:p:h <bar> pwd <cr>

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
" ========================================================
command! CTags !ctags -R --c++-kinds=+pl --fields=+iaS --extras=+q --exclude='build/**' --exclude='node_modules/**' --exclude='data/**' --exclude='bin/**' --exclude='*.json' .
" nnoremap <leader>ct :cd %:p:h <bar> CTags<cr>
nnoremap <leader>ct :CTags<cr>

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

" notify if file changed outside of vim to avoid multiple versions
autocmd FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

" Tell vim to use ripgrep as its grep program
set grepprg=rg\ --vimgrep\ --glob\ !tags

let baseDataFolder="~/.vim"
call plug#begin(baseDataFolder . '/bundle') " Arg specifies plugin install dir

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Jump to buffer if open
let g:fzf_buffers_jump = 1
" disable preview window
let g:fzf_preview_window = ''
" fzf using skim
" Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
" command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
" choco install ripgrep fd fzf
" USE FD https://github.com/sharkdp/fd
" put in .bashrc for fd/other things
"in your ~/.bashrc, or somthing like 6:37 of https://www.youtube.com/watch?v=qgG5Jhi_Els
" export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
" export FZF_DEFAULT_COMMAND="fd --type file"
" export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

" Better fzf :Colors command.
" command! -bang Colors call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 1%,0'}, <bang>0)

" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)
" nnoremap <leader>gm :Rg!<cr>
" " These are like the ack versions (which use Rg) but have previews of the results.
" nnoremap <leader>gw :Rg! <c-r><c-w><cr>
" " TODO: need to escape some special chars for ripgrep like ( and { etc.
" nnoremap <leader>gs :Rg! <c-r>=substitute(substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\/', '/', 'g'), '\\n$', '', 'g'), '\*', '\\\\*', 'g'), '\\<', '', 'g'), '\\>', '', 'g')<cr><cr>
" nnoremap <leader>gy :Rg! <c-r>=substitute(substitute(substitute(@", '\\/', '/', 'g'), '\\n$', '', 'g'), '\*', '\\\\*', 'g')<cr><cr>
" These two are for flippling between dec hex oct bin
" magnum is just a dependency of radical
" Plug 'glts/vim-magnum'
" Plug 'glts/vim-radical'

Plug 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

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
Plug 'itchyny/vim-qfedit'

" mapping nomenclature: e is edit, a is ack, r is replace, s is search, m is manual, w is word, y is yank
" NOTE: use word versions(aw, rw) if doing var name changes
command! -nargs=+ MyGrep execute 'let @a = <args>' | mark A | execute 'silent grep! "' . @a . '"' | bot cw 20
command! -nargs=+ MyCdo execute 'silent cdo! <args>' | cdo update | cclose | execute 'normal! `A'
nmap <leader>as :MyGrep "<c-r>=substitute(substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\/', '/', 'g'), '\\n$', '', 'g'), '\*', '\\\\*', 'g'), '\\<', '', 'g'), '\\>', '', 'g')<cr>"<cr>
nmap <leader>am :MyGrep ""<left>
nmap <leader>aw :MyGrep "<c-r><c-w>"<cr>
" nmap <leader>ay :MyGrep "<c-r>=substitute(substitute(substitute(@", '\\/', '/', 'g'), '\\n$', '', 'g'), '\*', '\\\\*', 'g')<cr>"<cr>
" NOTE: bug with rr where if item is also a substring of the new version it
" will get n substitions where n is occurance count in quickfix window.
" example old: jawn, new: m_jawn, output: m_m_m_m_jawn
" nmap <leader>rr :MyCdo %s/<c-r>=escape(@a, '/\\')<cr>//gIe<left><left><left><left>
" nmap <leader>rr :MyCdo %s/<c-r>a//gIe<left><left><left><left>
nmap <leader>rs :MyCdo %s/<c-r>=substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g')<cr>//gIe<left><left><left><left>
nmap <leader>rm :MyCdo %s/gIe<left><left><left>
nmap <leader>rw :MyCdo %s/<c-r><c-w>//gIe<left><left><left><left>
" nmap <leader>ry :MyCdo %s/<c-r>=escape(@", '/\\')<cr>//gIe<left><left><left><left>

" " using range-aware function
" function! QFdelete() range
"     " get current qflist
"     let l:qfl = getqflist()
"     " no need for filter() and such; just drop the items in range
"     call remove(l:qfl, a:firstline - 1, a:lastline - 1)
"     " replace items in the current list, do not make a new copy of it;
"     " this also preserves the list title
"     call setqflist([], 'r', {'items': l:qfl})
"    " restore current line
"    call cursor(a:firstline, 1)
" endfunction
" " using buffer-local mappings
" " note: still have to check &bt value to filter out `:e quickfix` and such
" augroup QFList | au!
"     autocmd BufWinEnter quickfix if &bt ==# 'quickfix'
"     autocmd BufWinEnter quickfix    nnoremap <silent><buffer>dd :call QFdelete()<CR>
"     autocmd BufWinEnter quickfix    vnoremap <silent><buffer>d  :call QFdelete()<CR>
"     autocmd BufWinEnter quickfix endif
" augroup end

" Syntax for js ts react ect. comes before polyglot
Plug 'maxmellon/vim-jsx-pretty'

" Syntax highlighting for a ton of languages
Plug 'sheerun/vim-polyglot'
" if using polyglot and vim-jsx-pretty
let g:polyglot_disabled = ['jsx']

" :StartupTime to see a graph of startup timings
Plug 'dstein64/vim-startuptime'

" " WIndows key repeat rate: https://ludditus.com/2016/07/15/microsoft-the-keyboard-repeat-rate-and-sleeping-how-to-work-around-their-idiocy/
" " linux search keyboard set to 200ms delay, 40c/s
Plug 'vim-airline/vim-airline' " see 'powerline/fonts' for font installation 'sudo apt install fonts-powerline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#gutentags#enabled = 1
let g:airline_theme='ayu_dark'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#branch#format = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t' " Just display filename
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#ignore_bufadd_pat = 'goyo|gundo|undotree|vimfiler|tagbar|nerd_tree|startify|!|term\:'
let g:airline_section_a = '' " mode.
let g:airline_section_c = '' " filename is already in the airline tabline
let g:airline_section_x = '' " (tagbar, filetype, virtualenv).
let g:airline_section_y = '' " (fileencoding, fileformat)
let g:airline_section_z = '' " (percentage, line number, column number)

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
" https://github.com/autozimu/LanguageClient-neovim/wiki/Recommended-Settings
" another lang server for c: https://github.com/MaskRay/ccls
" worth looking at?: nvim-gdb
" https://github.com/neoclide/coc.nvim
" https://vim.fandom.com/wiki/Using_vim_as_an_IDE_all_in_one
" https://vim.fandom.com/wiki/Omni_completion

" :checkhealth to see if running
" Useful commands CocConfig, CocInfo, CocInstall, CocUninstall, CocList, CocCommand
" For c based langs, use clangd (choco install llvm then :CocConfig and paste the json settings from coc.nvim github wiki)
" `CocList marketplace` to see things you can CocInstall
" "CocInstall coc-tsserver coc-eslint coc-json coc-html coc-css coc-sh coc-clangd coc-rls coc-syntax coc-tag
" "CocCommand <tab>
" :CocConfig will edit the config file where you put languageservers usually lives here ~/.config/nvim/coc-settings.json

" Install clang/clangd with: choco install llvm
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" NOTE: look here for example .vimrc: https://github.com/neoclide/coc.nvim#example-vim-configuration
" <cr> confirm, need this for filling selecting  method signature from the list
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use c-j (back) and c-k (forward) to jump to args pulled method signature
" use j and k to navigate list, use p to toggle preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> gk :call <SID>show_documentation()<CR>
nnoremap <buffer> gd <Plug>(coc-definition)
nnoremap <buffer> gr <Plug>(coc-references)
" nnoremap <buffer> gt <Plug>(coc-type-definition)
" nnoremap <buffer> gi <Plug>(coc-implementation)
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <buffer> <c-space> :CocRestart<cr>

" " 0.5.0 nightly nvim-lsp
" " relevant plugins
" Plug 'neovim/nvim-lsp'
" Plug 'nvim-lua/completion-nvim'
" Plug 'nvim-lua/diagnostic-nvim'

" " Type s and a char of interesst then the colored letters at the char to jump to it.
" Plug 'easymotion/vim-easymotion'
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" let g:EasyMotion_use_upper = 1
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_keys =   'ASDGHKLQWERTYUIOPZXCVBNMFJ;' " should sort from easy to hard (left to right)
" " This will search before and after cursor in current pane
" nmap s <Plug>(easymotion-s)
" nnoremap S <nop>
" NOTE: conflicts with surround

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

" gcc toggles line
" gc on selection to toggle
" gcip gci{ etc. will toggle within those motions
Plug 'tomtom/tcomment_vim'
" Prevent tcomment from making a zillion mappings (we just want the gc operator).
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''
let g:tcomment_mapleader_comment_anyway=''
let g:tcomment_textobject_inlinecomment=''

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
nnoremap <a-o> :call ToggleAndKillOldBuffer()<CR>

" see https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" There was a comment about making sure .viminfo is read/write
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

 " Can target next(n) and last(l) text object. Adds new delimiter pairs and can target function args with a.
 " Ex: dina cila vina function(cow, mouse, pig) |asdf|asdf| [thing 1] [thing  2]
" d2ina skips an arg and deletes the next one
Plug 'wellle/targets.vim'

" Colorschemes
set t_Co=256
Plug 'AlessandroYorba/Alduin'
" Plug 'AlessandroYorba/Despacio'
" gruvbox
" COLORSCHEME must come before whitespace highlighting and other color alterations
colorscheme alduin2

call plug#end()

" " nvim-lsp ----------------------------------------
" " lsp specific config
" " NOTE: need to do :LspInstall for each of these
" lua << EOF
"   require'nvim_lsp'.vimls.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.clangd.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.tsserver.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.jsonls.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.cmake.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.html.setup{on_attach=require'completion'.on_attach}
"   require'nvim_lsp'.bashls.setup{on_attach=require'completion'.on_attach}
" EOF
" function! LSPRename()
"     let s:newName = input('Enter new name: ', expand('<cword>'))
"     echom "s:newName = " . s:newName
"     lua vim.lsp.buf.rename(s:newName)
" endfunction
" function! LSPSetMappings()
"     setlocal omnifunc=v:lua.vim.lsp.omnifunc
"     nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"     nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"     nnoremap <silent> <buffer> <leader>k     <cmd>lua vim.lsp.buf.hover()<CR>
"     nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"     nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"     nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"     nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
"     nnoremap <silent> <buffer> <F2> :call LSPRename()<CR>
" endfunction
" au FileType lua,sh,c,cpp,json,js,html,cmake,viml :call LSPSetMappings()
" " completion-nvim -----------------------------
" " Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
" " Set completeopt to have a better completion experience within completion-nvim
" set completeopt=menuone,noinsert,noselect
" " nvim-lsp ----------------------------------------

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

" FILETYPE
" Associate filetypes with other filetypes
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

" Terminal colors
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
" see s_flags pattern and substitute. /I forces case-sensitive matching
" NOTE: vim has a gn text object(next search item), star-search plugin (or vim-slash) combined with cgn and . covers alot of cases
" Problem is it follows smartcase settings
" E means edit with confirms, e is no confirm.
" Second letter is source: w is word under cursor, y is yanked text.
" Even with very no magic (\V) modifier, still need to escape / and \ with \
" The \< and \> means don't do a raw string replace but a word replace (only operate on that string if its a stand-alone word)
" so if you want to replace someVar, it won't touch vars name someVarOther
" edit word in whole file
nnoremap <leader>ew :%s/\V\<<c-r><c-w>\>//gI \|normal <c-o><c-left><c-left><left><left><left><left>
" Edit confirm word in whole file
nnoremap <leader>Ew :,$s/\V\<<c-r><c-w>\>//gIc \|1,''-&&<c-left><left><left><left><left><left>
" edit word under cursor within the visual lines
" gv selects the last vis selection (line, block or select)
vnoremap <leader>ew <Esc>yiwgv:s/\V\<<c-r>"\>//gI \| normal <c-left><c-left><left><left><left><left>
" Visually selected text in file
" If mode is visual line mode, edit the prev yank acros the vis lines, else across the whole file
" see :h escape() (escape the chars in teh second arg with backslash)
" c-r=escape() means paste in the result of escape
" vnoremap <expr> <leader>ey mode() ==# "V" ?
"       \ ":s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"
"       \: "y:%s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"
" Whole file edit yank (E version being with confim)
" nnoremap <leader>ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gI <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left>
" nnoremap <leader>Ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gIc <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left><left>
" Visual lines or visual select edit-last-search, 4 backslashes since we are in a "" and to insert a \ into "" you need \\
" and to get the \\ in a '' from a "" you need 4.
" NOTE: the w and y versions are never used in practice since * is used
" to see whats there and V to select the ones that need to change
vnoremap <expr> <leader>es mode() ==# "V" ?
      \ ":s/\\V<c-r>=substitute(substitute(@/, '\\\\V', '', 'g'), '\\\\n$', '', '')<cr>//gI \| normal <c-left><c-left><left><left><left><left>"
      \: ""
" Whole file edit last search(E version being with confim). Get rid of teh extre \V then get rid of any ending \n
nnoremap <leader>es :%s/\V<c-r>=substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', '')<cr>//gI <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left>
nnoremap <leader>Es :%s/\V<c-r>=substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', '')<cr>//gIc <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left><left>

" see "h <expr> and :help mode()
" Make A and I work in vis line mode. They already work in the block bounds so leave that be.
" gv is highlight previous visual selection, `> and `< is jump to end and beg of vis selection
xnoremap <expr> A mode() ==# "V" ? ":norm A" : "A"
xnoremap <expr> I mode() ==# "V" ? ":norm I"  : "I"

" " see :h mode() or :h visualmode()
" " \e is <esc> (can also use <esc> too), see pattern-atoms
" " `> and `< is jump to end and beg of vis selection
" " xno is xnoremap
" xnoremap s <nop>
" xnoremap S <nop>
" nnoremap s <nop>
" nnoremap S <nop>
" xno <expr> S{ {
" \  'v': "\e`>a}\e`<i{\e",
" \  'V': "\e`>o}\e`<O{\eva{=",
" \ }[mode()]
" xno <expr> S[ {
" \  'v': "\e`>a]\e`<i[\e",
" \  'V': "\e`>o]\e`<O[\eva[=",
" \ }[mode()]
" xno <expr> S( {
" \  'v': "\e`>a)\e`<i(\e",
" \  'V': "\e`>o)\e`<O(\eva(=",
" \ }[mode()]
" xno <expr> S< {
" \  'v': "\e`>a>\e`<i<\e",
" \  'V': "\e`>o>\e`<O<\eva<=",
" \ }[mode()]
" xno <expr> S' {
" \  'v': "\e`>a'\e`<i'\e",
" \  'V': "\e`>o'\e`<O'\eva'=",
" \ }[mode()]
" xno <expr> S" {
" \  'v': "\e`>a\"\e`<i\"\e",
" \  'V': "\e`>o\"\e`<O\"\eva\"=",
" \ }[mode()]
" xno <expr> S` {
" \  'v': "\e`>a`\e`<i`\e",
" \  'V': "\e`>o```\e`<O```\eva`=",
" \ }[mode()]
"
" " Every line beg and end gets wrapped with the pair
" xno <expr> s{ {
" \  'V': "<c-v>^I{\egvV<c-v>$A}\e",
" \  '<c-v>': "A}\egvI{\e",
" \ }[mode()]
" xno <expr> s[ {
" \  'V': "<c-v>^I[<esc>gvV<c-v>$A]<esc>",
" \  '<c-v>': "A]\egvI[\e",
" \ }[mode()]
" xno <expr> s( {
" \  'V': "<c-v>^I(<esc>gvV<c-v>$A)<esc>",
" \  '<c-v>': "A)\egvI(\e",
" \ }[mode()]
" xno <expr> s< {
" \  'V': "<c-v>^I<<esc>gvV<c-v>$A><esc>",
" \  '<c-v>': "A>\egvI<\e",
" \ }[mode()]
" xno <expr> s` {
" \  'V': "<c-v>^I`<esc>gvV<c-v>$A`<esc>",
" \  '<c-v>': "A`\egvI`\e",
" \ }[mode()]
" xno <expr> s' {
" \  'V': "<c-v>^I'<esc>gvV<c-v>$A'<esc>",
" \  '<c-v>': "A'\egvI'\e",
" \ }[mode()]
" xno <expr> s" {
" \  'V': "<c-v>^I\"<esc>gvV<c-v>$A\"<esc>",
" \  '<c-v>': "A\"\egvI\"\e",
" \ }[mode()]

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
    nnoremap <s-left> :set columns-=8<cr>
    nnoremap <s-right> :set columns+=8<cr>
    " grow window vertically
    nnoremap <s-down> :set lines-=8<cr>
    nnoremap <s-up> :set lines+=8<cr>
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
noremap <silent> <c-e> <nop>
noremap <silent> <c-y> <nop>
" NOTE: cause of slowness on 0.5.0 nvim nightly:
" set clipboard+=unnamedplus " To ALWAYS use the system clipboard for ALL operations
xnoremap <c-y> "+y
noremap <silent> <c-f> <nop>
noremap <silent> <c-b> <nop>
noremap <silent> <c-u> 10<c-y>
noremap <silent> <c-d> 10<c-e>

noremap J }
noremap K {
noremap { J
noremap } K
" noremap H ^
" noremap L $
" noremap $ <nop>
" noremap ^ <nop>
" noremap <a-j> L
" noremap <a-k> H
" noremap <a-m> M

" split nav
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

" " airline removes term from tabline but must still skip it
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
" " Cycle tabs in tab bar
nnoremap <silent> <a-h> :call BufferPrev()<cr>
nnoremap <silent> <a-l> :call BufferNext()<cr>
" " kill buffer tab
" nnoremap <silent> <c-q> :silent! up! <bar> silent! bp! <bar> silent! bd! #<cr>
nnoremap <silent> <c-q> :silent! up! <bar> silent! bd! <bar> call BufferNext() <cr>

" " Toggle between header and source for c/cpp files
" if has("gui_running") || has("nvim")
"   " " alt-A will move the current tab to the left
"   " nnoremap <A-A> :tabm -1<cr>
"   " " alt-D will go to next right tab
"   " nnoremap <A-D> :tabm +1<cr>
" else
"   " NOTE: Escape mappings will cause delay in vim terminal
"   " In terminal vi, the alt+a and alt+d keys are actually ^[a and ^[d
"   " You can see this by typing the key sequence in a command line after doing a
"   " cat followed by enter or sed -n l followed by enter
"   " If you type alt-a after that the output will be something like ^[a which is <escape> a
"   " if not terminal winodw this would just be noremap <a-a> gT
"   " alt-a will go to next left tab
"   " Bad to have Esc mappings avoid Alt key since terminal commonly maps Alt to Esc
" endif

" COLORCOLUMN
" CURSORLINE (can be slower in some terminals)

" purple4 royalblue4 black
" You can also specify a color by its RGB (red, green, blue) values.
" The format is "#rrggbb", where
" :highlight Comment guifg=#11f0c3 guibg=#ff00ff
" hi CursorLine  cterm=NONE ctermbg=royalblue4 ctermfg=NONE
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

" Remove whitespace replace tabs with spaces
nnoremap <leader>w mw:%s/\s\+$//e <bar> %s/\t/    /ge<cr>`w`w

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

" yank to end of line to follow the C and D convention. vim is terrible
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

" Source the vimrc so we don't have to refresh, edit the vimrc in new tab
nmap <silent> <leader>vs :so ~/.vimrc<cr>
nmap <silent> <leader>ve :vs ~/.vimrc<cr>
nnoremap <silent> <leader>qq :wa!<cr>:qa!<cr>

" Useful but better to use the visual select search and repace mappings that I setup (<leader> ey Ey ew Ew)
" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
" vnoremap <silent> s //e<c-r>=&selection=='exclusive'?'+1':''<cr><cr>
"             \:<c-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
" onoremap s :normal vs<cr>

" Pretty Json
nnoremap <leader>p :%!python -m json.tool<cr>
" NOTE xxd is a linux thing
" convert to hex view
nnoremap <leader>xx :%!xxd<cr>
" undo convert to hex view
nnoremap <leader>xr :%!xxd -r<cr>

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
"
" COMPLETION:
" c-x c-f filepath completion
" c-x c-o "omni" completion, code aware completion
" c-x c-l line completion
" c-x c-d macro completion
" c-x c-i current and included files
" c-x c-] tags
" c-x c-v vim command line (hitting delete will insert <Del>)
" :iab ad advertisement (insert abbreviation: when I type ad<space> it puts advertisement)

" [ COMMANDS (The ] key is the forward version of the [ key)
" [ ctrl-i jump to first line in current and included files that contains the word under the cursor
" [ ctrl-d jump to first #define found in current and included files matching the word under cursor
" [/ cursor n times back to start of // comment
" [( cursor n times back to unmatched (
" [{ cursor n times back to unmatched {
" [[ cursor n times back to unmatched [
" [D list all defines found in current and lincluded files matching word under cursor
" [I list all lines found in current and lincluded files matching word under cursor
" [m cursor n times back to start of member function
" gD go to def of word under cursor in current file
" gd go to def of word under cursor in current function
" g; goes to last edited position

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
" 	% ctags -R -f ~/.vim/systags /usr/include /usr/local/include
" In your vimrc file add this tags file to the 'tags' option:
" 	set tags+=~/.vim/systags

" :Cfilter some-string to filter the quickfix list, :Cfilter will grab entries not matching some-string
" :Cfilter[!] /{pat}/
" :Lfilter[!] /{pat}/
" packadd cfilter

" Toggle header and source
" :e file:p is full path of file. the :s are a chain of substitutes the , are the sub delimiters
" the X123X is just for putting an X123X extension on it.
" this only works if in the same directory
" nnoremap <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<cr>
