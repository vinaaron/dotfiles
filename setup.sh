#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Installing Homebrew ==="
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "=== Installing packages from Brewfile ==="
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "=== Symlinking configs ==="
ln -sf "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "=== Cloning editor & tmux configs ==="
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/ce20480/nvim.git "$HOME/.config/nvim"
else
  echo "nvim config already exists, skipping"
fi

if [ ! -d "$HOME/.config/tmux" ]; then
  git clone https://github.com/ce20480/Tmux.git "$HOME/.config/tmux"
else
  echo "tmux config already exists, skipping"
fi

echo "=== Setting up Node (fnm) ==="
eval "$(fnm env)"
fnm install --lts
fnm default lts-latest
npm install -g yarn

echo "=== Setting up Python (pyenv) ==="
pyenv install -s 3.13
pyenv global 3.13

echo ""
echo "========================================="
echo "  Done! Restart your terminal."
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Open Wezterm"
echo "  2. Run: gh auth login"
echo "  3. Run: ssh-keygen -t ed25519 -C \"your-email@example.com\""
echo "     Then add ~/.ssh/id_ed25519.pub to GitHub"
