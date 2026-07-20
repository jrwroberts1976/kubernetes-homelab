# Kubernetes Homelab Project Progress

## Project Overview

This project builds a production-style Kubernetes platform in a homelab environment to demonstrate practical skills in:

* Kubernetes administration
* Linux system configuration
* Container orchestration
* Infrastructure automation
* Networking
* Documentation
* Git-based deployment workflows

The platform is currently deployed as a single-node k3s cluster running on Raspberry Pi hardware.

---

# Deployment Timeline

## 2026-07-19 - Kubernetes Host Preparation

Prepared the Raspberry Pi Kubernetes host:

**Node:**

* Hostname: `k3s-node-01`
* OS: Debian GNU/Linux 12 (Bookworm)
* Architecture: ARM64
* IP Address: `192.168.2.195`

Validated system requirements:

* Updated operating system packages
* Installed required administration tools:

  * git
  * curl
  * wget
  * jq
  * unzip
  * net-tools
  * dnsutils
  * nfs-common
  * ca-certificates
  * gnupg
  * vim

Created project structure:

```
kubernetes-homelab/
├── docs/
├── scripts/
├── kubernetes/
├── applications/
└── README.md
```

---

# Installation Automation

Created reusable installation scripts stored in Git:

```
scripts/
├── common.sh
└── 02-install-k3s.sh
```

The scripts provide:

* Logging
* Error handling
* Environment validation
* Repeatable deployment steps

---

# k3s Installation

Installed k3s Kubernetes distribution.

Initial installation issue:

```
Error: failed to find memory cgroup (v2)
```

Resolution:

Updated the k3s systemd service configuration to enable required cgroup support.

Commands used:

```
sudo systemctl edit k3s
sudo systemctl daemon-reload
sudo systemctl restart k3s
```

Validation:

```
kubectl get nodes
```

Result:

```
NAME          STATUS   ROLES
k3s-node-01   Ready    control-plane
```

---

# Cluster Validation

Verified Kubernetes system components:

```
kubectl get pods -A
```

Running components:

* CoreDNS
* Metrics Server
* Traefik Ingress Controller
* Local Path Storage Provider

Validated non-root Kubernetes administration by configuring user kubeconfig access.

---

# System Resource Review

Reviewed available resources:

```
free -h
```

Result:

* Memory: 7.8GiB
* Available memory: approximately 6GiB
* Swap: disabled for Kubernetes compatibility

Storage:

```
df -h /
```

Result:

* Disk capacity: 469GB
* Available space: 212GB

---

# MetalLB Installation

Installed MetalLB to provide LoadBalancer functionality for the bare-metal Kubernetes environment.

Reason:

Cloud Kubernetes platforms automatically provide external load balancers. In a homelab environment MetalLB provides equivalent functionality.

---

# MetalLB Network Design Decision

Initial MetalLB address allocation conflicted with an existing Raspberry Pi:

```
192.168.2.220
```

The network was checked before assigning service addresses.

Validated available addresses:

```
192.168.2.210-192.168.2.217
```

Selected MetalLB pool:

```
192.168.2.210-192.168.2.217
```

This range was chosen to avoid conflicts with existing infrastructure.

---

# Traefik LoadBalancer Validation

Updated Traefik to use MetalLB.

Current service:

```
kubectl get svc -n kube-system traefik
```

Result:

```
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP
traefik   LoadBalancer   10.43.192.212   192.168.2.210
```

Validation successful.

Traffic flow:

```
LAN Client
    |
    |
192.168.2.210
    |
    |
Traefik Ingress Controller
    |
    |
Kubernetes Service
    |
    |
Application Pod
```

---

# Current Platform Status

Completed:

✅ Kubernetes host preparation
✅ Automated k3s installation
✅ Cluster initialisation
✅ User Kubernetes administration
✅ Resource validation
✅ MetalLB installation
✅ LoadBalancer networking
✅ Git documentation workflow

Next planned activities:

1. Deploy sample application
2. Configure Kubernetes manifests
3. Add Helm-based deployments
4. Add persistent storage examples
5. Deploy monitoring stack
6. Introduce GitOps workflow using ArgoCD
7. Add security and backup documentation
