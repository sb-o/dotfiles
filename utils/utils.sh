prepend_to_path() { # $1 = directory
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

rld() {
  if grep -q "utils/utils.sh" $HOME/.zshrc; then
    echo "🌀 Reloading zsh shell"
    source $HOME/.zshrc
  else
      echo "Reloading zsh shell. dotfiles not installed."
    source $HOME/.zshrc
  fi
}