#!/bin/bash

echo "Generating SSH key for GitHub Actions for user github-actions@$HOSTNAME..."

ssh-keygen -t ed25519 -C "github-actions@$HOSTNAME" -f ~/.ssh/id_ed25519 -N ""

echo "Copy the following public key to your GitHub repository's settings:"
cat ~/.ssh/id_ed25519.pub

echo "✅ Go to GitHub → Settings → Deploy keys → Add deploy key, paste it in. Good luck!"
