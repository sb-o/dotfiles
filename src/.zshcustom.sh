PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
export HISTORY_IGNORE="(*ls*|*cat*|*AWS*|*SECRET*|*export*|*TOKEN*|*PASSWORD*)"
export HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="(cd *|ls *|rm *|pwd)"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,bold,underline"