#!/usr/bin/env bash

###############################################################################
# Kubernetes Homelab
# Shared functions for all installation scripts
###############################################################################

set -euo pipefail

SCRIPT_NAME=$(basename "$0")

###############################################################################
# Logging
###############################################################################

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

log() {
    echo "[$(timestamp)] [$SCRIPT_NAME] $1"
}

warn() {
    echo "[$(timestamp)] [$SCRIPT_NAME] WARNING: $1"
}

success() {
    echo "[$(timestamp)] [$SCRIPT_NAME] SUCCESS: $1"
}

error() {
    echo "[$(timestamp)] [$SCRIPT_NAME] ERROR: $1" >&2
    exit 1
}

###############################################################################
# Display
###############################################################################

banner() {

cat <<EOF

===========================================================
 Kubernetes Homelab
===========================================================
 Script : $SCRIPT_NAME
 Started: $(timestamp)
===========================================================

EOF

}

###############################################################################
# Validation
###############################################################################

check_root() {

    if [[ $EUID -eq 0 ]]; then
        error "Do not run this script as root."
    fi

}

check_debian() {

    if ! grep -qi "debian" /etc/os-release; then
        error "This project currently supports Debian only."
    fi

}

check_sudo() {

    sudo -v || error "Sudo access required."

}

check_network() {

    ping -c1 github.com >/dev/null 2>&1 \
        || error "Internet connectivity unavailable."

}

check_swap() {

    if swapon --show | grep -q "/"; then
        error "Swap is enabled. Disable swap before continuing."
    fi

}

check_command() {

    command -v "$1" >/dev/null 2>&1 \
        || error "$1 is not installed."

}

###############################################################################
# Kubernetes Helpers
###############################################################################

wait_for_deployment() {

    local namespace="$1"
    local deployment="$2"

    kubectl rollout status deployment/"$deployment" \
        -n "$namespace" \
        --timeout=180s

}

wait_for_daemonset() {

    local namespace="$1"
    local daemonset="$2"

    kubectl rollout status daemonset/"$daemonset" \
        -n "$namespace" \
        --timeout=180s

}

wait_for_pods() {

    local namespace="$1"

    kubectl wait \
        --for=condition=Ready \
        pod \
        --all \
        -n "$namespace" \
        --timeout=180s

}

###############################################################################
# Output Helpers
###############################################################################

section() {

    echo
    echo "=========================================================="
    echo "$1"
    echo "=========================================================="

}

show_cluster_status() {

    section "Nodes"
    kubectl get nodes -o wide

    section "Pods"
    kubectl get pods -A

    section "Services"
    kubectl get svc -A

}
