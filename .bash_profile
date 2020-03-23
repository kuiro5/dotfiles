# SHARED_BASH_PROFILE=$HOME/code/dotfiles/.bash_profile
# if [ -f $SHARED_BASH_PROFILE ]; then
   #. $SHARED_BASH_PROFILE
# fi

# Vim
alias vim="nvim"
alias v="vim"

# Git
alias g='git'

# Personal Navigation
alias bp="vim ~/.bash_profile"
alias src="source ~/.bash_profile"

# Notes
alias notes="cd ~/notes && vim"

export TERM=xterm-256color-italic
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export EDITOR='nvim'
