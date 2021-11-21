" I am $MYVIMRC for nvim
" Put me in ~/.config/nvim/ on linux and ~\AppData\Local\nvim\ on windows
" make sure colors bundle autoload and all that is in those folders
" On Windows:
" See repo for disable capslock reg file for windows 10, double click to merge it then restart your computer.
" Windows key repeat rate: https://ludditus.com/2016/07/15/microsoft-the-keyboard-repeat-rate-and-sleeping-how-to-work-around-their-idiocy/
" linux search keyboard set to 200ms delay, 40c/s

let mapleader="\<space>" " Map the leader key to space bar

call plug#begin()

""""""""""""""""""""""""""""""""""""""""
""""""""""""""" FZF """"""""""""""""""""
""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Jump to buffer if open
let g:fzf_buffers_jump = 1
" disable preview window with '' set it to right with 'right'
let g:fzf_preview_window = ''
" Allow passing other args to Rg command
" Example, :Rg '#include "Shader.h"' -g "*{.cpp,.h}"
command! -bang -nargs=* Rg call fzf#vim#grep("rg -S --path-separator / ".shellescape(<q-args>), 0, fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)
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

" History looks up v:oldfiles
nnoremap <leader>fh :History<cr>
nnoremap <leader>fm :Marks<cr>
nnoremap <leader>fb :Buffers<cr>

" :MardownPreviewToggle to open/close webpage of preview
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'sjl/gundo.vim'
nnoremap <f1> :GundoToggle<CR>

Plug 'majutsushi/tagbar'
nnoremap <f2> :TagbarToggle<CR>

" try to combine with nvim-tree ability to create/delete files and directories
Plug 'tpope/vim-fugitive'
" :Gdiffsplit        - show git diff for file or provide a file or commit as an arg (newer version is on right or bottom)
"                         - do will obtain theirs (other buffer)
"                         - dp will put ours (current buffer)
" :Gdiffsplit!       - used for merge conflict?
" :Gread             - git checkout -- on this file.
" :Gwrite            - git add the file. stage it otherwise.
" :GRename           - git mv this file to path relative to the file
" :GDelete!          - git rm -f this file
" :GRemove           - git rm --cached (keeps the file around)
" :[range]Gclog      - wow. vis something :Gclog for quckfix of commits relating to selected code will load up diff of the file for that commit
" G                  - place to stage and unstage files
"                    - '-' toggle stage status
"                    - U unstage all
"                    - X checkout file (a command is echoed to undo this see :messages to see again)
"                    - = toggle diff fold
" :G blame           - A vertical window on left showing commit hashes. Can walk backwards through git commits to follow history of changes with <cr> for patch or - to load up file at commit and rerun G blame.
" :G difftool        - quickfix of line changes in the current file
" :G diff            - open a split and show the normal git diff but for only this file
" :Gclog or G log    - like fzf's :Commits - open quickfix or split of commit hashes and their messages, press enter to open a buffer showing its patch diff.
"
" Gcd is cd relative to the repo root. So this would be cd to repo root.
nnoremap <leader>cr :Gcd<cr>
" see https://stackoverflow.com/questions/1269603/to-switch-from-vertical-split-to-horizontal-split-fast-in-vim
nnoremap <leader>gg :G<cr><c-w>H

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
" When ctrl-v selected:
" S{  This means surround selected block edges with { (open and closed brackets above and below the lines)

" Framework for enabling repeat command on plugin commands
" The plugin itself must explicitly support it though
Plug 'jiangmiao/auto-pairs'
" add more pairs, first line is default
let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '<':'>' }
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

Plug 'vim-scripts/star-search'

Plug 'phaazon/hop.nvim'
nnoremap s <cmd>HopChar1<cr>
xnoremap s <cmd>HopChar1<cr>
nnoremap S <nop>

