#!/bin/zsh

echo "=== Dotfiles Health Check ==="
echo ""

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

echo "Core (dotfiles .zshrc):"
check "node (fnm)"        "node --version"
check "npm"               "npm --version"
check "yarn"              "yarn --version"
check "python (pyenv)"    "pyenv version"
check "uv"                "uv --version"
check "neovim"            "nvim --version"
check "eza (ls alias)"    "type ls | grep -q eza"
check "zoxide (cd)"       "type cd | grep -q function"
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
echo "Personal (.zshrc.local):"
check "notify function"   "type notify | grep -q function"
check "phone-log alias"   "type phone-log | grep -q alias"
check "bun"               "bun --version"
check "JAVA_HOME set"     "[ -n \"$JAVA_HOME\" ]"

echo ""
echo "SSH:"
check "SSH key exists"    "[ -f ~/.ssh/id_ed25519 ]"
check "GitHub SSH auth"   "ssh -T git@github.com 2>&1 | grep -q 'successfully authenticated'"

echo ""
echo "---"
echo "$pass passed, $fail failed"
