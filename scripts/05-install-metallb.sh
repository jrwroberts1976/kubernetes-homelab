#!/usr/bin/env bash

###############################################################################
# Script Name : 05-install-metallb.sh
# Description : Install and configure MetalLB for the Kubernetes homelab
# Author      : James Roberts
###############################################################################

set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$SCRIPT_NAME] $1"
}

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log "Checking prerequisites..."

if ! command -v kubectl >/dev/null 2>&1; then
    echo "kubectl is not installed."
    exit 1
fi

if ! command -v helm >/dev/null 2>&1; then
    echo "Helm is not installed."
    exit 1
fi

log "Adding MetalLB Helm repository..."

helm repo add metallb https://metallb.github.io/metallb >/dev/null 2>&1 || true
helm repo update

log "Installing MetalLB..."

helm upgrade \
    --install metallb \
    metallb/metallb \
    --namespace metallb-system \
    --create-namespace \
    --values "${REPO_ROOT}/kubernetes/networking/metallb/values.yaml"

log "Waiting for MetalLB controller..."

kubectl rollout status deployment/metallb-controller \
    -n metallb-system \
    --timeout=180s

log "Waiting for MetalLB speaker DaemonSet..."

kubectl rollout status daemonset/metallb-speaker \
    -n metallb-system \
    --timeout=180s

log "Applying IPAddressPool..."

kubectl apply \
    -f "${REPO_ROOT}/kubernetes/networking/metallb/ipaddresspool.yaml"

log "Applying Layer2Advertisement..."

kubectl apply \
    -f "${REPO_ROOT}/kubernetes/networking/metallb/l2advertisement.yaml"

log "MetalLB installation completed successfully."

echo
echo "=============================="
echo "MetalLB Pods"
echo "=============================="
kubectl get pods -n metallb-system

echo
echo "=============================="
echo "IPAddress Pools"
echo "=============================="
kubectl get ipaddresspools -n metallb-system

echo
echo "=============================="
echo "Layer2 Advertisements"
echo "=============================="
kubectl get l2advertisements -n metallb-system

echo
echo "=============================="
echo "Services"
echo "=============================="
kubectl get svc -A
