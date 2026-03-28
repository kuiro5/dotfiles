#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Xcode CLI tools — must be installed manually before running this script
if ! xcode-select -p &>/dev/null; then
  echo "ERROR: Xcode CLI tools not installed."
  echo "Run: xcode-select --install, then re-run this script."
  exit 1
fi

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# Packages
echo "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Dotfiles (stow)
for pkg in "$DOTFILES_DIR"/*/; do
  pkg_name=$(basename "$pkg")
  [[ "$pkg_name" == .* ]] && continue
  [[ "$pkg_name" == "obsidian" ]] && continue
  echo "Stowing $pkg_name..."
  if ! stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg_name"; then
    echo "  Warning: conflict in $pkg_name — run 'stow -n --dir=$DOTFILES_DIR --target=$HOME $pkg_name' to inspect"
  fi
done

# Obsidian vimrc — stow isn't used here because the targets are dynamic (one per vault).
# ln -sf is used to link the single source file into each vault directory.
VIMRC="$DOTFILES_DIR/obsidian/.obsidian.vimrc"
if [[ -d "$HOME/obsidian" ]]; then
  for vault in "$HOME/obsidian"/*/; do
    [[ -d "$vault" ]] || continue
    ln -sf "$VIMRC" "$vault.obsidian.vimrc"
    echo "Linked .obsidian.vimrc -> $vault"
  done
fi

# TPM
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# Neovim plugins
if command -v nvim &>/dev/null; then
  echo "Syncing Neovim plugins..."
  nvim --headless "+Lazy! sync" +qa || true
fi

# macOS defaults
echo "Applying macOS defaults..."
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
killall Dock Finder || true

# Verify symlinks
echo "Verifying symlinks..."
verify() {
  local targets=(
    "$HOME/.zshrc"
    "$HOME/.gitconfig"
    "$HOME/.config/nvim/init.lua"
    "$HOME/.tmux.conf"
    "$HOME/.config/alacritty/alacritty.toml"
  )
  local ok=true
  for f in "${targets[@]}"; do
    if [[ -L "$f" ]]; then
      echo "  ok: $f"
    else
      echo "  MISSING: $f"
      ok=false
    fi
  done
  $ok || echo "Warning: some symlinks are missing — check above."
}
verify

echo "Done."
