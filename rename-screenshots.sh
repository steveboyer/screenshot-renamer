#!/bin/zsh

# rename-screenshots.sh
# Watches ~/Screenshots and renames new .png files to replace spaces with underscores.

WATCH_DIR="$HOME/Screenshots"

/opt/homebrew/bin/fswatch -0 --event Created --event Renamed "$WATCH_DIR" | while IFS= read -r -d '' file; do
  # Only process .png files (skip hidden temp files macOS creates)
  if [[ "$file" == *.png ]] && [[ "$(basename "$file")" != .* ]]; then
    dir=$(dirname "$file")
    base=$(basename "$file")
    new_base="${base// /_}"

    if [[ "$base" != "$new_base" ]] && [[ -f "$file" ]]; then
      mv "$file" "$dir/$new_base"
      echo "Renamed: $base -> $new_base"
    fi
  fi
done
