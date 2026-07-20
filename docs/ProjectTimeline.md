# Kubernetes Homelab Project Timeline

## Project Overview

This project documents the journey of building a production-style Kubernetes platform in a home lab environment.

The objective is to develop practical cloud-native skills and demonstrate experience with:

* Kubernetes administration
* Container orchestration
* Infrastructure automation
* Linux systems management
* Networking
* Git-based deployment workflows
* Platform documentation

The platform is being built using a Raspberry Pi ARM64 host running Debian and k3s Kubernetes.

---

# Project Timeline

## Phase 1 - Project Planning and Repository Setup

**Status: Complete ✅**

The project was created to build a portfolio-ready Kubernetes environment.

Completed activities:

* Created GitHub repository:

  * `kubernetes-homelab`
* Established project structure
* Added documentation framework
* Created automation directory
* Defined deployment approach

Initial repository structure:

```
kubernetes-homelab/

├── applications/
├── docs/
├── images/
├── kubernetes/
├── scripts/
└── README.md
```

---

# Phase 2 - Host Preparation

**Status: Complete ✅**

Prepared the Kubernetes host environment.

Completed activities:

* Installed Debian Linux
* Updated system packages
* Installed required administration tools
* Validated networking
* Configured Kubernetes prerequisites

Installed tooling:

* Git
* Curl
* Wget
* jq
* vim
* Network utilities
* NFS client tools

---

# Phase 3 - Kubernetes Platform Deployment

**Status: Complete ✅**

Deployed the Kubernetes control plane using k3s.

Completed activities:

* Created automated installation script
* Configured kernel modules
* Enabled Kubernetes networking requirements
* Installed k3s
* Validated cluster operation

Cluster details:

| Component    | Details         |
| ------------ | --------------- |
| Distribution | k3s             |
| Version      | v1.36.2+k3s1    |
| Node         | k3s-node-01     |
| Role         | Control Plane   |
| Runtime      | containerd      |
| OS           | Debian 12 ARM64 |

---

# Phase 4 - Troubleshooting and Platform Hardening

**Status: Complete ✅**

Resolved initial Kubernetes host configuration issues.

Issue encountered:

```
Error: failed to find memory cgroup (v2)
```

Resolution:

* Updated systemd configuration
* Enabled required cgroup support
* Restarted k3s service
* Validated cluster recovery

Outcome:

* Kubernetes node reporting Ready
* Core platform services operational

---

# Phase 5 - Kubernetes Core Services

**Status: Complete ✅**

Validated built-in Kubernetes components.

Running services:

| Component              | Purpose                 |
| ---------------------- | ----------------------- |
| CoreDNS                | Cluster DNS             |
| Metrics Server         | Resource monitoring     |
| Traefik                | Ingress controller      |
| Local Path Provisioner | Storage                 |
| MetalLB                | Bare-metal LoadBalancer |

---

# Phase 6 - Networking Implementation

**Status: Complete ✅**

Implemented external service networking.

Completed activities:

* Installed MetalLB
* Configured LoadBalancer IP range
* Integrated with Traefik ingress

Current network design:

```
Client
 |
 |
192.168.2.x Network
 |
 |
MetalLB LoadBalancer
 |
 |
Traefik Ingress
 |
 |
Kubernetes Service
 |
 |
Application Pods
```

---

# Phase 7 - First Kubernetes Application

**Status: Complete ✅**

Deployed first application workload.

Application:

```
whoami
```

Implemented resources:

* Namespace
* Deployment
* ReplicaSet
* Pods
* Service
* Ingress
* Kustomize configuration

Current status:

```
Deployment: Running
Replicas: 2
Pods: 2/2 Ready
```

---

# Current Platform Status

**Current milestone: Kubernetes Application Platform Operational**

The cluster can now:

✅ Run containerised applications
✅ Provide internal networking
✅ Expose applications externally
✅ Manage workloads declaratively
✅ Deploy applications using Kustomize
✅ Be rebuilt using automation scripts

---

# Next Planned Phases

## Phase 8 - Platform Operations

Planned:

* Add Helm package management
* Introduce GitOps workflow
* Deploy ArgoCD applications
* Improve secrets management

---

## Phase 9 - Observability

Planned:

* Prometheus metrics collection
* Grafana dashboards
* Loki logging
* Alerting configuration

---

## Phase 10 - Production Practices

Planned:

* Backup strategy
* Disaster recovery testing
* Security scanning
* Network policies
* RBAC improvements

---

# Current Achievement Summary

The project has progressed from an empty Raspberry Pi host to a functioning Kubernetes application platform.

Current demonstrated skills:

* Linux administration
* Kubernetes deployment
* Container orchestration
* Networking configuration
* Infrastructure automation
* Git documentation practices
* Troubleshooting production-style issues
