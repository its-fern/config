
# ~/.bashrc: executed by bash(1) for interactive shells.

# User dependent .bashrc file

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\W\[\e[0m\]\$(parse_git_branch)\n\$ "

# HOME="HOME"; export VARNAME

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

export PGSSLMODE="prefer"

# Drop local postgres test and development databases and resync with prod follower snapshots
dbresync() {
    echo "Resyncing local development and test databases with follower instances..."
    FILENAME=$1
    RAILS_ENV=development bundle exec rake db:drop db:create db:structure:load
    pg_restore -vcOx -h localhost -d $2 -j $(sysctl -n hw.ncpu) $FILENAME
    RAILS_ENV=development bundle exec rake db:migrate
    bundle exec rake db:test:prepare
    rm $FILENAME
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export -f dbresync

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export PYTHONSTARTUP=~/.pythonrc
export HOMEBREW_GITHUB_API_TOKEN= <>

# For GOBA https://github.com/blueapron/goba
export GITHUB_API_TOKEN= <>

export EDITOR='code'
export BUNDLE_ENTERPRISE__CONTRIBSYS__COM= <>
export GEMFURY_TOKEN= <>

# For CLS
export CONTRIBSYS_TOKEN= <>
