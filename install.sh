#!/bin/sh
set -ue

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Clone Personal Repos ───────────────────────────────────────────────────
echo "Cloning personal config repos..."

if [ -d "$HOME/.zshconfig" ]; then
  echo "zshconfig already exists, pulling latest..."
  git -C "$HOME/.zshconfig" pull
else
  gh repo clone WadeSeidule/zshconfig "$HOME/.zshconfig"
fi

if [ -d "$HOME/.claude" ]; then
  echo ".claude already exists, pulling latest..."
  git -C "$HOME/.claude" pull
else
  gh repo clone WadeSeidule/.claude "$HOME/.claude"
fi

# ─── Zsh Configuration ──────────────────────────────────────────────────────
# Set up .zshrc to source zshconfig the same way setup.sh does
export ZSH_CONFIG_DIR="$HOME/.zshconfig"
cat > "$HOME/.zshrc" <<EOF
export ZSH_CONFIG_DIR=$HOME/.zshconfig
export PATH=\$ZSH_CONFIG_DIR:\$PATH
source \$ZSH_CONFIG_DIR/zshrc.sh
EOF
echo "Created .zshrc sourcing zshconfig"

echo "Custom Dotfiles Installation Completed"
