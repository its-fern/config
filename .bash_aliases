# alias ls='ls --color=auto -F'
# alias grep='grep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias less="less -R "

alias ..="cd .."
alias r='rails'
alias h='heroku'

alias ber_local='bundle exec rails s'

alias rcts='bundle exec rails console test --sandbox'
alias rct='bundle exec rails console test'

alias rcds='bundle exec rails console development --sandbox'
alias rcd='bundle exec rails console development'

alias bers='bundle exec rspec'

alias fix='stty sane' # Fixes broken terminal
alias fix_dock='killall Dock' # Fixes dock (when gestures don't work)
alias fix_defaults='find /System/Library/Frameworks -type f -name "lsregister" -exec {} -kill -seed -r \;' # Fixes when you can't set program defaults
