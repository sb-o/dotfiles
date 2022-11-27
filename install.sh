BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "source ${BASEDIR}/.aliases" >> $HOME/.zshrc 
echo "source ${BASEDIR}/.aliases" >> $HOME/.bashrc