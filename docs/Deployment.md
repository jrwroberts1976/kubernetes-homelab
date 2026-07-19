# Kubernetes Homelab Deployment Documentation

## Overview

This document describes the deployment process for the Kubernetes homelab platform.

The cluster is built using **k3s** running on Raspberry Pi hardware and is designed to demonstrate:

* Kubernetes administration
* Linux system configuration
* Infrastructure automation
* Operational troubleshooting
* Cloud-native platform practices
* Technical documentation

The deployment process is automated using scripts stored in this repository.

---

# Environment

| Component               | Details                        |
| ----------------------- | ------------------------------ |
| Hardware                | Raspberry Pi                   |
| Hostname                | k3s-node-01                    |
| Operating System        | Debian GNU/Linux 12 (Bookworm) |
| Architecture            | ARM64                          |
| Kubernetes Distribution | k3s                            |
| Kubernetes Version      | v1.36.2+k3s1                   |
| Container Runtime       | containerd                     |
| Internal IP Address     | 192.168.2.195                  |
| Kernel Version          | 6.12.93+rpt-rpi-v8             |

---

# Repository Deployment Structure

Deployment automation is stored under:

```text
scripts/
├── common.sh
├── 01-install-packages.sh
├── 02-install-k3s.sh
└── 03-install-helm.sh
```

## Script Purpose

| Script                 | Purpose                                 |
| ---------------------- | --------------------------------------- |
| common.sh              | Shared validation and helper functions  |
| 01-install-packages.sh | Installs required Linux packages        |
| 02-install-k3s.sh      | Configures host and installs Kubernetes |
| 03-install-helm.sh     | Installs Kubernetes package manager     |

---

# Deployment Process

## Phase 1 - Host Preparation

The initial preparation script installs required utilities.

Command:

```bash
./scripts/01-install-packages.sh
```

Installed tools include:

* git
* curl
* wget
* vim
* htop
* jq
* unzip
* networking utilities
* NFS utilities
* certificate tools

---

# Kubernetes Pre-flight Validation

Before installing Kubernetes, the deployment process validates the host environment.

The following checks are performed:

## Operating System

The deployment currently supports:

* Debian Linux

## User Permissions

The script verifies:

* Non-root execution
* sudo access available

## Network Connectivity

Internet connectivity is required to download:

* k3s binaries
* Helm packages
* Kubernetes components

## Kernel Modules

Required Kubernetes modules:

```text
overlay
br_netfilter
```

are enabled automatically.

## Kernel Networking Configuration

The following sysctl settings are configured:

```text
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
```

---

# Swap Configuration

## Requirement

Kubernetes requires swap to be disabled for predictable resource management.

Check current swap:

```bash
swapon --show
```

## Raspberry Pi Configuration

The Raspberry Pi Debian installation uses:

```text
dphys-swapfile
```

Swap was disabled using:

```bash
sudo dphys-swapfile swapoff

sudo systemctl disable dphys-swapfile

sudo systemctl stop dphys-swapfile
```

Validation:

```bash
free -h
```

Expected:

```text
Swap: 0B
```

---

# Raspberry Pi Memory Cgroup Configuration

## Issue

The first k3s installation attempt failed with:

```text
Error: failed to find memory cgroup (v2)
```

## Cause

Kubernetes requires Linux cgroup controllers for:

* memory management
* CPU limits
* resource quotas
* pod isolation

The Raspberry Pi Debian configuration did not enable memory cgroups by default.

---

## Resolution

Updated:

```text
/boot/firmware/cmdline.txt
```

Added:

```text
cgroup_memory=1 cgroup_enable=memory
```

The configuration was applied and the Raspberry Pi was rebooted.

Validation:

```bash
cat /proc/cgroups | grep memory
```

---

# k3s Installation

The Kubernetes installation is automated using:

```bash
./scripts/02-install-k3s.sh
```

The installation performs:

