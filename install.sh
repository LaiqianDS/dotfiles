#!/bin/bash
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_SRC="$DOTFILES_DIR/claude"
CLAUDE_DST="$HOME/.claude"

mkdir -p "$CLAUDE_DST"

files=(CLAUDE.md settings.json statusline.sh)
for f in "${files[@]}"; do
  src="$CLAUDE_SRC/$f"
  dst="$CLAUDE_DST/$f"
  [ -f "$dst" ] && [ ! -L "$dst" ] && mv "$dst" "${dst}.bak"
  ln -sf "$src" "$dst"
  echo "✓ $dst → $src"
done

dirs=(plugins skills)
for d in "${dirs[@]}"; do
  src="$CLAUDE_SRC/$d"
  dst="$CLAUDE_DST/$d"
  if [ -d "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "✓ $dst → $src"
done
