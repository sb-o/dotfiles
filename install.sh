BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if ! grep -q "source ${BASEDIR}/.aliases" $HOME/.zshrc; then
    echo "source ${BASEDIR}/.aliases" >> $HOME/.zshrc
fi

if ! grep -q "source ${BASEDIR}/.aliases" $HOME/.bashrc; then
    echo "source ${BASEDIR}/.aliases" >> $HOME/.bashrc
fi

if ! grep -q "source ${BASEDIR}/.zshcustom" $HOME/.zshrc; then
    echo "source ${BASEDIR}/.zshcustom" >> $HOME/.zshrc
fi

if [ ! -d "$HOME/.zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.zsh-syntax-highlighting
fi

if ! grep -q "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ${ZDOTDIR:-$HOME}/.zshrc; then
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

if [ ! -d "$HOME/.zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh-autosuggestions
fi

if ! grep -q "source $HOME/.zsh-autosuggestions/zsh-autosuggestions.zsh" ${ZDOTDIR:-$HOME}/.zshrc; then
    echo "source $HOME/.zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
fi