" " LSP for code completion options:
" " CMAKE:
" " set (CMAKE_EXPORT_COMPILE_COMMANDS ON)
" " This will spit out a compile_commands.json in the /build dir.
" " Would need to copy this file to the root dir
" " worth looking at?: nvim-gdb
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-compe'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-nvim-lua'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'saadparwaiz1/cmp_luasnip'
Plug 'ray-x/lsp_signature.nvim'

" :TSInstallInfo lists all the languages
" :TSInstall c cpp bash lua typescript html c_sharp
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'nvim-treesitter/nvim-treesitter-refactor'

" " Buffers as tabs setup
Plug 'akinsho/nvim-bufferline.lua'

Plug 'voldikss/vim-floaterm'

Plug 'tomtom/tcomment_vim'
" gcc toggles line
" gc on selection to toggle
" gcip gci{ etc. will toggle within those motions
" Prevent tcomment from making a zillion mappings (we just want the gc operator).
let g:tcomment_mapleader1=''
let g:tcomment_mapleader2=''
let g:tcomment_mapleader_comment_anyway=''
let g:tcomment_textobject_inlinecomment=''

" Can target next(n) and last(l) text object. Adds new delimiter pairs and can target function args with a.
" Ex: dina cila vina function(cow, mouse, pig) |asdf|asdf| [thing 1] [thing  2]
" d2ina skips an arg and deletes the next one
Plug 'wellle/targets.vim'

" Colorschemes
" COLORSCHEME must come before whitespace highlighting and other color alterations
" Linux: ~/.config/nvim/colors
" Windows: %UserProfile%\AppData\Local\nvim\colors
set t_Co=256
Plug 'AlessandroYorba/Alduin'
" diff from alduin: no baby blue on members, hlsearch is salmon instead of grey
colorscheme alduin2
" Decent default scheme: colorscheme slate

Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'

call plug#end()

" See: vim-differences nvim-defaults
filetype plugin indent on  " try to recognize filetypes and load related plugins/settings for those filetypes
syntax on
set signcolumn=yes " Always draw the signcolumn so errors don't move the window left and right
set number              " Show line numbers
set laststatus=0        " Always hide the status line
set noruler               " dont show the cursor position
set showcmd             " display incomplete commands
set guioptions=         " remove scrollbars
set noshowmode          " don't show mode
set nowrapscan          " Don't autowrap to top of tile on searches
set nomodeline          " Was getting annoying error about modeline when opening files, turn it off
set termguicolors       " enable true colors, if off nvim (not qt) will use default term colors
set nofoldenable        " Turn off folding

set ignorecase
set smartcase
set autowrite           " Automatically :write before running commands
set magic               " Use 'magic' patterns (extended regular expressions).
set mouse=a             " enable mouse (selection, resizing windows)
set mousemodel=popup_setpos
set tabstop=4           " Use 4 spaces for tabs.
set shiftwidth=4        " Number of spaces to use for each step of (auto)indent.
set expandtab           " tabs replaced with right amount of spacing
set shiftround          " Round indent to multiple of 'shiftwidth'
silent! helptags ALL    " Generate help doc for all plugins
" set iskeyword+=-        " Add chars that count as word boundaries. test: asdf-asdf
set fenc=utf-8          " set UTF-8 encoding

set spell               " turn on spell check
" correct spelling of work under cursor. <right> required since the cursor needs to be inside the word
nnoremap <c-s> i<right><c-x>s
inoremap <c-s> <right><c-x>s

set nowritebackup
set noswapfile
set splitbelow " :sp defaults down
" set splitright " :vs defaults right, quickfix edits cycles right split window so turn this off (TODO list usually in the :vs window)
set switchbuf=useopen " if buffer already opened, use it
set lazyredraw        " should make scrolling faster
set diffopt+=vertical " Always use vertical diffs
set visualbell " visual bell for errors
set wildignorecase
set textwidth=300
set nowrap                          " Don't word wrap
set cmdheight=2 " Better display for messages
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c " don't give |ins-completion-menu| messages.
" tell :find to recursively search
set path+=**
set completeopt=menuone,noinsert,noselect,preview

