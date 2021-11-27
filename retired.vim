" fzf FzF fzf
" Better fzf :Colors command.
" command! -bang Colors call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 1%,0'}, <bang>0)
" command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))
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
"
"
" coc COC CoC
" https://github.com/neoclide/coc.nvim
" Useful commands CocConfig, CocInfo, CocInstall, CocUninstall, CocList, CocCommand
" For c based langs, use clangd (choco install llvm then :CocConfig and paste the json settings from coc.nvim github wiki)
" `CocList marketplace` to see things you can CocInstall
" "CocInstall coc-tsserver coc-eslint coc-json coc-html coc-css coc-sh coc-clangd coc-rls coc-syntax coc-tag
" CocList extensions
" hit tab to view actions on an extension
" "CocCommand <tab>
" :CocConfig will edit the config file where you put languageservers usually lives here ~/.config/nvim/coc-settings.json
"
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = ['coc-tsserver', 'coc-clangd', 'coc-cmake', 'coc-vimlsp', 'coc-html', 'coc-eslint', 'coc-sh', 'coc-json', 'coc-yaml', 'coc-xml', 'coc-sql']
" " NOTE: look here for example .vimrc: https://github.com/neoclide/coc.nvim#example-vim-configuration
" " <cr> to comfirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" " use <tab> for trigger completion and navigate to the next complete item
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
" " Use c-j (back) and c-k (forward) to jump to args pulled method signature
" " use j and k to navigate list, use p to toggle preview window
" function! s:show_documentation()
"     if (index(['vim','help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     else
"         call CocAction('doHover')
"     endif
" endfunction
" " nnoremap <silent> gk :call <SID>show_documentation()<CR>
" " nnoremap <buffer> <c-]> <Plug>(coc-definition)
" " nnoremap <buffer> gr <Plug>(coc-references)
" " " nnoremap <buffer> gt <Plug>(coc-type-definition)
" " nnoremap <leader>rn <Plug>(coc-rename)
" nnoremap <buffer> <c-space> :CocRestart<cr>
"
"
"
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
"
"
"
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
"
"
"
" Useful but better to use the visual select search and repace mappings that I setup (<leader> ey Ey ew Ew)
" Make a simple "search" text object, then cs to change search hit, n. to repeat
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
" vnoremap <silent> s //e<c-r>=&selection=='exclusive'?'+1':''<cr><cr>
"             \:<c-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
" onoremap s :normal vs<cr>
"
" NOTE: THIS LINE SCREWS UP AUTO COMPLETE
" au BufEnter * if &buftype == 'terminal' | startinsert | else | stopinsert | endif
"
"
" NOTE: point of this was for various surrounds
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

" nnoremap <leader>ew :%s/\V\<<c-r><c-w>\>//gI \|normal <c-o><c-left><c-left><left><left><left><left>
" Edit confirm word in whole file
" nnoremap <leader>Ew :,$s/\V\<<c-r><c-w>\>//gIc \|1,''-&&<c-left><left><left><left><left><left>
" edit word under cursor within the visual lines
" vnoremap <leader>ew <Esc>yiwgv:s/\V\<<c-r>"\>//gI \| normal <c-left><c-left><left><left><left><left>
" Visually selected text in file
" If mode is visual line mode, edit the prev yank across the vis lines, else across the whole file
" c-r=escape() means paste in the result of escape
" vnoremap <expr> <leader>ey mode() ==# "V" ?
"       \ ":s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"
"       \: "y:%s/\\V<c-r><c-r>=escape(@\", '/\\')<cr>//gI \| normal <c-o><c-left><c-left><c-left><left><left><left><left>"
" Whole file edit yank (E version being with confim)
" nnoremap <leader>ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gI <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left>
" nnoremap <leader>Ey :%s/\V<c-r>=escape(@", '/\\')<cr>//gIc <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left><left>
" Visual lines or visual select edit-last-search, 4 backslashes since we are in a "" and to insert a \ into "" you need \\
" and to get the \\ in a '' from a "" you need 4.
" NOTE: the w and y versions are never used in practice since * can handle those cases as well
" to see whats there and V to select the ones that need to change
" vnoremap <expr> <leader>es mode() ==# "V" ?
" \ ":s/\\V<c-r>=substitute(substitute(@/, '\\\\V', '', 'g'), '\\\\n$', '', '')<cr>//gI \| normal <c-left><c-left><left><left><left><left>"
" \: ""
" nnoremap <leader>Es :%s/\V<c-r>=substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', '')<cr>//gIc <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left><left>
" xnoremap <leader>es :s/\V<c-r>=substitute(substitute(@/, '\\\\V', '', 'g'), '\\\\n$', '', '')<cr>//gI \| normal <c-left><c-left><left><left><left><left>
" Whole file edit last search(E version being with confim). Get rid of teh extre \V then get rid of any ending \n
" nnoremap <leader>es :%s/\V<c-r>=substitute(substitute(@/, '\\V', '', 'g'), '\\n$', '', '')<cr>//gI <bar> normal <c-o><c-left><c-left><c-left><left><left><left><left>
"
" noremap <silent> <c-u> 12<c-y>
" noremap <silent> <c-d> 12<c-e>

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


