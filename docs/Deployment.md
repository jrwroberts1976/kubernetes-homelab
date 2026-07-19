# Deployment Documentation

## Kubernetes Cluster Deployment

## Overview

This document describes the deployment process for the Kubernetes homelab cluster.

The platform is built using **k3s** running on Raspberry Pi hardware and is designed to demonstrate Kubernetes administration, automation, documentation, and operational practices.

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
| Node IP Address         | 192.168.2.195                  |
| Kernel Version          | 6.12.93+rpt-rpi-v8             |

---

# Deployment Process

The Kubernetes installation is automated using scripts stored within the repository.

Deployment scripts:

```text
scripts/
├── common.sh
├── 01-install-packages.sh
└── 02-install-k3s.sh
```

The installation process performs:

* Host validation
* Required package installation
* Kernel module configuration
* Kubernetes networking configuration
* k3s installation
* Kubernetes service enablement
* Cluster validation

---

# Initial Cluster Installation

The cluster was deployed using:

```bash
./scripts/02-install-k3s.sh
```

The script configured the required Linux kernel settings:

```text
overlay
br_netfilter
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
```

---

# Raspberry Pi Kernel Configuration

## Issue

The initial k3s deployment failed because memory cgroups were not enabled.

Error:

```text
Error: failed to find memory cgroup (v2)
```

## Cause

Kubernetes requires Linux cgroup controllers to manage:

* CPU limits
* Memory limits
* Resource quotas
* Pod isolation

The Raspberry Pi Debian configuration did not enable the memory controller during boot.

## Resolution

Updated:

```text
/boot/firmware/cmdline.txt
```

Added:

```text
cgroup_memory=1 cgroup_enable=memory
```

The system was rebooted and k3s was restarted.

Validation:

```bash
cat /proc/cgroups | grep memory
```

After enabling memory cgroups, the Kubernetes service started successfully.

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
NAME          STATUS   ROLES           INTERNAL-IP     OS-IMAGE
k3s-node-01   Ready    control-plane   192.168.2.195   Debian GNU/Linux 12 (bookworm)
```

Additional details:

```text
Kernel:
6.12.93+rpt-rpi-v8

Container Runtime:
containerd://2.3.2-k3s2
```

---

# Kubernetes System Components

Command:

```bash
kubectl get pods -A
```

Current core services:

| Component              | Purpose                            |
| ---------------------- | ---------------------------------- |
| CoreDNS                | Internal Kubernetes DNS resolution |
| Traefik                | Ingress controller                 |
| Metrics Server         | Resource monitoring metrics        |
| Local Path Provisioner | Persistent volume storage          |
| Service Load Balancer  | Service exposure                   |

---

# Kubernetes User Access Configuration

## Objective

Configure Kubernetes administration without requiring root privileges.

The default k3s installation creates the administrator kubeconfig file:

```text
/etc/rancher/k3s/k3s.yaml
```

This file is owned by root and is not suitable for normal user administration.

---

## User Kubeconfig Setup

Created Kubernetes configuration directory:

```bash
mkdir -p ~/.kube
```

Copied the k3s configuration:

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

Configured the Kubernetes environment variable:

```bash
export KUBECONFIG=$HOME/.kube/config
```

---

## Validation

The cluster can now be managed without sudo privileges.

Node validation:

```bash
kubectl get nodes
```

Workload validation:

```bash
kubectl get pods -A
```

Authentication validation:

```bash
kubectl auth whoami
```

---

# Current Cluster State

The cluster currently operates as a single-node Kubernetes environment.

Current capabilities:

* Kubernetes control plane running
* Container scheduling operational
* Internal DNS available
* Ingress controller deployed
* Metrics collection enabled
* Persistent storage available
* Non-root Kubernetes administration configured

---

# Future Improvements

Planned platform enhancements:

## Networking

* Deploy MetalLB load balancer
* Configure service IP allocation
* Improve ingress management

## Observability

* Install Prometheus
* Deploy Grafana dashboards
* Configure Loki logging

## GitOps

* Install Argo CD
* Manage applications through Git
* Automate deployments

## Security

* Configure RBAC policies
* Add network policies
* Implement secrets management

## Operations

* Backup cluster configuration
* Document disaster recovery
* Automate upgrades
* Add health monitoring

---

# Validation Commands Reference

Check cluster nodes:

```bash
kubectl get nodes
```

Check all workloads:

```bash
kubectl get pods -A
```

View cluster information:

```bash
kubectl cluster-info
```

View Kubernetes configuration:

```bash
kubectl config view
```

Check available resources:

```bash
kubectl get all -A
```
