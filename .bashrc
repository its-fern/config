
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

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export PYTHONSTARTUP=~/.pythonrc
export HOMEBREW_GITHUB_API_TOKEN=<FILL_IN>