* system validation
* kernel configuration
* Kubernetes networking setup
* k3s installation
* systemd service configuration
* cluster validation

---

# Cluster Validation

## Node Status

Command:

```bash
kubectl get nodes
```

Result:

```text
NAME          STATUS   ROLES           AGE   VERSION
k3s-node-01   Ready    control-plane   29m   v1.36.2+k3s1
```

---

## Detailed Node Information

Command:

```bash
kubectl get nodes -o wide
```

Result:

```text
NAME          STATUS   ROLES           INTERNAL-IP
k3s-node-01   Ready    control-plane   192.168.2.195
```

Additional information:

```text
OS:
Debian GNU/Linux 12 (bookworm)

Kernel:
6.12.93+rpt-rpi-v8

Runtime:
containerd://2.3.2-k3s2
```

---

# Kubernetes System Components

Command:

```bash
kubectl get pods -A
```

Installed components:

| Component              | Purpose                 |
| ---------------------- | ----------------------- |
| CoreDNS                | Internal Kubernetes DNS |
| Traefik                | Ingress controller      |
| Metrics Server         | Resource metrics        |
| Local Path Provisioner | Persistent storage      |
| Service Load Balancer  | Service exposure        |

---

# Kubernetes User Access

## Objective

Enable Kubernetes administration without requiring root privileges.

The default k3s configuration is stored at:

```text
/etc/rancher/k3s/k3s.yaml
```

---

## User Configuration

Created kubeconfig directory:

```bash
mkdir -p ~/.kube
```

Copied configuration:

```bash
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
```

Updated ownership:

```bash
sudo chown james:james ~/.kube/config
```

Restricted permissions:

```bash
chmod 600 ~/.kube/config
```

Configured environment:

```bash
export KUBECONFIG=$HOME/.kube/config
```

---

## Validation

Kubernetes administration now works without sudo:

```bash
kubectl get nodes
```

Authentication:

```bash
kubectl auth whoami
```

---

# Current Cluster State

The cluster currently operates as:

```text
Single Node Kubernetes Cluster

             Home Network
                  |
                  |
            k3s-node-01
                  |
        Kubernetes Control Plane
                  |
     ----------------------------
     |          |              |
   CoreDNS   Traefik    Metrics Server
                  |
        Local Persistent Storage
```

---

# Resource Availability

Initial platform sizing:

## Memory

```text
Total:      7.8Gi
Available: 6.0Gi
```

## Storage

```text
Disk:
469GB NVMe

Available:
212GB
```

The available resources support future deployment of:

* monitoring
* logging
* GitOps tooling
* application workloads

---

# Future Platform Enhancements

## Package Management

* Install Helm
* Create Helm repositories
* Manage platform components

## Networking

* Deploy MetalLB
* Configure load balancing
* Improve ingress management

## Observability

Deploy:

* Prometheus
* Grafana
* Loki

## GitOps

Deploy:

* Argo CD
* Git-managed application lifecycle

## Security

Implement:

* RBAC policies
* Network policies
* Secrets management
* Security scanning

## Operations

Add:

* Backup procedures
* Disaster recovery documentation
* Upgrade procedures
* Automated health checks

---

# Lessons Learned

## Raspberry Pi Kubernetes Requirements

* Kubernetes has dependencies on Linux kernel features.
* Raspberry Pi deployments require additional boot configuration.
* Resource validation should happen before installation.

## Automation Improvements

The deployment process evolved from a manual installation into a repeatable platform build process with:

* validation checks
* documented fixes
* automated configuration
* version-controlled deployment steps

---

# Validation Command Reference

Check nodes:

```bash
kubectl get nodes
```

Check workloads:

```bash
kubectl get pods -A
```

Cluster information:

```bash
kubectl cluster-info
```

Resource usage:

```bash
kubectl top nodes
```

Cluster configuration:

```bash
kubectl config view
```
