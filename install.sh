#!/bin/sh
set -ue

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Trust GitHub SSH Host Key ───────────────────────────────────────────────
mkdir -p "$HOME/.ssh"
ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null

# ─── Clone Personal Repos ───────────────────────────────────────────────────
echo "Cloning personal config repos..."

rm -rf "$HOME/.zshconfig"
git clone git@github.com:WadeSeidule/zshconfig.git "$HOME/.zshconfig"

rm -rf "$HOME/.claude"
git clone git@github.com:WadeSeidule/.claude.git "$HOME/.claude"

# ─── Zsh Configuration ──────────────────────────────────────────────────────
export ZSH_CONFIG_DIR="$HOME/.zshconfig"
export PATH="$ZSH_CONFIG_DIR:$PATH"
zc setup

# ─── Activate Nextdoor Work Config ───────────────────────────────────────────
zc workconfig activate nextdoor

# ─── Git Configuration ───────────────────────────────────────────────────
"$ZSH_CONFIG_DIR/scripts/gitconfig.sh"

echo "Custom Dotfiles Installation Completed"
exec zsh
