"AUTHOR: Alessandro Yorba
"SCRIPT: https://github.com/AlessandroYorba/Alduin

"UPDATED: Oct 3, 2018
"CHANGES: Reorganized Code

"Arch Linux Package: George Angelopoulos https://github.com/lathan
"Design Inspiration: Karolis Koncevičius https://github.com/KKPMW
"Design Inspiration: Romain Lafourcade https://github.com/romainl
"UI Contributions: jiyyti https://github.com/jiyyt
"
"SUPPORT:
"256 color terminals, Gui versions of vim, and Termguicolors versions of vim
"
"INSTALL:
" Unix users, place alduin.vim in ~/.vim/colors or /usr/shared/vim/vim80/colors
" Windows users, place alduin.vim in ~\vimfiles\colors
" From your .vimrc add one of the following options
" colorscheme alduin

" ALDUIN:
set background=dark

hi clear
if exists("syntax_on")
	syntax reset
endif

let g:colors_name="alduin"

" COMMON
hi         Normal            ctermfg=187   cterm=NONE
hi         String            ctermfg=222   cterm=NONE        ctermbg=235
hi         PreProc           ctermfg=180   cterm=NONE
hi         Function          ctermfg=95    cterm=NONE
hi         Identifier        ctermfg=109   cterm=NONE
hi         Statement         ctermfg=102   cterm=NONE
hi         Constant          ctermfg=138   cterm=NONE
hi         Type              ctermfg=137   cterm=NONE
hi         Label             ctermfg=102   cterm=NONE
hi         Special           ctermfg=131   cterm=NONE
hi         Operator          ctermfg=102   cterm=NONE
hi         Title             ctermfg=180   cterm=NONE
hi         Conditional       ctermfg=102   cterm=NONE
hi         StorageClass      ctermfg=95    cterm=NONE
hi         htmlStatement     ctermfg=102   cterm=NONE
hi         htmlItalic        ctermfg=180   cterm=NONE
hi         htmlArg           ctermfg=95    cterm=NONE
hi         cssIdentifier     ctermfg=180   cterm=NONE
hi         cssClassName      ctermfg=180   cterm=NONE
hi         Structure         ctermfg=95    cterm=NONE
hi         Typedef           ctermfg=95    cterm=NONE
hi         Repeat            ctermfg=102   cterm=NONE
hi         Keyword           ctermfg=102   cterm=NONE
hi         Exception         ctermfg=102   cterm=NONE
hi         Number            ctermfg=130   cterm=NONE
hi         Character         ctermfg=130   cterm=NONE
hi         Boolean           ctermfg=130   cterm=NONE
hi         Float             ctermfg=130   cterm=NONE
hi         Include           ctermfg=180   cterm=NONE
hi         Define            ctermfg=180   cterm=NONE
hi         Comment           ctermfg=101   cterm=NONE

"WINDOW
hi         MoreMsg           ctermfg=180   cterm=NONE       ctermbg=NONE
hi         VimCommentTitle   ctermfg=101   cterm=reverse    ctermbg=NONE
hi         SpecialComment    ctermfg=101   cterm=reverse    ctermbg=NONE
hi         Underlined        ctermfg=131   cterm=NONE       ctermbg=NONE
hi         Todo              ctermfg=130   cterm=reverse    ctermbg=NONE
hi         Visual            ctermfg=187   cterm=NONE       ctermbg=95
hi         Question          ctermfg=95    cterm=NONE       ctermbg=NONE
hi         Search            ctermfg=187   cterm=NONE       ctermbg=95
hi         MatchParen        ctermfg=102   cterm=reverse    ctermbg=NONE
hi         Error             ctermfg=131   cterm=reverse    ctermbg=233
hi         ErrorMsg          ctermfg=131   cterm=NONE       ctermbg=NONE
hi         WarningMsg        ctermfg=131   cterm=NONE       ctermbg=NONE
hi         Directory         ctermfg=131   cterm=NONE       ctermbg=NONE
hi         Cursor            ctermfg=16    cterm=NONE       ctermbg=187
hi         CursorLineNR      ctermfg=102   cterm=reverse    ctermbg=NONE
hi         WildMenu          ctermfg=187   cterm=NONE       ctermbg=95
hi         ModeMsg           ctermfg=187   cterm=NONE       ctermbg=NONE
hi         Macro             ctermfg=180   cterm=NONE       ctermbg=NONE
hi         PreCondit         ctermfg=180   cterm=NONE       ctermbg=NONE
hi         IncSearch         ctermfg=131   cterm=reverse    ctermbg=NONE
hi         VisualNOS         ctermfg=NONE  cterm=underline  ctermbg=NONE
hi         StatusLine        ctermfg=247   cterm=NONE       ctermbg=235
hi         StatusLineNC      ctermfg=242   cterm=NONE       ctermbg=235
hi         StatusLineTerm    ctermfg=247   cterm=NONE       ctermbg=235
hi         StatusLineTermNC  ctermfg=242   cterm=NONE       ctermbg=235
hi         Pmenu             ctermfg=241   cterm=NONE       ctermbg=235
hi         PmenuSel          ctermfg=187   cterm=NONE       ctermbg=235
hi         PmenuSbar         ctermfg=235   cterm=NONE       ctermbg=235
hi         PmenuThumb        ctermfg=235   cterm=NONE       ctermbg=235
hi         TabLine           ctermfg=242   cterm=NONE       ctermbg=235
hi         TabLineSel        ctermfg=247   cterm=NONE       ctermbg=235
hi         TabLineFill       ctermfg=242   cterm=NONE       ctermbg=235
hi         CursorLine        ctermfg=NONE  cterm=NONE       ctermbg=233
hi         CursorColumn      ctermfg=NONE  cterm=NONE       ctermbg=233
hi         ColorColumn       ctermfg=NONE  cterm=NONE       ctermbg=235
hi         Folded            ctermfg=238   cterm=NONE       ctermbg=233
hi         VertSplit         ctermfg=238   cterm=NONE       ctermbg=234
hi         LineNr            ctermfg=238   cterm=NONE       ctermbg=233
hi         FoldColumn        ctermfg=109   cterm=NONE       ctermbg=234
hi         SignColumn        ctermfg=101   cterm=NONE       ctermbg=233
hi         NonText           ctermfg=236   cterm=NONE       ctermbg=NONE
hi         SpecialKey        ctermfg=236   cterm=NONE       ctermbg=NONE

"DIFF
hi         DiffAdd           ctermfg=30    ctermbg=NONE     cterm=reverse
hi         DiffText          ctermfg=30    ctermbg=NONE     cterm=reverse
hi         DiffChange        ctermfg=23    ctermbg=NONE     cterm=reverse
hi         DiffDelete        ctermfg=131   ctermbg=NONE     cterm=reverse

"SPELLING
hi         SpellBad          ctermfg=196   ctermbg=NONE     cterm=undercurl
hi         SpellLocal        ctermfg=65    ctermbg=NONE     cterm=undercurl
hi         SpellCap          ctermfg=111   ctermbg=NONE     cterm=undercurl
hi         SpellRare         ctermfg=166   ctermbg=NONE     cterm=undercurl
