#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/common.sh"

check_root
check_debian
check_sudo
check_network
check_swap

log "Preparing system..."

sudo systemctl disable --now ufw 2>/dev/null || true

sudo modprobe br_netfilter
sudo modprobe overlay

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes.conf
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
EOF

sudo sysctl --system

log "Installing k3s..."

curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644" sh -

log "Waiting for Kubernetes..."

sleep 20

sudo systemctl enable k3s

log "Checking cluster..."

sudo kubectl get nodes
sudo kubectl get pods -A

log "Installation complete."
