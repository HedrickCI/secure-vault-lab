#!/usr/bin/env bash

DIR="$(pwd)/secure_vault"

mkdir -p "$DIR"

echo "Welcome to the Secure Vault — keys file." > "$DIR/keys.txt"
echo "Welcome to the Secure Vault — secrets file." > "$DIR/secrets.txt"
echo "Welcome to the Secure Vault — logs file." > "$DIR/logs.txt"

echo "Secure vault initialized at: $DIR"
ls -l "$DIR"

