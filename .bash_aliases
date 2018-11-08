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

alias ber='bundle exec rails'

alias rcts='ber console test --sandbox'
alias rct='ber console test'

alias rcds='ber console development --sandbox'
alias rcd='ber console development'

alias bers='bundle exec rspec'

alias fix='stty sane' # Fixes broken terminal
alias fix_dock='killall Dock' # Fixes dock (when gestures don't work)
alias fix_defaults='find /System/Library/Frameworks -type f -name "lsregister" -exec {} -kill -seed -r \;' # Fixes when you can't set program defaults

alias dos2unix="sed -e 's/\r$//'"
