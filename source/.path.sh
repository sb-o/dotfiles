# Declare function to prepend to PATH
prepend_to_path() { # $1 = directory
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

prepend_to_path $HOME/.local/bin