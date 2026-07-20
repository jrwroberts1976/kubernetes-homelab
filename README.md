# Kubernetes Homelab

> A production-style Kubernetes homelab built to develop and demonstrate cloud-native engineering, DevOps, and platform engineering skills.

## Overview

This repository documents the design, deployment, operation and ongoing development of a Kubernetes cluster running on Raspberry Pi hardware.

The project is intended to simulate many of the technologies and operational practices used in modern production environments while remaining practical to build and maintain as a personal homelab.

Rather than simply deploying Kubernetes, the goal is to demonstrate the complete lifecycle of a platform, including planning, automation, monitoring, security, documentation and operational procedures.

---
## Project Journey

See the full build story:
[Project Timeline](docs/ProjectTimeline.md)

## Project Objectives

* Design and deploy a highly available Kubernetes environment
* Develop practical Kubernetes administration skills
* Build experience with Infrastructure as Code and automation
* Implement GitOps deployment workflows
* Configure monitoring and observability
* Improve Linux system administration skills
* Demonstrate production-style operational documentation
* Create a portfolio project to support Cloud and DevOps engineering roles

---

## Planned Technologies

| Area                   | Technology             |
| ---------------------- | ---------------------- |
| Operating System       | Debian Linux           |
| Kubernetes             | k3s                    |
| Container Runtime      | containerd             |
| Version Control        | Git & GitHub           |
| Automation             | Ansible                |
| Infrastructure as Code | Terraform              |
| Monitoring             | Prometheus             |
| Dashboards             | Grafana                |
| Logging                | Loki                   |
| GitOps                 | Argo CD                |
| Networking             | MetalLB, Ingress NGINX |
| Storage                | Persistent Volumes     |
| Security               | RBAC, Network Policies |

---

## Repository Structure

```text
docs/
├── Architecture.md
├── Deployment.md
├── Operations.md
├── Security.md
├── Troubleshooting.md
├── Decisions.md
└── Lessons-Learned.md

cluster/
applications/
gitops/
infrastructure/
scripts/
diagrams/
screenshots/
```

---

## Documentation

- [Architecture](docs/Architecture.md)
- [Deployment Guide](docs/Deployment.md)
- [Project Inventory](docs/ProjectInventory.md)
- [Technical Decisions](docs/Decisions.md)
- [Progress](docs/Progress.md)

---

## Current Status

**Phase 1 – Project Planning**

* [x] Repository created
* [x] Documentation structure defined
* [ ] Cluster hardware prepared
* [ ] Kubernetes installed
* [ ] Networking configured
* [ ] Monitoring deployed
* [ ] GitOps implemented
* [ ] Backup and recovery procedures documented

---

## Skills Demonstrated

* Linux Administration
* Kubernetes Administration
* Container Orchestration
* Infrastructure as Code
* Git Version Control
* GitHub Workflows
* Platform Engineering
* DevOps Practices
* Monitoring and Observability
* Documentation
* Networking
* Troubleshooting

---

## Future Enhancements

* Multi-node Kubernetes cluster
* High Availability control plane
* Automated cluster provisioning
* Certificate management
* Secrets management
* CI/CD pipelines
* Application deployments
* Backup and disaster recovery
* Cluster upgrades
* Security scanning

---

## Project Journey

This project documents the build of a Kubernetes platform from a single Raspberry Pi host into a fully operational container orchestration environment.

The goal is to demonstrate practical cloud-native engineering skills including:

* Kubernetes administration
* Container orchestration
* Linux platform management
* Infrastructure automation
* Networking
* Git-based documentation and deployment practices

### Current Progress

✅ Repository structure created
✅ Automated deployment scripts developed
✅ Debian host prepared for Kubernetes
✅ k3s Kubernetes cluster deployed
✅ Control-plane node operational
✅ Core Kubernetes services validated
✅ MetalLB LoadBalancer networking configured
✅ Traefik ingress deployed
✅ First application deployed using Kubernetes manifests and Kustomize

### Current Platform

| Component              | Status                 |
| ---------------------- | ---------------------- |
| Kubernetes             | Running                |
| k3s Control Plane      | Operational            |
| Container Runtime      | containerd             |
| Networking             | MetalLB + Traefik      |
| Storage                | Local Path Provisioner |
| Application Deployment | Kustomize              |
| Documentation          | In progress            |

### Build Story

The project started with preparing a Raspberry Pi ARM64 host and creating a repeatable deployment process. Initial Kubernetes deployment required troubleshooting around Linux cgroups and system configuration before achieving a healthy cluster state.

The platform has since progressed to running real Kubernetes workloads, including:

* Namespace management
* Deployments
* ReplicaSets
* Services
* Ingress routing
* External LoadBalancer access

### Next Steps

The next phases will focus on moving the platform closer to production practices:

* Helm application packaging
* GitOps deployment with ArgoCD
* Monitoring with Prometheus and Grafana
* Centralised logging
* Security improvements
* Backup and recovery testing

For the detailed build history, see:

[Project Timeline](docs/ProjectTimeline.md)



## Purpose

This project is maintained as a practical learning platform and professional portfolio to demonstrate real-world Kubernetes administration, infrastructure automation and cloud-native operational practices.

