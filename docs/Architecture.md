# Kubernetes Homelab Architecture

## Overview

This document describes the architecture of the Kubernetes homelab platform.

The objective of this project is to build a production-style Kubernetes environment using Raspberry Pi hardware while demonstrating skills in:

* Kubernetes administration
* Linux infrastructure
* Container orchestration
* Infrastructure automation
* Platform engineering
* GitOps practices
* Observability

The platform is managed through Git and uses automated deployment scripts to provide a repeatable build process.

---

# High-Level Architecture

Current platform architecture:

```text
                         Home Network

                              |
                              |
                         192.168.2.0/24

                              |
                              |

                      k3s-node-01
                    Raspberry Pi ARM64

                    192.168.2.195

                              |

                  Kubernetes Control Plane

                              |

        +---------------------+---------------------+

        |                     |                     |

     CoreDNS              Traefik            Metrics Server

        |                     |                     |

        |                     |                     |

 Internal DNS          Application Ingress     Resource Metrics


                              |

                    Local Storage Provider

                              |

                  Kubernetes Persistent Volumes

```

---

# Infrastructure Layer

## Hardware

| Component    | Details      |
| ------------ | ------------ |
| Platform     | Raspberry Pi |
| Architecture | ARM64        |
| Storage      | NVMe SSD     |
| Network      | Home LAN     |
| Node Count   | Single node  |

---

## Host Operating System

| Component        | Details                      |
| ---------------- | ---------------------------- |
| Operating System | Debian GNU/Linux 12 Bookworm |
| Kernel           | 6.12.93+rpt-rpi-v8           |
| Runtime          | containerd                   |
| IP Address       | 192.168.2.195                |

---

# Kubernetes Platform Layer

## Kubernetes Distribution

The cluster uses:

```text
k3s
```

k3s was selected because it provides:

* lightweight Kubernetes distribution
* ARM64 support
* simplified operations
* production-compatible Kubernetes APIs

Version:

```text
v1.36.2+k3s1
```

---

# Cluster Topology

Current topology:

```text
+--------------------------------+
|          k3s-node-01           |
|                                |
|  Kubernetes Control Plane      |
|                                |
|  kube-apiserver                |
|  scheduler                     |
|  controller-manager            |
|  containerd                    |
|                                |
+--------------------------------+
```

---

# Kubernetes Core Components

The initial k3s installation provides:

| Component              | Function                 |
| ---------------------- | ------------------------ |
| kube-apiserver         | Kubernetes API endpoint  |
| scheduler              | Pod placement            |
| controller manager     | Cluster state management |
| CoreDNS                | Service discovery        |
| Traefik                | Ingress routing          |
| Metrics Server         | Resource monitoring      |
| Local Path Provisioner | Persistent storage       |

---

# Networking Architecture

## Current Networking

Current network flow:

```text
User Device

     |

Home Network

     |

Traefik Ingress Controller

     |

Kubernetes Service

     |

Application Pod

```

---

## Future Networking Improvements

Planned:

### MetalLB

Purpose:

* provide LoadBalancer services
* allocate LAN IP addresses
* replicate cloud-style networking

Target architecture:

```text
Home Network

      |

MetalLB

      |

LoadBalancer Service

      |

Traefik

      |

Application
```

---

# Storage Architecture

## Current Storage

The cluster uses:

```text
Local Path Provisioner
```

Storage flow:

```text
Application Pod

       |

PersistentVolumeClaim

       |

PersistentVolume

       |

NVMe Storage

```

---

## Future Storage Improvements

Potential additions:

* NFS storage
* distributed storage
* backup automation
* snapshot management

---

# Kubernetes Namespace Design

The cluster uses namespace separation to isolate workloads.

Current structure:

```text
kubernetes/
└── namespaces/
    |
    ├── monitoring
    ├── logging
    ├── argocd
    └── applications
```

---

## Namespace Purpose

| Namespace    | Purpose                      |
| ------------ | ---------------------------- |
| monitoring   | Metrics and dashboards       |
| logging      | Centralised logging          |
| argocd       | GitOps deployment management |
| applications | User workloads               |

---

# Deployment Automation

Infrastructure deployment is managed through scripts.

Repository structure:

```text
scripts/

├── common.sh

├── 01-install-packages.sh

├── 02-install-k3s.sh

├── 03-install-helm.sh

└── 04-create-namespaces.sh

```

---

# Automation Workflow

```text
Fresh Operating System

        |

Install Required Packages

        |

Validate Host

        |

Configure Kernel

        |

Install k3s

        |

Configure kubectl

        |

Install Helm

        |

Create Namespaces

        |

Deploy Platform Services

```

---

# Helm Platform Management

Helm is used as the Kubernetes application package manager.

Installed:

```text
Helm 3
```

Purpose:

* application lifecycle management
* repeatable deployments
* version controlled releases

Planned Helm deployments:

| Application  | Purpose                |
| ------------ | ---------------------- |
| Prometheus   | Metrics collection     |
| Grafana      | Dashboards             |
| Loki         | Log aggregation        |
| ArgoCD       | GitOps                 |
| cert-manager | Certificate management |

---

# Observability Architecture (Planned)

Future monitoring stack:

```text

Kubernetes Nodes

        |

Prometheus

        |

Metrics Database

        |

Grafana Dashboards

```

Capabilities:

* node monitoring
* pod monitoring
* resource tracking
* alerting

---

# Logging Architecture (Planned)

Future logging stack:

```text

Containers

    |

Promtail

    |

Loki

    |

Grafana

```

Capabilities:

* centralised logs
* troubleshooting
* application visibility

---

# GitOps Architecture (Planned)

Future deployment workflow:

```text

Developer

   |

GitHub Repository

   |

ArgoCD

   |

Kubernetes Cluster

   |

Applications

```

Benefits:

* Git as source of truth
* automated deployment
* audit history
* repeatable releases

---

# Security Architecture

Planned security improvements:

## Access Control

* Kubernetes RBAC
* service accounts
* least privilege access

## Network Security

* network policies
* namespace isolation

## Secrets Management

* Kubernetes secrets
* external secret management

## Image Security

* container scanning
* vulnerability management

---

# Current Cluster State

Current implementation:

✅ Raspberry Pi Kubernetes node
✅ k3s control plane
✅ Kubernetes API operational
✅ Traefik ingress installed
✅ Metrics Server installed
✅ Persistent storage available
✅ Helm installed
✅ Namespace structure created
✅ Deployment automation stored in Git

---

# Future Roadmap

## Phase 1 - Foundation

Completed:

* Linux preparation
* k3s deployment
* kubectl configuration
* Helm installation

---

## Phase 2 - Platform Services

Planned:

* MetalLB
* Prometheus
* Grafana
* Loki

---

## Phase 3 - GitOps

Planned:

* ArgoCD
* application deployments
* automated synchronisation

---

## Phase 4 - Production Practices

Planned:

* backups
* disaster recovery testing
* security hardening
* upgrade procedures

---

# Project Goal

The final objective is to demonstrate a complete cloud-native platform lifecycle:

```text
Infrastructure

      |

Kubernetes Platform

      |

Observability

      |

GitOps Deployment

      |

Application Delivery

```

This project represents practical experience building and operating a Kubernetes environment using modern DevOps and platform engineering principles.