" Tell vim to use ripgrep as its grep program
" NOTE: --sort path can be used to get consistent order, but it will run with 1 thread.
" in terminal see rg --help for options to ripgrep 12
" set grepprg=rg\ --vimgrep\ --glob\ !tags\ --sort\ path
" NOTE: these globs work when you cd to root with Gcd using <leader>cr
" <leader>a does <leader>cr automatically
" set grepprg=rg\ --vimgrep\ --path-separator\ /\ -g\ 'src/**'\ -g\ 'public/src/**'\ -g\ 'specs/**'\ -g\ 'lib/**'\ -g\ 'include/**'\ -g\ 'tests/**'\ -g\ 'applications/**'\ -g\ 'cmake/**'
"
" NOTE: one slash for line break, one for space
" NOTE: keep --vimgrep at the end
" add root level folders you want to search with -g
set grepprg=rg\ --path-separator\ /\ -g\ src/**\ --vimgrep

" These commands will honor the custom ordering if you change the order of buffers.
" The vim commands :bnext and :bprevious will not respect the custom ordering.
nnoremap <silent><a-l> :BufferLineCycleNext<CR>
nnoremap <silent><a-h> :BufferLineCyclePrev<CR>

" These commands will move the current buffer backwards or forwards in the bufferline.
nnoremap <silent><a-s-l> :BufferLineMoveNext<CR>
nnoremap <silent><a-s-h> :BufferLineMovePrev<CR>

" kill buffer tab
nnoremap <silent> <a-q> :silent! up! <bar> silent! bd!<cr>

" Change pwd to this files location. local cd (change for current vim 'window') to current file's dir (% is file name :p expands to full path :h takes the head)
nnoremap <leader>cd :lcd %:p:h <bar> pwd <cr>

" mapping nomenclature: e is edit, a is ack, r is replace, s is search, m is manual, w is word, y is yank
" TODO: need proper word boundary versions(aw, rw) for better var name changes.
" NOTE: looks like <args> (the thing after :MyGrep) has to be a space separated list of quoted items
command! -nargs=+ MyGrep mark A | execute 'silent grep! <args>' | bot cw 20
command! -nargs=+ MyGrepCurrentFile mark A | execute 'silent grep! <args> %' | bot cw 20
command! -nargs=+ MyCdo execute 'silent cfdo! <args>' | cfdo update | cclose | execute 'normal! `A'
nnoremap <leader>,as :let @w = "" <bar> MyGrep "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
nnoremap <leader>,aw :let @w = "<c-r><c-w>" <bar> MyGrep "-w" "<c-r><c-w>"<cr>
" Same as above but include current dir with -g */**
" used in <leader>A
nnoremap <leader>,aS :let @w = "" <bar> MyGrep "-g" "*/**" "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
nnoremap <leader>,aW :let @w = "<c-r><c-w>" <bar> MyGrep "-w" "-g" "*/**" "<c-r><c-w>"<cr>
" " not sure i really need current-file-only version
" nnoremap <leader>,aS :let @w = "" <bar> MyGrepCurrentFile "<c-r>=substitute(substitute(substitute(substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', 'g'), '\\<', '', 'g'), '\\>', '', 'g'), '\\', '\\\\', 'g')<cr>"<cr>
" nnoremap <leader>,aW :let @w = "<c-r><c-w>" <bar> MyGrepCurrentFile "<c-r><c-w>" "-w"<cr>
" mapped to above. if you have something highlighted and it wasnt a word search, it will run the search version.
" otherwise run the word version. a is for current dir of file (<leader>cd) and A is for root (<leader>cr)
" rg from current files directory
nmap <expr> <leader>A v:hlsearch ==# 1 ? @/ =~ "\<" ? "<leader>cd<leader>,aW" : "<leader>cd<leader>,aS" : "<leader>cd<leader>,aW"
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
" NOTE: when using gr from the lsp make sure to * first this will record to @w which you can then use with <leader>r
" and it will call the word version
nmap <expr> <leader>r @w != "" ? "<leader>,rw" : "<leader>,rs"

" COMPLETION
" " nvim-lsp NOTE: This must go after plug section ----------------------------------------
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <cr> pumvisible() ? "\<esc>" : "\<cr>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

:lua << EOF
    ------------------
    --- bufferline ---
    ------------------
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

    ----------------
    -- hop ---------
    ----------------
    require'hop'.setup()

    ------------------
    -- compe ---------
    ------------------
    require'compe'.setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'enable';
        throttle_time = 80;
        source_timeout = 200;
        resolve_timeout = 800;
        incomplete_delay = 400;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = {
            border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
            winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
            max_width = 120,
            min_width = 60,
            max_height = math.floor(vim.o.lines * 0.3),
            min_height = 1,
        };
        source = {
            -- higher is more important
            nvim_lua = {priority = 10},
            nvim_lsp = {priority = 9},
            buffer = {priority = 7},
            luasnip = {priority = 5},
            path = {priority = 4},
            calc = {priority = 3},
        };
    }

    -- ---------------------
    -- ----- cmp -----------
    -- ---------------------
    -- local cmp = require'cmp'
    -- cmp.setup({
    --     mapping = {
    --         ['<CR>'] = cmp.mapping.confirm({ select = true }),
    --         ['<C-d>'] = function(fallback) if cmp.visible() then cmp.mapping.scroll_docs(4) else fallback() end end,
    --         ['<C-u>'] = function(fallback) if cmp.visible() then cmp.mapping.scroll_docs(-4) else fallback() end end,
    --     },
    --     sources = {
    --         { name = "nvim_lsp" },
    --         { name = "buffer" },
    --         { name = "lua_snip" },
    --         { name = "nvim_lua" },
    --         { name = "path" },
    --     },
    --     snippet = {
    --         expand = function(args)
    --             require("luasnip").lsp_expand(args.body)
    --         end,
    --     },
    --     experimental = {
    --         ghost_text = true,
    --     },
    -- })
    -- cmp.setup.cmdline('/', {
    --     sources = {
    --         { name = 'buffer' },
    --         { name = 'nvim_lsp' },
    --     },
    -- })
    -- cmp.setup.cmdline(':', {
    --     sources = {
    --         { name = 'cmdline' },
    --         { name = 'nvim_lsp' },
    --         { name = 'path' },
    --     },
    -- })

    -------------------
    -- lsp_signature --
    -------------------
    local lsp_signature_config = {
        hint_enable = true, -- virtual hint enable
        hint_prefix = "",
        floating_window = true, -- false for virtual text only
        handler_opts = {
            border = "single" -- double, single, shadow, none
        },
        extra_trigger_chars = { "(", "," }
    }

    ----------------
    -- treesitter --
    ----------------
    require'nvim-treesitter.configs'.setup {
        -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        -- NOTE: if you get errors related to abi or anything with treesitter
        -- you may have to update your version of neovim, see neovim section of installSteps.txt
        ensure_installed = { "c", "cpp", 'bash', "lua", "typescript", "javascript", "html", "json", "yaml" },
        highlight = { enable = true, },
        indent = { enable = false, },
        incremental_selection = { enable = false, },
    }

    ---------------------------------
    -- lspconfig language servers  --
    ---------------------------------
    local nvim_lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
        require'lsp_signature'.on_attach(lsp_signature_config)
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        -- local cbufnvim = vim.api.nvim_exec('echo bufnr("%")', true)

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        -- can use on `auto` in cpp to get the underlying type
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        -- if rename does not work, can use gr<leader>r for a more accurate rename over *<leader>a<leader>r
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '"wyiw<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
        -- happens on save (see Flash())
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gw', '<cmd>lua vim.lsp.buf.formatting_seq_sync()<cr>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<a-o>', '<cmd>SwitchSourceHeader<cr>', opts)
    end

    local servers = { "clangd", "cmake", "jsonls", "vimls", "tsserver", "sumneko_lua", "html", "bashls"  }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 500,
            },
            -- capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
            commands = {
                SwitchSourceHeader = {
                    function()
                        local bufnr = require'lspconfig'.util.validate_bufnr(0)
                        -- ClangdSwitchSourceHeader is the build-in version, but it has some behavior that i dont like
                        vim.api.nvim_command("ClangdSwitchSourceHeader")
                        vim.api.nvim_command("bdelete "..tostring(bufnr))
                        -- local params = { uri = vim.uri_from_bufnr(bufnr) }
                        -- vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
                        --     if err then error(tostring(err)) end
                        --     if not result then print ("Corresponding file can’t be determined") return end
                        --     vim.api.nvim_command("edit "..vim.uri_to_fname(result))
                        --     vim.api.nvim_command("bdelete "..tostring(bufnr))
                        -- end)
                    end
                },
            },
        }
    end

    -- -- lsp config
    -- -- https://github.com/neovim/nvim-lspconfig
    -- -- Check that an LSP client has attached to the current buffer:  >
    -- --     :lua print(vim.inspect(vim.lsp.buf_get_clients()))
    -- --     :LspInfo
    -- --     make sure no ERRORS in
    -- --     :lua vim.cmd('e'..vim.lsp.get_log_path())
    -- -- -- NOTE: use these for debug info
    -- -- -- uncomment vim.lsp.set_log_level("debug") above
    -- -- -- :lua print(vim.inspect(vim.lsp.buf_get_clients()))
    -- -- -- :LspInfo
    -- -- -- to look in the lsp's log:
    -- -- -- :lua vim.cmd('e'..vim.lsp.get_log_path())

    -- Use to debug clangd, remove from server list above but remember to put it back when fixed
    -- nvim_lsp.clangd.setup{
    --     cmd = { "clangd", "-j=1", "--log=verbose" },
    --     flags = {
    --         debounce_text_changes = 500,
    --     },
    --     on_attach = on_attach,
    -- }

    -- -- Turn on debug logging
    -- vim.lsp.set_log_level("debug")

    -- Disable diagnostic
    vim.diagnostic.config {
        virtual_text = false,
        signs = false,
        underline = false,
    }

