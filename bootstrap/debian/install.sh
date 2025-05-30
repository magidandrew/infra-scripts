#!/bin/bash

# Install dependencies
sudo apt update -y
sudo apt install -y podman podman-compose git zsh slirp4netns

# Install omz
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# change shell to zsh
echo "Changing shell to zsh..."
sudo chsh -s $(which zsh) $USER

# # Install uv
# echo "Installing uv..."
# curl -LsSf https://astral.sh/uv/install.sh | sh

echo "Checking if podman is using vfs instead of fuse-overlayfs..."
echo "You may ignore warnings about cgroupv2 and lingering"
podman info --debug | grep graphDriverName | grep -q vfs
if [ $? -eq 0 ]; then
  echo "podman is using vfs instead of fuse-overlayfs. Switching to fuse-overlayfs..."
  sudo apt install -y fuse-overlayfs
  /usr/bin/fuse-overlayfs --version || die "fuse-overlayfs installation failed"
  sudo mkdir -p /etc/containers
  sudo echo -e "[storage]\ndriver = \"overlay\"\n\n[storage.options]\nmount_program = \"/usr/bin/fuse-overlayfs\"" | sudo tee /etc/containers/storage.conf
  podman system reset -f
fi

# Modify net.ipv4.ip_unprivileged_port_start to allow rootless users to bind to ports 80 and 443
# note: this is an old approach which is not preferred to redirecting only ports 80 and 443
# echo "Modifying /etc/sysctl.conf to allow rootless users to bind to ports 80 and 443..."
# sudo bash -c 'echo "net.ipv4.ip_unprivileged_port_start=80" >> /etc/sysctl.conf'
# sudo sysctl -p

# Enable lingering for the user
echo "🔄 Enabling lingering for the user..."
sudo loginctl enable-linger $USER

echo "🚀 Enabling and starting Podman service for the user..."
systemctl --user enable podman
systemctl --user start podman

echo "Starting dbus to allow podman to use the systemd socket..."
systemctl --user start dbus

echo "🔌 Redirecting ports 80 and 443 to 8080 and 8443..."
sudo iptables -t nat -A PREROUTING -p tcp --dport 80  -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443