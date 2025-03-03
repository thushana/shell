#!/bin/zsh
set -e

SRC="$HOME/.zshrc"
DEST="$HOME/Code/shell/.zshrc"

# Copy the .zshrc file to the repo
cp "$SRC" "$DEST"

# Navigate to repo
cd "$HOME/Code/shell"

# Check if there are changes
if git diff --quiet && git diff --staged --quiet; then
    echo "No changes to commit."
    exit 0
fi

# Commit and push
git add .zshrc
git commit -m "UPDATE – .zshrc on $(date)"
git push origin main

echo "✅ .zshrc updated and pushed!"