EOF

" notify if file changed outside of vim to avoid multiple versions
autocmd FocusGained,BufEnter,WinEnter,CursorHold,CursorHoldI * :checktime

" see https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" There was a comment about making sure .viminfo is read/write
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif


" Prevents navigation into diagnostic windows
autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })

" Disable diagnostic
autocmd BufEnter * lua vim.lsp.diagnostic.disable()

" trailing whitespace, and end-of-lines. Very useful if in a code base that requires it.
" Also highlight all tabs and trailing whitespace characters.
" set listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace
" set list                            " Show problematic characters.
" NOTE see vim-better-whitespace plugin
highlight ExtraWhitespace ctermbg=black guibg=black

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Manually remove whitespace, replace tabs with 4 spaces
nnoremap <leader>w mw:%s/\s\+$//ge<cr>:%s/\t/    /ge<cr>:noh<cr>`w

" FILETYPE filetype
" Associate filetypes with other filetypes
" Can view  all filetypes by doing :setfiletype and tab to try to complete (yes, no space between set and filetype)
" Query a file's filetype by doing :set ft ?

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell
" add support for comments in json (jsonc format used as configuration for many utilities)
autocmd FileType json syntax match Comment +\/\/.\+$+
" webdev community seems to love doing this
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" terminal, floaterm
" Go to insert mode when switching to a terminal
" Distinguish terminal by making cursor red
let g:floaterm_borderchars=''
let g:floaterm_position='right'
let g:floaterm_width=0.60
let g:floaterm_height=1.0
nnoremap <silent>   <c-\>   :FloatermToggle<CR>
tnoremap <silent>   <c-\>   <C-\><C-n>:FloatermToggle<CR>
" Esc quits the terminal
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
set winblend=15 " set all floating windows transparent(0-100)
hi Floaterm guibg=black
hi FloatermBorder guibg=black guifg=black

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

