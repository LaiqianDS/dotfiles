#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
home="$HOME"
display_cwd=$(echo "$cwd" | sed "s|^$home|~|")

if [ -n "$used" ] && [ -n "$ctx_size" ]; then
  used_int=$(echo "$used" | awk '{printf "%d", $1}')
  tokens_fmt=$(echo "$used_int $ctx_size" | awk '{
    used_k = int($1 / 100 * $2 / 1000)
    max_k = int($2 / 1000)
    printf "%dk / %dk", used_k, max_k
  }')
  printf "❯ %s  ◆ %s  ctx: %s%% (%s)" "$display_cwd" "$model" "$used_int" "$tokens_fmt"
elif [ -n "$used" ]; then
  used_int=$(echo "$used" | awk '{printf "%d", $1}')
  printf "❯ %s  ◆ %s  ctx: %s%%" "$display_cwd" "$model" "$used_int"
else
  printf "❯ %s  ◆ %s" "$display_cwd" "$model"
fi
