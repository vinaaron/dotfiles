# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix Mosh truecolor: Mosh doesn't set COLORTERM, so apps like Claude Code
# can't detect truecolor support and fall back to flat colors
[[ "$TERM" == "xterm" ]] && export TERM=xterm-256color
[[ -z "$COLORTERM" ]] && export COLORTERM=truecolor

# home brew
export PATH=/opt/homebrew/bin:$PATH

# Node version manager (fnm — fast, Rust-based replacement for nvm)
eval "$(fnm env --use-on-cd)"

# Auto suggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Pyenv python setup
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=50000
HISTSIZE=50000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh --cmd cd)"

# ---- Tailscale CLI (App Store version) ----
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# yazi move into file last exited on
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Default editor
export EDITOR=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# GNU coreutils (use GNU versions of ls, cat, etc. over macOS defaults)
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# PostgreSQL client
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# ---- fzf (fuzzy finder: Ctrl-R history, Ctrl-T file search) ----
source <(fzf --zsh)

# Machine-specific overrides (not committed)
source ~/.zshrc.local 2>/dev/null