" @see MakeFileAndAddToGit
function! CreateAddFile(currFilename, filename)
    execute 'silent edit ' . a:filename
    execute 'silent write'
    execute 'silent !git add ' . a:filename
    echo '===== UPDATE CMAKELISTS.TXT: ' . a:filename . ' ====='
endfunction

" @see MakeFileAndAddToGit
function! RemoveFile(currFilename, filename)
    execute 'silent !git rm -f ' . a:currFilename
    echo '===== UPDATE CMAKELISTS.TXT: ' . a:currFilename . ' ====='
endfunction

" @see MakeFileAndAddToGit
function! MoveFile(currFilename, filename)
    execute 'silent !git mv ' . a:currFilename . ' ' a:filename
    echo '===== UPDATE CMAKELISTS.TXT: ' . a:currFilename . ' -> ' . a:filename . ' ====='
    execute 'silent edit ' . a:filename

    " TODO: here: go back to the old file with c-6
    " silent bd!

    execute 'silent edit ' . a:filename
endfunction

" Will make a .h from a .c/.cpp
" if there's a root/include and it was fed a c/cpp it will use the root/src path to create the mirrored include path for the .h
" NOTE:  cd,pwd is system cd,pwd
" NOTE: echom allows you to recall messages with :mes
" TODO: need a git mv and rm -f version of this.
" could be this:
":let funcs = [function("Append"), function("Pop")]
":echo funcs[1](['a', 'b', 'c'], 1)
function! FileGit(fn, filename)
    " Open a file that is the directory already or at the base of directories we need to make.
    execute 'cd %:p:h'
    let fullCurrFilePath = expand('%:p')
    echom 'fullCurrFilePath: ' . fullCurrFilePath

    " Gets the full path by taking the path to the file we are looking at + any pathing we included in filename arg.
    let filenameSanitized = substitute(a:filename, '^/', '', '')
    let fullFilePath = getcwd() . '/' . filenameSanitized
    echom 'fullFilePath: ' . fullFilePath

    " Gcd is from fugitive. It will take us to the root of repo.
    execute 'Gcd'
    let rootPath = getcwd() . '/'
    echom 'rootPath: ' . rootPath

    " Capture the full path to the file we are making
    let fileRootRel = substitute(fullFilePath, rootPath, '', '')
    echom 'fileRootRel: ' . fileRootRel

    " Capture the full path to the current file we have open (used for MoveFile and RemoveFile)
    let currFileRootRel = substitute(fullCurrFilePath, rootPath, '', '')
    echom 'currFileRootRel: ' . currFileRootRel

    " Chop off the file name(wonder if this can be done with :p:h thing)
    let fileDirRootRel = substitute(fileRootRel, '[0-9A-Za-z]\+\.[0-9A-Za-z]\+$', '', '')
    echom 'fileDirRootRel: ' . fileDirRootRel

    if fileDirRootRel =~ '[0-9A-Za-z]\+'
        echom 'Running mkdir -p ' . fileDirRootRel
        execute 'silent !mkdir -p ' . fileDirRootRel
    endif

    execute a:fn(currFileRootRel, fileRootRel)

    " We are done if this is not a c or cpp file
    if string(a:fn) =~ 'CreateAddFile'
        echom 'CALLED CreateAddFile'
        if fileRootRel !~ '\.c[p]\{-,2}$'
            echom 'WAS NOT A C/CPP FILE: ' . fileRootRel . ' : DONE!'
            return
        endif
    else
        echom 'DID NOT CALL CreateAddFile'
        if currFileRootRel !~ '\.c[p]\{-,2}$'
            echom 'WAS NOT A C/CPP FILE: ' . currFileRootRel . ' : DONE!'
            return
        endif
    endif

    echom 'THIS IS A C/CPP FILE: RUNNING OPERATION FOR H FILE'

    " .c/.cpp discovery: match .c then 0 or 2 p's then end of line
    " see :h pattern-overview
    let hFileRootRel = substitute(fileRootRel, '\.c[p]\{-,2}$', '.h', '')
    echom 'hFileRootRel: ' . hFileRootRel

    let hCurrFileRootRel = substitute(currFileRootRel, '\.c[p]\{-,2}$', '.h', '')
    echom 'hCurrFileRootRel: ' . hCurrFileRootRel

    let includeGrep = substitute(system('ls | grep include'), '\n\+$', '', '')
    echom 'INCLUDE GREP: ' . includeGrep

    if includeGrep != 'include'
        echom 'DOES NOT HAVE INCLUDE DIR: DONE'
        execute a:fn(hCurrFileRootRel, hFileRootRel)
        return
    endif

    echom 'HAS INCLUDE DIR'

    " src
    let hFileDirRootRel = substitute(fileDirRootRel, '^src', 'include', '')
    echom 'src hFileDirRootRel: ' . hFileDirRootRel
    if hFileDirRootRel =~ '^include'
        echom 'HAS SRC DIR'
        echom 'Running mkdir -p ' . hFileDirRootRel
        execute 'silent !mkdir -p ' . hFileDirRootRel
        let hFileStem = substitute(hFileRootRel, '^src', 'include', '')
        echom 'hFileStem: ' . hFileStem
        let hCurrFileStem = substitute(hCurrFileRootRel, '^src', 'include', '')
        echom 'hCurrFileStem: ' . hCurrFileStem
        execute a:fn(hCurrFileStem, hFileStem)
        return
    endif

    " source
    let hFileDirRootRel = substitute(fileDirRootRel, '^source', 'include', '')
    echom 'SOURCE hFileDirRootRel: ' . hFileDirRootRel
    if hFileDirRootRel =~ '^include'
        echom 'HAS SOURCE DIR'
        echom 'Running mkdir -p ' . hFileDirRootRel
        execute 'silent !mkdir -p ' . hFileDirRootRel
        let hFileStem = substitute(hFileRootRel, '^source', 'include', '')
        echom 'hFileStem: ' . hFileStem
        let hCurrFileStem = substitute(hCurrFileRootRel, '^source', 'include', '')
        echom 'hCurrFileStem: ' . hCurrFileStem
        execute a:fn(hCurrFileStem, hFileStem)
        return
    endif

