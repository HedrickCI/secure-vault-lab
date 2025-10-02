#!/usr/bin/env bash
DIR="$(pwd)/secure_vault"
SECRETS="$DIR/secrets.txt"
LOGS="$DIR/logs.txt"
KEYS="$DIR/keys.txt"

if [ ! -d "$DIR" ]; then
  echo "Error: $DIR not found. Run vault_setup.sh first."
  exit 1
fi

while true; do
  cat <<MENU

Secure Vault — Menu
1) Add Secret
2) Update Secret
3) Add Log Entry
4) Access Keys
5) Exit
MENU

  read -rp "Choose an option [1-5]: " choice
  case "$choice" in
    1)
      read -rp "Enter secret (single-line): " secret
      if [ -n "$secret" ]; then
        echo "$secret" >> "$SECRETS"
        echo "Secret added."
      else
        echo "No input; nothing added."
      fi
      ;;
    2)
      read -rp "Enter text to find (exact text): " search
      if ! grep -Fq -- "$search" "$SECRETS"; then
        echo "No match found."
      else
        read -rp "Enter replacement text: " replace
        cp "$SECRETS" "${SECRETS}.bak"
        sed -i "s|$search|$replace|g" "$SECRETS"
        echo "Update completed. Backup at ${SECRETS}.bak"
      fi
      ;;
    3)
      read -rp "Enter log message: " msg
      timestamp=$(date '+%F %T')
      echo "[$timestamp] $msg" >> "$LOGS"
      echo "Log entry added."
      ;;
    4)
      echo "ACCESS DENIED 🚫"
      ;;
    5)
      echo "Exiting."
      break
      ;;
    *)
      echo "Invalid option. Choose 1-5."
      ;;
  esac
done

