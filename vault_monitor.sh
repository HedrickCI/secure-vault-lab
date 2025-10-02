#!/usr/bin/env bash
DIR="$(pwd)/secure_vault"
REPORT="$DIR/vault_report.txt"

if [ ! -d "$DIR" ]; then
  echo "Error: $DIR not found. Run vault_setup.sh first."
  exit 1
fi

: > "$REPORT"

for f in "$DIR"/keys.txt "$DIR"/secrets.txt "$DIR"/logs.txt; do
  if [ ! -e "$f" ]; then
    echo "File missing: $(basename "$f")" | tee -a "$REPORT"
    continue
  fi

  name=$(basename "$f")
  size=$(stat -c%s "$f")
  mtime=$(stat -c%y "$f")
  perm=$(stat -c%a "$f")

  {
    echo "File: $name"
    echo "Size: $size bytes"
    echo "Last modified: $mtime"
    echo "Permissions: $perm"
    if [ "$perm" -gt 644 ]; then
      echo "⚠️ SECURITY RISK DETECTED"
    fi
    echo "--------------------------"
  } >> "$REPORT"
done

echo "Vault report created at: $REPORT"
ls -l "$REPORT"