" " treesitter
" highlight TSCurrentScope guibg=#141414
" highlight TSDefinition guibg=gray29
" highlight TSDefinitionUsage guibg=gray29
"

" " Insert mode completion.
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)


" " " Presentation mode. Need a dir full of .vpm files (number them, for example, 00.vpm) and goyo plugin
" " " in command line: cd dir; nvim *
" autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
" function SetVimPresentationMode()
"     nnoremap <buffer> <right> :n<cr>
"     nnoremap <buffer> <left> :N<cr>
"     " truezen is a better pluggin
"     if !exists('#goyo')
"         Goyo
"     endif
" endfunction

        " NOTE: for nvim-treesitter
        " --------------
        " -- REFACTOR --
        " --------------
        " refactor = {
        "     highlight_definitions = { enable = false },
        "     highlight_current_scope = { enable = false },
        "     -- current scope (and current file).
        "     smart_rename = {
        "         enable = false,
        "         keymaps = {
        "             smart_rename = "R",
        "         },
        "     },
        "     navigation = {
        "         enable = false,
        "         keymaps = {
        "             goto_definition_lsp_fallback = "gd",
        "             list_definitions = "<nop>",
        "             list_definitions_toc = "<nop>",
        "             goto_next_usage = "<nop>",
        "             goto_previous_usage = "<nop>",
        "         },
        "     },
        " },
        "
        " ------------------
        " -- TEXT OBJECTS --
        " ------------------
        " textobjects = {
        "     ------------
        "     -- SELECT --
        "     ------------
        "     select = {
        "         enable = false,
        "         -- Automatically jump forward to textobj, similar to targets.vim
        "         lookahead = true,
        "         keymaps = {
        "             -- You can use the capture groups defined in textobjects.scm
        "             ["if"] = "@function.inner",
        "             ["af"] = "@function.outer",
        "             ["ic"] = "@conditional.inner",
        "             ["ac"] = "@conditional.outer",
        "             ["il"] = "@loop.inner",
        "             ["al"] = "@loop.outer",
        "             ["is"] = "@scopename.inner",
        "             ["as"] = "@statement.outer",
        "         },
        "     },
        "
        "     ----------
        "     -- SWAP --
        "     ----------
        "     swap = {
        "         enable = false,
        "         swap_next = {
        "             ["<a-x>"] = "@parameter.inner",
        "         },
        "         swap_previous = {
        "             ["<a-s-x>"] = "@parameter.inner",
        "         },
        "     },
        "
        "     ----------
        "     -- MOVE --
        "     ----------
        "     move = {
        "         enable = false,
        "         set_jumps = true, -- whether to set jumps in the jumplist
        "         goto_next_start = {
        "             ["<a-f>"] = "@function.outer",
        "             ["<a-{>"] = "@scopename.inner",
        "         },
        "         goto_previous_start = {
        "             ["<a-s-f>"] = "@function.outer",
        "             ["<a-}>"] = "@scopename.inner",
        "         },
        "     },
        "
        "     -----------------
        "     -- LSP INTEROP --
        "     -----------------
        "     lsp_interop = {
        "         enable = true,
        "         peek_definition_code = {
        "             ["<bar>"] = "@class.outer",
        "             ["<bslash>"] = "@function.outer",
        "         },
        "     },
        " },

    " ----------------------
    " -- devicons ---------
    " ----------------------
    " require'nvim-web-devicons'.setup {
    "     -- your personnal icons can go here (to override)
    "     -- DevIcon will be appended to `name`
    "     -- override = {
    "     --     zsh = {
    "     --         icon = "",
    "     --         color = "#428850",
    "     --         name = "Zsh"
    "     --     }
    "     -- };
    "     -- globally enable default icons (default to false)
    "     -- will get overriden by `get_icons` option
    "     default = true;
    " }
    " require'nvim-web-devicons'.get_icons()
    "
" Plug 'tpope/vim-obsession'
" " :Obsession to create a session with optional file or dir arg
" " :Obsession! throw session away
" " nvim -S or :so the session file to open it


