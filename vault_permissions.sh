#!/usr/bin/env bash
DIR="$(pwd)/secure_vault"
if [ ! -d "$DIR" ]; then
  echo "Error: $DIR not found. Run vault_setup.sh first."
  exit 1
fi
update_perm() {
  local file="$1"
  local def="$2"
  local path="$DIR/$file"
  echo
  echo "File: $file"
  ls -l "$path"
  read -rp "Change permission for $file? (y/N) [Enter = apply default $def]: " choice
  if [ -z "$choice" ]; then
    chmod "$def" "$path"
    echo "Default permission $def applied to $file"
    return
  fi
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    read -rp "Enter new permission (e.g. 600) [Enter = default $def]: " perm
    if [ -z "$perm" ]; then perm="$def"; fi
    if [[ ! "$perm" =~ ^[0-7]{3}$ ]]; then
      echo "Invalid permission '$perm' — skipping change."
      return
    fi
    chmod "$perm" "$path"
    echo "Permission for $file set to $perm"
  else
    echo "Leaving permission for $file unchanged."
  fi
}
update_perm "keys.txt" "600"
update_perm "secrets.txt" "640"
update_perm "logs.txt" "644"
echo
echo "Final permissions:"
ls -l "$DIR"

