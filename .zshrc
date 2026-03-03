# Vim
alias vim="nvim"
alias v="vim"

# Git
alias g='git'

# Personal Navigation
alias bp="vim ~/.bash_profile"
alias src="source ~/.bash_profile"

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Autocompletion
autoload -U compinit; compinit

export PLAID_PATH="$HOME/plaid"
export GO111MODULE=on
export GOPROXY=https://proxy.golang.org
export GOPRIVATE=github.plaid.com
export PATH="$PLAID_PATH/go.git:$PLAID_PATH/go.git/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
