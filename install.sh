#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run brew bundle if Brewfile exists
if command -v brew >/dev/null 2>&1 && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "🍺 Running brew bundle..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# Stow all packages (all non-hidden dirs in repo)
for pkg in "$DOTFILES_DIR"/*/; do
  # Remove trailing slash and get basename
  pkg_name=$(basename "$pkg")
  # Ignore hidden or special folders if any
  [[ "$pkg_name" == .* ]] && continue

  echo "🔗 Stowing $pkg_name..."
  stow --dir="$DOTFILES_DIR" --target="$HOME" "$pkg_name"
done

echo "✅ Done."


