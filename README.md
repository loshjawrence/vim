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
