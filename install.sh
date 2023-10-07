#!/bin/bash
BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CONFIGFILE=$HOME/.zshrc
PLUGINSDIR=$HOME/.zsh_plugins
NEOVIMDIR=$HOME/.config/nvim

# Create CONFIGFILE and PLUGINSDIR if don't already exist
if [ ! -f $CONFIGFILE ]; then
	touch $CONFIGFILE
fi
if [ ! -d $PLUGINSDIR ]; then
	mkdir $PLUGINSDIR
fi

# Add utils to the start of the CONFIG file
if ! grep -q "source $BASEDIR/utils/utils.sh" $CONFIGFILE; then
	echo "source $BASEDIR/utils/utils.sh" | cat - $CONFIGFILE > temp && mv temp $CONFIGFILE
fi

# Add all files in the source folder to the CONFIGFILE
_dfi_add_source() { # $1 = file
	if ! grep -q "source $1" $CONFIGFILE; then
		echo "source $1" >> $CONFIGFILE
	fi
}
for f in $(find $BASEDIR/src -maxdepth 1 -type f); do
	if [ -f "$f" ]; then
		_dfi_add_source $f
	fi
done


# Add symlink
_dfi_create_symlink() { # $1 = dotfiles source, $2 = home source
	if [ -L $2 ] ; then
		if [ -e $2 ] ; then
			: # Link already installed
		else
			mv $2 "$2-backup2"
			ln -s $1 $2
			echo "Broken link repaired $2"
		fi
	elif [ -e $2 ] ; then
		mv $2 "$2-backup"
		ln -s $1 $2
	else
		ln -s $1 $2
	fi
}

_dfi_create_symlink $BASEDIR/nvim $NEOVIMDIR

for f in $(find $BASEDIR/conf -maxdepth 1 -type f); do
	if [ -f "$f" ]; then
		_dfi_create_symlink $f "$HOME/$(basename $f)"
	fi
done



# Install and source plugins
_dfi_install_and_source() { # $1 = plugin, $2 = repo, $3 = file
	# Install
	if [ ! -d "$PLUGINSDIR/$1" ]; then
		git clone $2 $PLUGINSDIR/$1
	fi

	# Source
	if ! grep -q "source $PLUGINSDIR/$1/$3" $CONFIGFILE; then
		echo "source $PLUGINSDIR/$1/$3" >> $CONFIGFILE
	fi
}

_dfi_install_and_source .zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting.zsh
_dfi_install_and_source .zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions.zsh

