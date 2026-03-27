#!/bin/sh
set -ue

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Trust GitHub SSH Host Key ───────────────────────────────────────────────
mkdir -p "$HOME/.ssh"
ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null

# ─── Clone Personal Repos ───────────────────────────────────────────────────
echo "Cloning personal config repos..."

rm -rf "$HOME/.zshconfig"
gh repo clone WadeSeidule/zshconfig "$HOME/.zshconfig"

rm -rf "$HOME/.claude"
gh repo clone WadeSeidule/.claude "$HOME/.claude"

# ─── Zsh Configuration ──────────────────────────────────────────────────────
# Set up .zshrc to source zshconfig the same way setup.sh does
export ZSH_CONFIG_DIR="$HOME/.zshconfig"
cat > "$HOME/.zshrc" <<EOF
export ZSH_CONFIG_DIR=$HOME/.zshconfig
export PATH=\$ZSH_CONFIG_DIR:\$PATH
source \$ZSH_CONFIG_DIR/zshrc.sh
EOF
echo "Created .zshrc sourcing zshconfig"

# ─── Git Configuration ───────────────────────────────────────────────────
"$ZSH_CONFIG_DIR/scripts/gitconfig.sh"

echo "Custom Dotfiles Installation Completed"
