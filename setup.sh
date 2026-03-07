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
fnm default $(fnm current)
npm install -g yarn

echo "=== Setting up Python (pyenv) ==="
pyenv install -s 3.13
pyenv global 3.13

echo "=== Configuring SSH (agent persistence) ==="
mkdir -p "$HOME/.ssh"
if [ ! -f "$HOME/.ssh/config" ]; then
  cat > "$HOME/.ssh/config" << 'EOF'
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF
  chmod 600 "$HOME/.ssh/config"
fi

echo "=== Configuring git defaults ==="
git config --global init.defaultBranch main
git config --global core.editor nvim

echo "=== Setting up Raycast ==="
echo "Open Raycast, then:"
echo "  - Set hotkey to Cmd+Space"
echo "  - Disable Spotlight: System Settings > Keyboard > Keyboard Shortcuts > Spotlight > uncheck both"

echo ""
echo "========================================="
echo "  Done! Restart your terminal."
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Open Wezterm"
echo "  2. Run: gh auth login"
echo "  3. Generate SSH key:"
echo "     ssh-keygen -t ed25519 -C \"your-email@example.com\""
echo "     cat ~/.ssh/id_ed25519.pub"
echo "     Add to GitHub: Settings > SSH and GPG keys"
echo "  4. Set git identity:"
echo "     git config --global user.name \"Your Name\""
echo "     git config --global user.email \"your-email@example.com\""