" NOTE: About an identical experience to vscode in terms of what kind of vars you can see and stepping speed (slow).
" Keep around just in case
" nvim-dap: stepping speed was great, var visibility the same, usability was worse.
" Need to look into graphical gdb
" Plug 'puremourning/vimspector'
" let g:vimspector_base_dir=expand( '$HOME/.vim/vimspector-config' )
" " For c++ install llvm then follow directions for lldb-vscode in :h vimspector
" let g:vimspector_install_gadgets = [ 'vscode-node-debug2', 'vscode-cpptools' ]
" nnoremap <leader>dd :call vimspector#Launch()<cr>
" " Issues with f11 in windows terminal...
" nmap <s-right> :call vimspector#Continue()<cr>
" nmap <s-left> :call vimspector#Reset()<cr>
" " Quit vimspector
" nmap <down> <Plug>VimspectorStepOver
" nmap <right> <Plug>VimspectorStepInto
" nmap <left> <Plug>VimspectorStepOut
" nmap <s-down> <Plug>VimspectorRunToCursor
" nmap <F9> <Plug>VimspectorToggleBreakpoint
" nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
" function! IsPopup()
"     return win_gettype() == "popup" ? 1 : 0
" endfunction
" nmap <expr> <tab> IsPopup() ? "\<esc>" : "\<Plug>VimspectorBalloonEval"
" " have to move mouse to word first with left click
" nmap <RightMouse> <Plug>VimspectorBalloonEval
" xmap <tab> <Plug>VimspectorBalloonEval
" " Up/down stack
" " nmap <leader><F11> <Plug>VimspectorUpFrame
" " nmap <leader><F12> <Plug>VimspectorDownFrame
" nmap <leader>dl :call vimspector#ListBreakpoints()<cr>
" nmap <leader>dc :call vimspector#ClearBreakpoints()<cr>
" nmap <leader>dw :call vimspector#DeleteWatch()<cr>

" Plug 'stsewd/fzf-checkout.vim'
" " <cr> switch to,  a-enter track remote, c-b create, c-d delete, c-e merge, c-f (requires fugitive)
" nnoremap <leader>gb :GBranches<cr>
" " alt-enter doesnt work (its full screen on windows terminal). pneumonic: grab from origin
" let g:fzf_branch_actions = { 'track': {'keymap': 'ctrl-g'} }
" " c-r rebase doesnt work. pneumonic: paste
" " NOTE: rebase usually has conflicts so might not be worth it
" " let g:fzf_branch_actions = { 'rebase': {'keymap': 'ctrl-v'} }

" NOTE: for tpope fugitve
" TODO: would need a function that does :G branch and finds the line with * BRANCHNAME
" Then extract that branch name and returns this string
" G reset --hard origin/BRANCHNAME
" nnoremap <leader>gs :G fetch <bar> call GetBranchOriginSyncString()<cr>

" " okay but really need git integration
" " or a file tree that has really good create/move/delete with git
" Plug 'tpope/vim-eunuch'
" " :Delete: Delete a buffer and the file on disk simultaneously.
" " :Move: Rename a buffer and the file on disk simultaneously.
" " :Mkdir: Create a directory, defaulting to the parent of the current file.
" " :SudoWrite: Write a privileged file with sudo.
" " :SudoEdit: Edit a privileged file with sudo.
" " nvim-tree
" let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
" let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
" let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
" let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
" let g:nvim_tree_hijack_cursor = 0 "1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
" let g:nvim_tree_icon_padding = '' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
" let g:nvim_tree_update_cwd = 1 "0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
" " Dictionary of buffer option names mapped to a list of option values that
" " indicates to the window picker that the buffer's window should not be
" " selectable.
" let g:nvim_tree_window_picker_exclude = {
"     \   'filetype': [
"     \     'packer',
"     \     'qf'
"     \   ],
"     \   'buftype': [
"     \     'terminal'
"     \   ]
"     \ }
" "If 0, do not show the icons for one of 'git' 'folder' and 'files'
" "1 by default, notice that if 'files' is 1, it will only display
" "if nvim-web-devicons is installed and on your runtimepath.
" "if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
" "but this will not work when you set indent_markers (because of UI conflict)
" let g:nvim_tree_show_icons = {
"     \ 'git': 1,
"     \ 'folders': 0,
"     \ 'files': 0,
"     \ 'folder_arrows': 0,
"     \ }
" " default will show icon by default if no icon is provided
" " default shows no icon by default
" let g:nvim_tree_icons = {
"     \ 'default': '',
"     \ 'symlink': '',
"     \ 'git': {
"     \   'unstaged': "✗",
"     \   'staged': "✓",
"     \   'unmerged': "C",
"     \   'renamed': "➜",
"     \   'untracked': "U",
"     \   'deleted': "D",
"     \   'ignored': "◌"
"     \   },
"     \   'lsp': {
"     \     'warning': "W",
"     \     'error': "E",
"     \   }
"     \ }
" nnoremap <leader>t :NvimTreeToggle<CR>
" " a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue
" " a: add a file. Adding a directory requires leaving a leading / at the end of the path.
" " you can add multiple directories by doing foo/bar/baz/f and it will add foo bar and baz directories and f as a file
" " r: rename file
" " R: refresh tree
" " d: remove with confirm
" " <cr>: open file
" " <tab>: open file in preview


