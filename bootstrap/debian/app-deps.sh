#!/bin/bash

# Install omz
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh is already installed, skipping..."
fi

# change shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing shell to zsh..."
    sudo chsh -s $(which zsh) $USER
else
    echo "Shell is already zsh, skipping..."
fi

# hack it to think we're using zsh for the installer
export SHELL="/bin/zsh"

# install node + pnpm. https://nodejs.org/en/download
# Download and install nvm:
if ! command -v nvm &> /dev/null; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
else
    echo "nvm is already installed, skipping..."
fi

# Download and install Node.js:
if ! command -v node &> /dev/null; then
    echo "Installing Node.js v22..."
    nvm install 22
else
    echo "Node.js v22 is already installed, skipping..."
fi

# Verify the Node.js version:
node -v # Should print "v22.16.0".
nvm current # Should print "v22.16.0".

# Download and install pnpm:
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    corepack enable pnpm
else
    echo "pnpm is already installed, skipping..."
fi

# Verify pnpm version:
pnpm -v

# install uv
if ! command -v uv &> /dev/null; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # find uv in path
    source ~/.zshrc
else
    echo "uv is already installed, skipping..."
fi

# install podman-compose
if ! command -v podman-compose &> /dev/null; then
    echo "Installing podman-compose..."
    uv tool install podman-compose@latest
else
    echo "podman-compose is already installed, skipping..."
fi

# install hasura cli
if ! command -v hasura &> /dev/null; then
    echo "Installing hasura CLI..."
    curl -L https://github.com/hasura/graphql-engine/raw/stable/cli/get.sh | bash
else
    echo "hasura CLI is already installed, skipping..."
fi

# install pm2
if ! command -v pm2 &> /dev/null; then
    echo "Installing pm2..."
    pnpm install -g pm2
else
    echo "pm2 is already installed, skipping..."
fi
