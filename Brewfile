# Brewfile for Neovim and related tooling

# Core packages
brew "stow"
brew "neovim"             # Latest Neovim
brew "ripgrep"            # Required for Telescope live_grep
brew "fd"                 # Faster alternative to find, used by Telescope
brew "git"                # Needed for lazy.nvim and plugin cloning
brew "lua-language-server" # LSP for Lua
brew "go"                 # Go tools including gopls
brew "tree-sitter"        # For better syntax highlighting, used by some Neovim plugins
brew "fzf"                # Optional fuzzy finder integration
brew "stylua"             # Lua code formatter (optional)
brew "shfmt"              # Shell script formatter (optional)
brew "tmux"
brew "tree"
brew "zoxide"

# Font for better icon support in bufferline/lualine
cask "font-hack-nerd-font"
cask "alacritty", no_quarantine: true

# Node is sometimes needed for LSPs or formatters
brew "node"

# Python can be useful for other Neovim plugins
brew "python"
