# Homebrew
export HOMEBREW_NO_ENV_HINTS=1

# pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    prepend_to_path $PYENV_ROOT/bin
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"

	# pyenv-virtualenv
	if [ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
		export PYENV_VIRTUALENV_DISABLE_PROMPT=1
		eval "$(pyenv virtualenv-init -)"
	fi
fi


# nvm
if [ -d "$HOME/.nvm" ]; then
    if [ -z "$NVM_DIR" ]; then
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    fi
fi

# go
export GOPATH="$HOME/.go"
if command -v go &>/dev/null; then
    prepend_to_path $GOPATH/bin
fi

# ruby on macOS
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
	prepend_to_path /opt/homebrew/opt/ruby/bin
	prepend_to_path `gem environment gemdir`/bin
fi