endfunction

" leader g is for git stuff
" git add
nnoremap <leader>ga :call FileGit(function("CreateAddFile"), "")<left><left>
" git rm -f
nnoremap <leader>gr :call FileGit(function("RemoveFile"), "")<left><left>
" git mv
nnoremap <leader>gm :call FileGit(function("MoveFile"), "")<left><left>

" \v search prefix modifier is very magic, \V prefix modifier very no magic. With \V Only \ and / have meaning and must be escaped with \
nnoremap / /\V
xnoremap / /\V

nnoremap <leader><leader> :LspRestart<cr>
" I don't wan't to think through vim's 6 different ways to scroll the screen
" Bonus: frees up ctrl e, y, f, b
" For this single scroll setup, it's best to set really fast pollrate (~40 keys/s) and really short delay (~200ms) on the system (this is good to do in general)
noremap <silent> <c-e> <nop>
noremap <silent> <c-y> <nop>
noremap <silent> <c-f> <nop>
noremap <silent> <c-b> <nop>

" Scroll by a quarter of window height (https://stackoverflow.com/a/16574696/1706778)
" An amount based on screen size
function! SetScroll()
    let scrAmount=&lines/4
    execute 'nnoremap <c-d> ' . scrAmount . '<c-e>'
    execute 'nnoremap <c-u> ' . scrAmount . '<c-y>'
