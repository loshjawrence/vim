#### How to profile to find a slow plugin

  * Start-up:
vim --startuptime startup.report

  * Executing things:
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!

copy .bash* and .vimrc into home dir
follow installSteps.txt

For windows terminal settings, copy LocalState/settings.json to ~/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json

Windows terminal shortcuts:
ctrl+/- zoom
alt+shift+d creates a split based on the current split's aspect ratio
alt+arrow split navigation
alt+shift+arrow grow split
ctrl+tab cycle fwd through tabs
ctrl+shift+tab cycle bwd through tabs
ctrl+, edit settings.json
