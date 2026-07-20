#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME="$(basename "$0")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] $1"
}

log "Checking Helm installation..."

if command -v helm >/dev/null 2>&1; then
    log "Helm already installed"
    helm version
    exit 0
fi

log "Installing Helm..."

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

log "Helm installation complete"

helm version
