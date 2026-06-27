# Neovim
alias vim="nvim"
alias v="nvim"

# Git
alias g="git"

# Claude
alias c="claude"
alias cdsp="claude --dangerously-skip-permissions"

alias ls="ls -al"

# PATH
export PATH=$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/env:$PATH

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

# Load local settings
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
