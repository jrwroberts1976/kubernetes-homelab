# Kubernetes Homelab Project Inventory

## Project Purpose

This repository documents the design, deployment, and operation of a Kubernetes homelab platform.

The aim is to demonstrate practical skills in:

* Kubernetes administration
* Linux system management
* Container orchestration
* Infrastructure automation
* Networking
* Git-based operations
* Platform documentation

The current platform runs as a single-node k3s Kubernetes cluster.

---

# Infrastructure Inventory

| Component               | Name               | Details            | Purpose                               |
| ----------------------- | ------------------ | ------------------ | ------------------------------------- |
| Kubernetes Host         | k3s-node-01        | Raspberry Pi ARM64 | Primary Kubernetes control-plane node |
| Operating System        | Debian 12 Bookworm | ARM64              | Host operating system                 |
| Kubernetes Distribution | k3s                | v1.36.2+k3s1       | Lightweight Kubernetes platform       |
| Container Runtime       | containerd         | k3s managed        | Runs Kubernetes containers            |
| Node IP Address         | 192.168.2.195      | LAN address        | Kubernetes node access                |
| LoadBalancer Range      | 192.168.2.210-217  | MetalLB pool       | External service addresses            |

---

# Kubernetes Platform Components

| Component              | Namespace      | Purpose                                | Deployment Method    |
| ---------------------- | -------------- | -------------------------------------- | -------------------- |
| k3s Server             | kube-system    | Kubernetes control plane               | Installation script  |
| CoreDNS                | kube-system    | Internal cluster DNS                   | k3s default          |
| Metrics Server         | kube-system    | Resource metrics API                   | k3s default          |
| Traefik                | kube-system    | Ingress controller                     | k3s default          |
| MetalLB                | metallb-system | Bare-metal LoadBalancer implementation | Kubernetes manifests |
| Local Path Provisioner | kube-system    | Local persistent storage               | k3s default          |

---

# Repository Structure

| Directory       | Purpose                                                |
| --------------- | ------------------------------------------------------ |
| `applications/` | Application workload definitions                       |
| `kubernetes/`   | Kubernetes platform configuration                      |
| `scripts/`      | Installation and automation scripts                    |
| `docs/`         | Architecture, decisions, and operational documentation |
| `images/`       | Architecture diagrams and screenshots                  |

---

# Automation Inventory

| Script                      | Purpose                                     |
| --------------------------- | ------------------------------------------- |
| `scripts/common.sh`         | Shared functions used by deployment scripts |
| `scripts/02-install-k3s.sh` | Installs and validates k3s Kubernetes       |

Automation features:

* Logging
* Error handling
* System validation
* Repeatable deployments

---

# Application Inventory

| Application | Namespace | Type            | Status  | Purpose                             |
| ----------- | --------- | --------------- | ------- | ----------------------------------- |
| whoami      | demo      | Web application | Running | Kubernetes deployment demonstration |

Application resources:

| Resource     | Count |
| ------------ | ----: |
| Deployment   |     1 |
| Replica Pods |     2 |
| Service      |     1 |
| Ingress      |     1 |

---

# Networking Inventory

| Component                  | Address       | Purpose                  |
| -------------------------- | ------------- | ------------------------ |
| Kubernetes Node            | 192.168.2.195 | Cluster host             |
| Traefik LoadBalancer       | 192.168.2.210 | External ingress address |
| Kubernetes Service Network | 10.43.0.0/16  | Internal services        |
| Pod Network                | 10.42.0.0/16  | Pod communication        |

---

# Documentation Inventory

| Document                   | Purpose                              |
| -------------------------- | ------------------------------------ |
| `README.md`                | Project overview                     |
| `Architecture.md`          | Platform design                      |
| `Deployment.md`            | Installation procedure               |
| `Decisions.md`             | Technical decisions and rationale    |
| `Progress.md`              | Build timeline                       |
| `ApplicationDeployment.md` | Application deployment process       |
| `ProjectInventory.md`      | Complete project component inventory |

---

# Future Planned Components

| Component         | Purpose                       |
| ----------------- | ----------------------------- |
| Helm              | Package management            |
| ArgoCD            | GitOps deployment workflow    |
| Prometheus        | Metrics collection            |
| Grafana           | Dashboard visualisation       |
| Loki              | Log aggregation               |
| Backup solution   | Disaster recovery testing     |
| Security scanning | Kubernetes security practices |

---

# Current Project Status

Completed:

✅ Kubernetes cluster deployed
✅ Automated installation scripts created
✅ Git documentation workflow established
✅ MetalLB networking configured
✅ First Kubernetes application deployed
✅ Kustomize deployment workflow implemented

Next objectives:

1. Deploy applications using Helm
2. Implement GitOps workflow
3. Add monitoring stack
4. Add security controls
5. Document backup and recovery procedures
