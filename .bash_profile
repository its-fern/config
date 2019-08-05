#!/bin/bash

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

eval "$(rbenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"

export PATH
export PATH="/usr/local/sbin:$PATH" # For homebrew
