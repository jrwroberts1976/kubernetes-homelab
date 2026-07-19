#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log() {
    echo "[$(date '+%F %T')] [$SCRIPT_NAME] $1"
}

error() {
    echo "ERROR: $1" >&2
    exit 1
}

check_root() {
    if [[ $EUID -eq 0 ]]; then
        error "Do not run this script as root. Use a normal user with sudo privileges."
    fi
}

check_debian() {
    if ! grep -qi "debian" /etc/os-release; then
        error "This project currently supports Debian only."
    fi
}

check_sudo() {
    sudo -v
}

check_network() {
    ping -c1 github.com >/dev/null 2>&1 || error "No Internet connectivity."
}
check_swap() {
    if swapon --show | grep -q "/"; then
        error "Swap is enabled. Kubernetes requires swap to be disabled. Disable swap before continuing."
    fi
}
