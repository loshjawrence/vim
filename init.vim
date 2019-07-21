" I am $MYVIMRC for nvim
" Put me in ~/.config/nvim/ on linux and ~\AppData\Local\nvim\ on windows
" make sure colors bundle autoload and all that is in those folders
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
