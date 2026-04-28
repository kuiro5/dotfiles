# Neovim
alias vim="nvim"
alias v="nvim"

# Git
alias g="git"

# Claude
alias c="claude --dangerously-skip-permissions"

alias ls="ls -al"

# PATH
export PATH=$HOME/.local/bin:$PATH

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Load local settings
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
