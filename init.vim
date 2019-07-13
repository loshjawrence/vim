" I am $MYVIMRC for nvim
" Put me in ~/.config/nvim/ on linux and ~\AppData\Local\nvim\ on windows
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
