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

