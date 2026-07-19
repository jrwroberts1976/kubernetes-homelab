#!/usr/bin/env bash

set -euo pipefail

echo "========================================"
echo "Installing Kubernetes Homelab Packages"
echo "========================================"

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
    git \
    curl \
    wget \
    vim \
    htop \
    jq \
    unzip \
    net-tools \
    dnsutils \
    nfs-common \
    ca-certificates \
    gnupg \
    lsb-release

echo
echo "Installed package versions:"
echo "---------------------------"

git --version
curl --version | head -1
wget --version | head -1
jq --version
