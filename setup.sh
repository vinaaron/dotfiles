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

echo "=== Configuring git ==="
git config --global init.defaultBranch main
git config --global core.editor nvim
if [ -z "$(git config --global user.name)" ]; then
  read -p "Git name: " git_name
  git config --global user.name "$git_name"
fi
if [ -z "$(git config --global user.email)" ]; then
  read -p "Git email: " git_email
  git config --global user.email "$git_email"
fi

echo "=== Configuring SSH (Keychain persistence) ==="
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

chmod +x "$DOTFILES_DIR/test.sh"

echo ""
echo "========================================="
echo "  Setup complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo ""
echo "  1. Close Terminal and open Wezterm"
echo ""
echo "  2. Authenticate GitHub + generate SSH key:"
echo "     gh auth login"
echo "       > Account:      GitHub.com"
echo "       > Protocol:     SSH"
echo "       > Generate key: Yes"
echo "       > Passphrase:   (enter one)"
echo "       > Title:        (name your device)"
echo "       > Browser:      Yes"
echo ""
echo "  3. Set up Raycast:"
echo "     - Open Raycast > Set hotkey to Cmd+Space"
echo "     - System Settings > Keyboard > Keyboard Shortcuts"
echo "       > Spotlight > uncheck both"
echo ""
echo "  4. Verify:"
echo "     $DOTFILES_DIR/test.sh"
