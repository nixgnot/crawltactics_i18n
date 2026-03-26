#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

find "$SCRIPT_DIR" -type f -name "*.properties" | while read -r file; do
  if grep -q '\\u[0-9A-Fa-f]\{4\}' "$file"; then
    echo "Converting: $file"
    perl -CS -pe 's/\\u([0-9A-Fa-f]{4})/chr(hex($1))/eg' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  else
    echo "Skipping (no unicode escapes): $file"
  fi
done

echo "Done."