" " star search, *, visual search
" " No forward jump, Can search visual selections.
" " see uri and sebastian answer from https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
" " nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
" " @"" is the "unnamed" default register, y and d go there.
" nnoremap <silent> * yiw:let @/ = '\<' . @"" . '\>'<cr>:set hls<cr>:redraw<cr>
" xnoremap <silent> * y:let @/ = @""<cr>:set hls<cr>:redraw<cr>


" " Simple re-format for minified Javascript
" command! UnMinify call UnMinify()
" function! UnMinify()
"     %s/{\ze[^\r\n]/{\r/g
"     %s/){/) {/g
"     %s/};\?\ze[^\r\n]/\0\r/g
"     %s/;\ze[^\r\n]/;\r/g
"     %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
"     normal ggVG=
" endfunction

" " Font, size, resize
" set guifont=Monospace:h8
" let s:fontsize = 7
" function! AdjustFontSize(amount)
"     let s:fontsize = s:fontsize+a:amount
"     :execute "GuiFont! Monospace:h" . s:fontsize
" endfunction
" noremap <c-=> :call AdjustFontSize(1)<CR>
" noremap <c--> :call AdjustFontSize(-1)<CR>

" " Add the terminal to unlisted buffers so that buffer line doesnt show it
" " NOTE: Tried all the Buf* stuff but only this one seemed to work
" " and so it only gets removed from buffer tabs when you leave the terminal
" autocmd BufLeave bash* setlocal nobuflisted

" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" set runtimepath^=~/.local/share/nvim runtimepath+=~/.local/share/nvim/after
" set runtimepath^=stdpath('data')
" let &packpath = &runtimepath

" if has('gui')
"     " Turn off scrollbars. (Default on macOS is "egmrL").
"     set winaltkeys=no
"     set guioptions-=L
"     set guioptions-=R
"     set guioptions-=b
"     set guioptions-=l
"     set guioptions-=r
"     set guioptions-=T
"     set guioptions-=m
" endif


" syntax on        " syntax highlighting

" " So git bash or whatever doesn't throw up errors everywhere when it needs you to edit a commit message
" if v:progname == 'vi'
"     set noloadplugins
" endif

" " helps startup speed
" let g:python_host_prog  = '/usr/bin/python2'
" let g:python3_host_prog  = '/usr/bin/python3'
" let g:perl_host_prog = '/usr/bin/perl'
"
"lua switchSourceHeader
                        " -- local params = { uri = vim.uri_from_bufnr(bufnr) }
                        " -- vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
                        " --     if err then error(tostring(err)) end
                        " --     if not result then print ("Corresponding file can’t be determined") return end
                        " --     vim.api.nvim_command("edit "..vim.uri_to_fname(result))
                        " --     vim.api.nvim_command("bdelete "..tostring(bufnr))
                        " -- end)


" BUFFERLINE
" Plug 'akinsho/nvim-bufferline.lua'
" set switchbuf=useopen  " if buffer already opened, use it. if doing bufferline: useopen
" get rid of let g:fzf_action settings
" LUA:
"
    " ------------------
    " --- bufferline ---
    " ------------------
    " local hlColor = "GreenYellow"
    " -- local hlColor = "LemonChiffon3"
    " require'bufferline'.setup{
    "     -- override some options from their defaults
    "     options = {
    "         tab_size = 12,
    "         max_name_length = 40,
    "         show_buffer_close_icons = false,
    "     },
    "     highlights = {
    "         buffer_selected = {
    "             guifg = "Black",
    "             guibg = hlColor,
    "             gui = "bold",
    "         },
    "         -- Accent the split buffer thats not selected
    "         buffer_visible = {
    "             guifg = hlColor,
    "         },
    "     },
    " }
" in the switch source header: section in lua
" -- NOTE: only do this if using bufferline
" local bufnr = require'lspconfig'.util.validate_bufnr(0)
" -- vim.api.nvim_command("bdelete "..tostring(bufnr))
"
" " These commands will honor the custom ordering if you change the order of buffers.
" " The vim commands :bnext and :bprevious will not respect the custom ordering.
" nnoremap <silent><a-l> :BufferLineCycleNext<CR>
" nnoremap <silent><a-h> :BufferLineCyclePrev<CR>
" " These commands will move the current buffer backwards or forwards in the bufferline.
" nnoremap <silent><a-s-l> :BufferLineMoveNext<CR>
" nnoremap <silent><a-s-h> :BufferLineMovePrev<CR>
" These commands will honor the custom ordering if you change the order of buffers.
" The vim commands :bnext and :bprevious will not respect the custom ordering.
" kill buffer tab
" nnoremap <silent> <a-q> :silent! up! <bar> silent! bd!<cr>
