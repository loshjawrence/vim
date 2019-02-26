# Vim Backup
* To install a plugin cd to vimfiles/bundle then git clone the repo and add whatever they say to the _vimrc
  * cp vimfiles and _vimrc to home dir (windows: C:/Users/userName or ~/)
  * Note the github location in vimfiles/bundle and commit and push if it is fast and actually solves a problem or serves a need
# How to profile to find a slow plugin

  * Start-up:
vim --startuptime startup.report

  * Executing things:
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!

# How to find slow vimrc override
  * For vimrc slowness, binary search comment until you find something, repeat
