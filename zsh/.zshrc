# Neovim
alias vim="nvim"
alias v="nvim"

# Git
alias g="git"

# Claude
alias c="claude --dangerously-skip-permissions"

# ASDF
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Z
. /opt/homebrew/etc/profile.d/z.sh

# PATH
export PATH=$HOME/.local/bin:$PATH

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pure prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
