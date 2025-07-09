#!/bin/bash

# Install dependencies
sudo apt update -y
sudo apt install -y podman git zsh slirp4netns
sudo apt install -y iptables-persistent netfilter-persistent

# for python installs
sudo apt install -y build-essential python3.12-dev

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

echo "Configuring default registries for Podman to allow pulling images by name..."
if [ ! -f "/etc/containers/registries.conf" ]; then
  sudo bash -c 'cat > /etc/containers/registries.conf << EOF
[registries.search]
registries = ["docker.io", "ghcr.io", "quay.io"]
EOF'
else
  echo "Registries configuration already exists, skipping..."
fi

# Modify net.ipv4.ip_unprivileged_port_start to allow rootless users to bind to ports 80 and 443
# note: this is an old approach which is not preferred to redirecting only ports 80 and 443 via iptables (see below)
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
# Remove any existing rules (ignore errors if they don't exist)
sudo iptables -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8888 2>/dev/null || true
sudo iptables -t nat -D PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443 2>/dev/null || true

# Add the rules
sudo iptables -t nat -A PREROUTING -p tcp --dport 80  -j REDIRECT --to-port 8888
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443

# todo: put these in a different script
# Save the rules
sudo iptables-save   > /etc/iptables/rules.v4
sudo ip6tables-save  > /etc/iptables/rules.v6
sudo netfilter-persistent reload

# check that the rules are saved
sudo iptables-save | grep -E "80|443"

# Create swap file. Default is 2GB.
# size = 4 GB (16 × 256 MB blocks). Adjust bs*count to taste.
sudo dd if=/dev/zero of=/swapfile bs=256M count=16
sudo chmod 600 /swapfile          # lock down perms
sudo mkswap /swapfile             # format
sudo swapon /swapfile             # enable immediately
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
# verify
free -h