# Kubernetes Homelab

> A production-style Kubernetes homelab built to develop and demonstrate cloud-native engineering, DevOps, and platform engineering skills.

---

# Overview

This repository documents the design, deployment, operation and ongoing development of a Kubernetes cluster running on Raspberry Pi hardware.

The project is intended to simulate many of the technologies and operational practices used in modern production environments while remaining practical to build and maintain as a personal homelab.

Rather than simply deploying Kubernetes, the goal is to demonstrate the complete lifecycle of a platform, including:

* Planning
* Automation
* Deployment
* Networking
* Monitoring
* Security
* Documentation
* Operational procedures

---

# Project Objectives

* Design and deploy a Kubernetes environment
* Develop practical Kubernetes administration skills
* Build experience with automation and infrastructure management
* Implement Git-based deployment workflows
* Configure monitoring and observability
* Improve Linux system administration skills
* Demonstrate production-style operational documentation
* Create a portfolio project to support Cloud, DevOps and Platform Engineering roles

---

# Planned Technologies

| Area                   | Technology             |
| ---------------------- | ---------------------- |
| Operating System       | Debian Linux           |
| Kubernetes             | k3s                    |
| Container Runtime      | containerd             |
| Version Control        | Git & GitHub           |
| Automation             | Bash / Ansible         |
| Infrastructure as Code | Terraform              |
| Monitoring             | Prometheus             |
| Dashboards             | Grafana                |
| Logging                | Loki                   |
| GitOps                 | ArgoCD                 |
| Networking             | MetalLB + Traefik      |
| Storage                | Persistent Volumes     |
| Security               | RBAC, Network Policies |

---

# Repository Structure

```text
kubernetes-homelab/

├── applications/
│   └── whoami/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── ingress.yaml
│       └── kustomization.yaml
│
├── docs/
│   ├── Architecture.md
│   ├── Deployment.md
│   ├── Decisions.md
│   ├── ProjectInventory.md
│   ├── ProjectTimeline.md
│   └── Progress.md
│
├── images/
│
├── kubernetes/
│   ├── metallb/
│   └── namespaces/
│
├── scripts/
│   ├── common.sh
│   └── 02-install-k3s.sh
│
└── README.md
```

---

# Documentation

* [Architecture](docs/Architecture.md)
* [Deployment Guide](docs/Deployment.md)
* [Project Inventory](docs/ProjectInventory.md)
* [Project Timeline](docs/ProjectTimeline.md)
* [Technical Decisions](docs/Decisions.md)
* [Progress](docs/Progress.md)

---

# Current Status

## Phase 7 – Kubernetes Application Platform Operational

The Kubernetes platform is now deployed and running workloads.

Completed:

* [x] Repository created
* [x] Documentation structure defined
* [x] Raspberry Pi Kubernetes host prepared
* [x] Debian Linux configured
* [x] Kubernetes prerequisites configured
* [x] k3s Kubernetes cluster deployed
* [x] Control-plane node operational
* [x] Kubernetes core services validated
* [x] MetalLB LoadBalancer configured
* [x] Traefik ingress deployed
* [x] First Kubernetes application deployed
* [x] Kustomize deployment workflow implemented
* [x] Deployment documentation created

---

# Current Platform

| Component              | Status                      |
| ---------------------- | --------------------------- |
| Kubernetes             | Running                     |
| Distribution           | k3s                         |
| Control Plane          | Operational                 |
| Container Runtime      | containerd                  |
| Networking             | MetalLB + Traefik           |
| Storage                | Local Path Provisioner      |
| Application Deployment | Kubernetes YAML + Kustomize |
| Documentation          | Active                      |

---

# Kubernetes Cluster

Current cluster:

| Component          | Details            |
| ------------------ | ------------------ |
| Host               | Raspberry Pi ARM64 |
| Node Name          | k3s-node-01        |
| Operating System   | Debian 12 Bookworm |
| Kubernetes Version | v1.36.2+k3s1       |
| Runtime            | containerd         |
| Node Role          | Control Plane      |

---

# Deployed Applications

## whoami

A lightweight Kubernetes demonstration application used to validate application deployment workflows.

Implemented resources:

* Namespace
* Deployment
* ReplicaSet
* Pods
* Service
* Ingress
* Kustomize configuration

Current deployment:

| Resource  | Status    |
| --------- | --------- |
| Namespace | demo      |
| Replicas  | 2         |
| Pods      | Running   |
| Service   | ClusterIP |
| Ingress   | Traefik   |

---

# Project Journey

This project documents the build of a Kubernetes platform from a single Raspberry Pi host into a fully operational container orchestration environment.

The goal is to demonstrate practical cloud-native engineering skills including:

* Kubernetes administration
* Container orchestration
* Linux platform management
* Infrastructure automation
* Networking
* Git-based documentation and deployment practices

---

## Build Story

The project started with preparing a Raspberry Pi ARM64 host and creating a repeatable deployment process.

The initial Kubernetes deployment required troubleshooting Linux system configuration, including:

* Kernel modules
* Network forwarding
* Linux cgroups
* Kubernetes host requirements

After resolving these issues, the cluster reached a healthy operational state.

The platform has progressed to running real Kubernetes workloads including:

* Namespace management
* Deployments
* ReplicaSets
* Services
* Ingress routing
* External LoadBalancer access

---

# Next Steps

The next phases will focus on moving the platform closer to production practices:

## Platform Operations

Planned:

* Helm application packaging
* GitOps deployment with ArgoCD
* Automated application delivery

## Observability

Planned:

* Prometheus metrics collection
* Grafana dashboards
* Loki centralised logging
* Alerting

## Production Practices

Planned:

* Backup strategy
* Disaster recovery testing
* Security scanning
* RBAC improvements
* Network policies
* Cluster upgrade procedures

---

# Skills Demonstrated

* Linux Administration
* Kubernetes Administration
* Container Orchestration
* k3s Deployment
* containerd Runtime Management
* Kubernetes Networking
* LoadBalancer Configuration
* Ingress Management
* Git Version Control
* GitHub Repository Management
* Infrastructure Automation
* Troubleshooting
* Technical Documentation
* Platform Engineering Practices

---

# Purpose

This project is maintained as a practical learning platform and professional portfolio to demonstrate real-world Kubernetes administration, infrastructure automation and cloud-native operational practices.
