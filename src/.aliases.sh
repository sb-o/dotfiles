cd () {
	builtin cd "$@"; ls;
}
alias cp="cp -i"
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

listinstalled() {
	if command -v "brew" &> /dev/null; then
		echo "\n# brew #\n"
		brew leaves -r
	fi
	if command -v "npm" &> /dev/null; then
		echo "\n# npm #\n"
		npm ls -g
	fi
	if command -v "pip" &> /dev/null; then
		echo "\n# python #\n"
		pip freeze	
	fi
}

pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

_dfi_django_init() { # $1 = projectname, $2 = version
	pyenv virtualenv $2 $1 
	echo "Creating .python-version"
	pyenv local $1
	echo "Installing django and django-stubs"
	pip install django django-stubs
	echo "Initialising project"
	django-admin startproject $1
	echo "Moving .python-version"
	mv .python-version $1/.python-version
	cd $1
	pip freeze > requirements.txt
}

djinit() { # $1 = projectname
	if [[ -z $1 ]] then
		echo "Requires one argument (projectname)"
		return
	fi

	if [ -f '.python-version' ]; then
		echo "Can only run in a directory where .python-version is not already configured"
		return
	fi

	if command -v "pyenv" &> /dev/null; then
		version=$(pyenv version | cut -d' ' -f1)
		echo "Creating virtualenv with version $version. Happy to proceed? [y/N]"
		read continueinput
		continueinput=$(echo "$continueinput" | tr '[:upper:]' '[:lower:]')
		if [[ "$continueinput" = "y" ]] then
			_dfi_django_init $1 $version
		else
			echo "Aborting..."
		fi
	else
		echo "pyenv not installed."
	fi
}
