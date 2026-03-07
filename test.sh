#!/bin/zsh

echo "=== Dotfiles Health Check ==="
echo ""

# Initialize fnm so node/npm/yarn are in PATH
eval "$(fnm env)" 2>/dev/null

pass=0
fail=0

check() {
  if eval "$2" &>/dev/null; then
    echo "  OK  $1"
    ((pass++))
  else
    echo "  FAIL  $1"
    ((fail++))
  fi
}

echo "Core (setup.sh + Brewfile):"
check "node (fnm)"        "node --version"
check "npm"               "npm --version"
check "yarn"              "yarn --version"
check "python (pyenv)"    "pyenv version"
check "uv"                "uv --version"
check "neovim"            "nvim --version"
check "eza (ls alias)"    "command -v eza && grep -q 'alias ls.*eza' ~/.zshrc"
check "zoxide (cd)"       "command -v zoxide && grep -q 'zoxide init' ~/.zshrc"
check "fzf"               "fzf --version"
check "ripgrep"           "rg --version"
check "lazygit"           "lazygit --version"
check "jq"                "jq --version"
check "psql"              "psql --version"
check "aws cli"           "aws --version"
check "gh cli"            "gh --version"
check "git"               "git --version"
check "EDITOR=nvim"       "[ \"$EDITOR\" = 'nvim' ]"

echo ""
echo "SSH:"
check "SSH key exists"    "[ -f ~/.ssh/id_ed25519 ]"
check "GitHub SSH auth"   "ssh -T git@github.com 2>&1 | grep -q 'successfully authenticated'"

echo ""
echo "---"
echo "$pass passed, $fail failed"