endfunction
call SetScroll()
autocmd VimResized * call SetScroll()

" Just annoying
noremap <silent> R <nop>

" NOTE: was cause of slowness at one point
" set clipboard+=unnamedplus " To ALWAYS use the system clipboard for ALL operations
xnoremap <c-y> "+y
xnoremap <c-p> "+p
nnoremap <c-p> "+p

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

"location list
nnoremap <a-s-c>o :lopen<cr>
nnoremap <a-s-n> :lnext<cr>
nnoremap <a-s-p> :lprevious<cr>
" quickfix list
nnoremap <a-c>o :copen<cr>
nnoremap <a-n> :cnext<cr>
nnoremap <a-p> :cprevious<cr>

" COLORCOLUMN
" CURSORLINE (can be slower in some terminals)
" purple4 black
" You can also specify a color by its RGB (red, green, blue) values.
" The format is "#rrggbb", where
" hi Comment guifg=#11f0c3 guibg=#ff00ff
hi cursorline  gui=NONE guibg=purple4 guifg=NONE
hi cursorcolumn  gui=NONE guibg=purple4 guifg=NONE

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
    set cursorline cursorcolumn
    redraw
    if &ft != 'markdown'
        lua vim.lsp.buf.formatting_seq_sync()
    endif
    silent! w!
    " sleep 30m
    set nocursorcolumn
    if g:useCursorline == 0
        set nocursorline
    endif
