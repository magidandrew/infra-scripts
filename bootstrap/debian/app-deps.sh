#!/bin/bash

# Install omz
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# change shell to zsh
echo "Changing shell to zsh..."
sudo chsh -s $(which zsh) $USER

# install node + pnpm. https://nodejs.org/en/download
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.16.0".
nvm current # Should print "v22.16.0".

# Download and install pnpm:
corepack enable pnpm

# Verify pnpm version:
pnpm -v

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# find uv in path
source ~/.zshrc

# install podman-compose
uv tool install podman-compose@latest

# install hasura cli
curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash