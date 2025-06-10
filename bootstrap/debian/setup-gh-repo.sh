#!/bin/bash

ssh-keygen -t ed25519 -C "github-actions@$HOSTNAME" -f ~/.ssh/id_ed25519 -N ""

echo "Copy the following public key to your GitHub repository's settings:"
cat ~/.ssh/id_ed25519.pub

read -p "Press Enter to continue"

echo "✅ Go to GitHub → Settings → SSH and GPG keys → New SSH key, paste it in. Good luck!"
