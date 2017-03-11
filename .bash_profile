
# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

eval "$(rbenv init -)"
eval "$(nodenv init -)"

export PATH
