# Dotfiles

Personal dev environment: wezterm + zsh + tmux + neovim.

## New Mac Setup

```bash
# 1. Install Xcode Command Line Tools
xcode-select --install

# 2. Clone this repo
git clone https://github.com/ce20480/dotfiles.git ~/dotfiles

# 3. Run setup
cd ~/dotfiles && chmod +x setup.sh && ./setup.sh

# 4. Restart terminal. Open Wezterm.

# 5. Authenticate GitHub + generate SSH key
gh auth login    # choose SSH > generate key > set passphrase > name device

# 6. Set up Raycast
# Open Raycast > Set hotkey to Cmd+Space
# System Settings > Keyboard > Keyboard Shortcuts > Spotlight > uncheck both

# 7. Verify everything works
~/dotfiles/test.sh
```

## What's Included

| Category | Tools |
|----------|-------|
| Terminal | Wezterm (GPU-accelerated, Lua config) |
| Shell | Zsh + Powerlevel10k + autosuggestions + syntax highlighting |
| Editor | Neovim ([ce20480/nvim](https://github.com/ce20480/nvim)) |
| Multiplexer | tmux ([ce20480/Tmux](https://github.com/ce20480/Tmux)) |
| CLI | eza, zoxide, fzf, yazi, ripgrep, lazygit, jq |
| Languages | pyenv (Python), fnm (Node), uv |
| Dev | awscli, azure-cli, supabase, libpq (psql), gh, OrbStack |
| Apps | 1Password, Raycast, Slack, Tailscale |

## What setup.sh Does

1. Installs Homebrew
2. Installs all packages from Brewfile
3. Symlinks configs (.zshrc, .wezterm.lua, .p10k.zsh, .zshenv) to home directory
4. Clones nvim + tmux configs
5. Installs Node LTS via fnm + yarn
6. Installs Python 3.13 via pyenv
7. Creates SSH config (agent persistence with macOS Keychain)
8. Sets git defaults (default branch: main, editor: nvim)

## Machine-Specific Overrides

Create `~/.zshrc.local` for anything specific to one machine (not committed):

```bash
# Example: work-specific settings
export SOME_API_KEY="value"
alias myalias="/path/to/script.sh"
```

## SSH

`gh auth login` generates the SSH key and uploads it to GitHub. setup.sh creates `~/.ssh/config` with macOS Keychain persistence so you only enter the passphrase once per reboot.
