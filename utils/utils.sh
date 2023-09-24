prepend_to_path() { # $1 = directory
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

rld() {
  if grep -q "utils/utils.sh" $HOME/.zshrc; then
    echo "🌀 Reloading zsh shell"
    source $HOME/.zshrc
  elif grep -q "utils/utils.sh" $HOME/.bashrc; then
    echo "🌀 Reloading bash shell"
    source $HOME/.bashrc
  fi
}