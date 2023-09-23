# pyenv
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    prepend_to_path $PYENV_ROOT/bin
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# pyenv-virtualenv
if [ -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv virtualenv-init -)"
fi

# nvm
if [ -d "$HOME/.nvm" ]; then
    if [ -z "$NVM_DIR" ]; then
        export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

        # Calling nvm use automatically in a directory with a .nvmrc file
        autoload -U add-zsh-hook

        load-nvmrc() {
        local nvmrc_path
        nvmrc_path="$(nvm_find_nvmrc)"

        if [ -n "$nvmrc_path" ]; then
            local nvmrc_node_version
            nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

            if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
            elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
            nvm use
            fi
        elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
            echo "Reverting to nvm default version"
            nvm use default
        fi
        }

        add-zsh-hook chpwd load-nvmrc
        load-nvmrc
    fi
fi