endfunction
nnoremap <c-[> :silent! call Flash()<cr>:noh<cr>

" Only hit < or > once to tab indent, can be vis selected and repeated like normal with '.'
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" force write in linux
cmap w!! %!sudo tee > /dev/null %

" indent scope
nnoremap == ms=i{`s

" replay macro (qq to start recording, q to stop)
nnoremap Q @q
" apply macro across visual selection, VG to select until end of file
vnoremap Q :norm @q<cr>

" navigate by display lines
nnoremap j gj
nnoremap k gk

" yank to end of line to follow the C and D convention.
nnoremap Y y$

" mapmode-o is operator pending mode (d, y, c, t, T, f, F, etc)
" This allows you to change backwards (ex: cF) and include the char under cursor.
onoremap T vT
onoremap F vF
" Similar to above, Get B/b motions to include the first char
onoremap B vB
onoremap b vb

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
nnoremap <silent> <leader>vs :silent! call Flash()<cr>: so $MYVIMRC <cr>msHmt:e<cr>`tzt`s
" Edit the vimrc in a new tab
nnoremap <silent> <leader>ve :vs $MYVIMRC<cr>
" Diff the current local vimrc against master
let uname = substitute(system('uname'),'\n','','')
if uname == 'Linux'
    " diff the current state of init.vim with whats in the repo
    nmap <silent> <leader>vd <c-\>cd ~/clones/vim<cr>cp $MYVIMRC .<cr>git diff<cr>
    " Pull latest vimrc, copy it to vimrc location, source it, restart coc
    nmap <silent> <leader>vp <c-\>cd ~/clones/vim<cr>git pull<cr>cp init.vim $MYVIMRC<cr>cd -<cr>
else
    nmap <silent> <leader>vd <c-\>cd C:/Users/lol/clones/vim<cr>copy /y ..\..\AppData\Local\nvim\init.vim .<cr>git diff<cr>
    nmap <silent> <leader>vp <c-\>pushd .<cr>cd C:/Users/lol/clones/vim<cr>git pull<cr>copy /y init.vim ..\..\AppData\Local\nvim<cr>popd<cr>
endif

nnoremap <silent> <leader>qq :wa!<cr>:qa!<cr>

" we cd to root and save the path to the l register for pasting in terminal later
" have to run cmake twice for compile_commands.json to show up?
nmap <silent> <leader>bl <leader>cr<cmd>let @l = getcwd()<cr><c-\>cd <c-r>l<cr>cmake -BbuildLinux; cmake -BbuildLinux; cp buildLinux/compile_commands.json .;cd -;<cr>

" Prettier format Json
nnoremap <leader>p :%!python -m json.tool<cr>

" NOTE xxd is a linux thing
" convert to hex view
nnoremap <leader>xx :%!xxd<cr>
" undo convert to hex view
nnoremap <leader>xr :%!xxd -r<cr>

""""""""""""""""""""" RETIRED """""""""""""""""""""
""""""""""""""""""""" RETIRED """""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
" zR zM open/close all folds
" zo zc open/close fold
" zE remove all folds

" ga will tell you the different binary represenations of the char under cursor
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
