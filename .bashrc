#!/usr/bin/env bash

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Python virtualenv helper
virtualenv_info(){
  # Get Virtual Env
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out the path and just leave the env name
    venv="${VIRTUAL_ENV##*/}"
  else
    # In case you don't have one activated
    venv=''
  fi
  [[ -n "$venv" ]] && echo "(venv:$venv) "
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h: \[\e[33m\]\W\[\e[0m\]\$(parse_git_branch) \$(virtualenv_info)\n\$ "

# HOME="HOME"; export VARNAME

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
  source "${HOME}/.bash_aliases"
fi

if [ -f ~/.git-completion.bash ]; then
  source "${HOME}/.git-completion.bash"
fi

psl() {
  psql "$LOCAL_DATABASE_URL"
}

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export PYTHONSTARTUP=~/.pythonrc
export HOMEBREW_GITHUB_API_TOKEN=''

export EDITOR='code'

# Specify data folder fot the databases (maybe necessary)
# export PGDATA='/usr/local/var/postgresql@9.6/'
export PGSSLMODE="prefer"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# export LOCAL_DATABASE_URL=postgres://postgres:postgres@localhost:5432/postgres
