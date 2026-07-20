#!/usr/bin/env bash

set -euo pipefail

SCRIPT_NAME="$(basename "$0")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] $1"
}

NAMESPACE_DIR="$(dirname "$0")/../kubernetes/namespaces"

log "Creating Kubernetes namespaces..."

for namespace in "$NAMESPACE_DIR"/*.yaml
do
    log "Applying ${namespace}"
    kubectl apply -f "$namespace"
done

log "Namespace creation complete"

kubectl get namespaces
