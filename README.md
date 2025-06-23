# Infrastructure Scripts

🚀 **Automated bootstrap scripts for setting up development environments and infrastructure tools**

This repository contains opinionated, production-ready scripts to quickly bootstrap development environments with modern tooling. Perfect for setting up new servers, development machines, or CI/CD environments.

## 🎯 What This Does

Transform a fresh Debian/Ubuntu system into a fully-configured development environment with:

- **🐳 Container Runtime**: Podman with rootless configuration and proper storage drivers
- **⚡ Shell Enhancement**: Oh My Zsh with optimized configuration
- **🛠️ Development Tools**: Node.js, Python tooling, and package managers
- **🔐 Security**: SSH key generation and proper container security
- **🌐 Networking**: Smart port redirection for web development

## Missing
1. Corepack asks for install when running `pnpm`
2. Need to configure aws cli credentials on the machine
3. Need to copy in the .ssh pubkey to authorized_keys and then add the private key to the github actions as a secret for the `SSH_PRIVATE_KEY` variabl$$e

## 🚀 Quick Start

### One-Line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/magidandrew/infra-scripts/main/bootstrap/debian/main.sh | bash
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/magidandrew/infra-scripts.git
cd infra-scripts

# Run individual components
./bootstrap/debian/podman_install.sh
./bootstrap/debian/app-deps.sh
./bootstrap/debian/setup-gh-repo.sh
```

## 📦 What Gets Installed

### Container Platform
- **Podman** - Docker-compatible container runtime
- **Podman Compose** - Container orchestration
- **Fuse-overlayfs** - Efficient storage driver
- **Rootless configuration** - Enhanced security

### Development Environment
- **Oh My Zsh** - Enhanced shell with plugins and themes
- **Node.js 22** - Latest LTS via NVM
- **pnpm** - Fast, disk space efficient package manager
- **uv** - Modern Python package installer
- **Hasura CLI** - GraphQL development tools

### System Configuration
- **Container registries** - Docker Hub, GHCR, Quay pre-configured
- **Port redirection** - 80→8080, 443→8443 for rootless containers
- **User lingering** - Persistent services without login
- **SSH keys** - Ed25519 keys for GitHub integration

## 🔧 Individual Scripts

### `podman_install.sh`
Sets up Podman container runtime with production-ready configuration:
- Installs Podman and dependencies
- Configures overlay storage driver
- Sets up container registries
- Enables rootless containers
- Configures port redirection

### `app-deps.sh`
Installs modern development tools:
- Oh My Zsh shell enhancement
- Node.js with NVM
- pnpm package manager
- Python uv tool
- Hasura CLI

### `setup-gh-repo.sh`
Generates SSH keys for GitHub integration:
- Creates Ed25519 SSH key pair
- Provides instructions for GitHub setup
- Hostname-based key naming

## 🎯 Use Cases

- **🖥️ New Server Setup** - Bootstrap fresh cloud instances
- **👨‍💻 Developer Onboarding** - Standardize development environments
- **🔄 CI/CD Environments** - Consistent build/deploy environments
- **🧪 Testing** - Reproducible test environments

## 📋 Requirements

- **OS**: Debian 11+ or Ubuntu 20.04+
- **Privileges**: sudo access required
- **Network**: Internet connection for downloads
- **Architecture**: x86_64 or arm64

## 🛡️ Security Features

- **Rootless containers** - No root privileges required for container operations
- **Proper storage drivers** - Efficient and secure overlay filesystem
- **SSH key generation** - Modern Ed25519 cryptography
- **Port redirection** - Safe handling of privileged ports

## 🔧 Customization

The scripts are designed to be modular. You can:

1. **Run individual scripts** for specific components
2. **Fork and modify** for your specific needs
3. **Add new OS support** by creating new directories under `bootstrap/`

## 📚 Troubleshooting

### Common Issues

**Container storage warnings**: Normal during initial Podman setup, will resolve after storage driver configuration.

**Shell not switching**: Log out and back in, or run `exec zsh` to switch to zsh.

**Port conflicts**: Check if ports 8080/8443 are available before running.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes on a fresh system
4. Submit a pull request

## 📄 License

This project is open source. See individual script headers for specific licensing information.

---

⭐ **Star this repo** if it helped you bootstrap your development environment!
