#!/bin/bash

echo "Generating SSH key for GitHub Actions for user github-actions@$HOSTNAME..."

ssh-keygen -t ed25519 -C "github-actions@$HOSTNAME" -f ~/.ssh/id_ed25519 -N ""

cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

echo "Copy the following public key to your GitHub repository's settings:"
cat ~/.ssh/id_ed25519.pub

echo "✅ Go to GitHub → Settings → Deploy keys → Add deploy key, paste it in. Good luck!"

echo "✅ Go to GitHub → Settings → Secrets and variables → Actions → New repository secret"
echo "Then, add the private key to the github actions as a secret for the SSH_PRIVATE_KEY variable by running:"
echo "less ~/.ssh/id_ed25519"
