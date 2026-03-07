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

# 5. Authenticate GitHub
gh auth login
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
| Dev | awscli, libpq (psql), gh, OrbStack |
| Apps | Raycast (Spotlight replacement) |

## Machine-Specific Overrides

Create `~/.zshrc.local` for anything specific to one machine (not committed):

```bash
# Example: personal project aliases
alias phone-log="/path/to/some/script.sh"
export SOME_API_KEY="value"
```

## SSH Key (for new machines)

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
cat ~/.ssh/id_ed25519.pub
# Add to GitHub: Settings > SSH and GPG keys > New SSH key
```
