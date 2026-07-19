# Kubernetes Homelab Deployment Documentation

## Overview

This document describes the deployment process for the Kubernetes homelab platform.

The project builds a lightweight Kubernetes environment using **k3s** on Raspberry Pi hardware. The goal is to demonstrate practical skills in:

* Kubernetes administration
* Linux system configuration
* Infrastructure automation
* Container orchestration
* Platform engineering practices
* Technical documentation

All deployment activities are automated where possible and stored in Git for repeatability.

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
| Storage                 | 469GB NVMe                     |

---

# Repository Structure

Deployment automation is stored in:

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
| 01-install-packages.sh | Installs required host packages         |
| 02-install-k3s.sh      | Configures host and installs Kubernetes |
| 03-install-helm.sh     | Installs Helm package manager           |

---

# Deployment Workflow

The cluster deployment follows these stages:

```text
Host Preparation
        |
        |
System Validation
        |
        |
Kernel Configuration
        |
        |
k3s Installation
        |
        |
Kubernetes Validation
        |
        |
Helm Installation
        |
        |
Platform Services
```

---

# Phase 1 - Host Preparation

Required packages are installed using:

```bash
./scripts/01-install-packages.sh
```

Installed utilities include:

* git
* curl
* wget
* vim
* htop
* jq
* unzip
* networking tools
* NFS utilities
* certificate utilities

---

# Kubernetes Pre-flight Validation

Before installation, the deployment scripts validate:

## Operating System

Supported platform:

* Debian Linux

## Permissions

The deployment verifies:

* script execution by normal user
* sudo availability

## Network

Internet access is required for:

* downloading k3s
* downloading Helm
* retrieving Kubernetes packages

---

# Kernel Configuration

Kubernetes networking requires additional Linux kernel modules.

Enabled modules:

```text
overlay
br_netfilter
```

Configured networking parameters:

```text
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
```

---

# Swap Configuration

## Requirement

Kubernetes requires swap to be disabled.

Swap was initially enabled through:

```text
dphys-swapfile
```

## Disable Swap

Commands used:

```bash
sudo dphys-swapfile swapoff

sudo systemctl disable dphys-swapfile

sudo systemctl stop dphys-swapfile
```

Validation:

```bash
swapon --show
```

Expected:

```text
(no output)
```

Resource validation:

```bash
free -h
```

Current state:

```text
Memory:
7.8Gi total
6.0Gi available

Swap:
disabled
```

---

# Raspberry Pi Memory Cgroup Configuration

## Issue

The first k3s installation attempt failed:

```text
Error: failed to find memory cgroup (v2)
```

## Cause

Kubernetes requires Linux cgroup controllers for:

* memory management
* CPU limits
* resource quotas
* pod isolation

The Raspberry Pi boot configuration did not enable memory cgroups.

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

After reboot, k3s started successfully.

Validation:

```bash
cat /proc/cgroups | grep memory
```

---

# Phase 2 - k3s Installation

The Kubernetes cluster is installed using:

```bash
./scripts/02-install-k3s.sh
```

The script performs:

* system validation
* kernel configuration
* Kubernetes networking preparation
* k3s installation
* systemd service configuration
* cluster validation

---

# Kubernetes Cluster Validation

## Node Status

Command:

```bash
kubectl get nodes
```

Result:

```text
NAME          STATUS   ROLES
k3s-node-01   Ready    control-plane
```

---

## Node Details

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
Operating System:
Debian GNU/Linux 12 (Bookworm)

Kernel:
6.12.93+rpt-rpi-v8

Container Runtime:
containerd://2.3.2-k3s2
```

---

# Default Kubernetes Components

The default k3s deployment includes:

| Component              | Purpose                 |
| ---------------------- | ----------------------- |
| CoreDNS                | Kubernetes internal DNS |
| Traefik                | Ingress controller      |
| Metrics Server         | Resource monitoring     |
| Local Path Provisioner | Persistent storage      |
| Service Load Balancer  | Service exposure        |

Validation:

```bash
kubectl get pods -A
```

---

# Kubernetes User Access Configuration

## Objective

Configure Kubernetes administration without root access.

The default k3s kubeconfig:

```text
/etc/rancher/k3s/k3s.yaml
```

was copied into the user's Kubernetes configuration directory.

---

## Configuration

Create kubeconfig directory:

```bash
mkdir -p ~/.kube
```

Copy configuration:

```bash
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
```

Update ownership:

```bash
sudo chown james:james ~/.kube/config
```

Secure permissions:

```bash
chmod 600 ~/.kube/config
```

Configure environment:

```bash
export KUBECONFIG=$HOME/.kube/config
```

---

## Validation

Kubernetes administration works without sudo:

```bash
kubectl get nodes
```

Authentication:

```bash
kubectl auth whoami
```

---

# Phase 3 - Helm Installation

## Purpose

Helm is used as the Kubernetes package manager.

Helm provides:

* repeatable deployments
* version controlled releases
* simplified application lifecycle management

---

## Installation

Helm is installed using:

```bash
./scripts/03-install-helm.sh
```

---

## Validation

Check Helm installation:

```bash
helm version
```

List installed releases:

```bash
helm list -A
```

---

# Current Cluster State

Current architecture:

```text
                 Home Network

                      |
                      |

              k3s-node-01
              192.168.2.195

                      |

          Kubernetes Control Plane

                      |

       ------------------------------

       |            |              |

    CoreDNS      Traefik     Metrics Server

                      |

          Local Persistent Storage
```

---

# Resource Capacity

Current host capacity:

## Memory

```text
Total:
7.8Gi

Available:
6.0Gi
```

## Storage

```text
Disk:
469GB NVMe

Available:
212GB
```

The hardware is suitable for running:

* monitoring stack
* logging stack
* GitOps tooling
* application workloads

---

# Future Platform Enhancements

## Kubernetes Networking

Planned:

* MetalLB load balancer
* service IP management
* ingress improvements

---

## Monitoring

Deploy:

* Prometheus
* Grafana

Capabilities:

* cluster metrics
* dashboards
* alerting

---

## Logging

Deploy:

* Loki
* Promtail

Capabilities:

* centralised logs
* troubleshooting
* observability

---

## GitOps

Deploy:

* ArgoCD

Capabilities:

* Git-based deployments
* automated synchronisation
* application lifecycle management

---

## Security

Planned:

* RBAC policies
* network policies
* secrets management
* security scanning

---

# Lessons Learned

## Kubernetes on Raspberry Pi

Key considerations:

* Linux kernel configuration is critical
* Memory cgroups must be enabled
* Swap should be disabled
* Automation prevents configuration drift

## Infrastructure Automation

The project evolved from manual installation into a repeatable platform deployment process using:

* Bash automation
* Git version control
* documented procedures
* validation checks

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

Cluster health:

```bash
kubectl get --raw='/readyz?verbose'
```

Resource usage:

```bash
kubectl top nodes
```

Helm releases:

```bash
helm list -A
```
