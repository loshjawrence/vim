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

