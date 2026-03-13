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

if [ -d "$CLAUDE_DST/plugins" ] && [ ! -L "$CLAUDE_DST/plugins" ]; then
  mv "$CLAUDE_DST/plugins" "$CLAUDE_DST/plugins.bak"
fi
ln -sf "$CLAUDE_SRC/plugins" "$CLAUDE_DST/plugins"
echo "✓ $CLAUDE_DST/plugins → $CLAUDE_SRC/plugins"
