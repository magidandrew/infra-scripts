# Infrastructure Scripts

Bootstrap scripts for setting up development environments and infrastructure tools.

## Debian/Ubuntu Bootstrap

Automated setup script for Debian-based systems that installs and configures:

- **Podman** - Container runtime with rootless support
- **Oh My Zsh** - Enhanced shell experience
- **Development tools** - Git and essential packages

### Usage

```bash
curl -fsSL https://raw.githubusercontent.com/magidandrew/infra-scripts/main/bootstrap/debian/install.sh | bash
```

### What it does

- Installs Podman with proper overlay storage configuration
- Sets up Oh My Zsh and switches default shell to zsh
- Configures container registries (Docker Hub, GHCR, Quay)
- Enables rootless containers with port redirection (80→8080, 443→8443)
- Enables user lingering for persistent services

### Requirements

- Debian/Ubuntu system with sudo access
- Internet connection for package downloads
