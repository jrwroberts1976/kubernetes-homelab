# Kubernetes Homelab Architecture

## Overview

This document describes the initial Kubernetes cluster architecture.

The cluster is built using k3s running on Raspberry Pi hardware and is designed as a lightweight production-style Kubernetes environment for learning and demonstrating cloud-native operational practices.

---

## Cluster Topology

Current deployment:

```text
                    Home Network
                         |
                         |
                  192.168.2.195
                         |
                  k3s-node-01
                         |
              Kubernetes Control Plane
                         |
        ---------------------------------
        |              |                |
     CoreDNS       Traefik        Metrics Server
        |
 Local Path Provisioner
```

---

## Node Inventory

| Node        | Role          | IP Address    | Operating System   |
| ----------- | ------------- | ------------- | ------------------ |
| k3s-node-01 | Control Plane | 192.168.2.195 | Debian 12 Bookworm |

---

## Kubernetes Platform

| Component               | Version      |
| ----------------------- | ------------ |
| Kubernetes Distribution | k3s          |
| Kubernetes Version      | v1.36.2+k3s1 |
| Container Runtime       | containerd   |
| Architecture            | ARM64        |

---

## Default Cluster Services

The initial k3s deployment includes:

### CoreDNS

Provides internal Kubernetes DNS resolution.

### Traefik

Provides ingress routing for exposing applications.

### Metrics Server

Provides resource metrics used by Kubernetes tooling.

### Local Path Provisioner

Provides local persistent storage.

---

## Current State

The cluster currently operates as a single-node Kubernetes environment.

Future expansion:

* Add Raspberry Pi worker nodes
* Configure multi-node scheduling
* Add external load balancing
* Implement GitOps workflows
* Deploy monitoring and logging
* Add backup and recovery processes

---

## Validation Commands

Check cluster status:

```bash
kubectl get nodes
```

Display node details:

```bash
kubectl get nodes -o wide
```

Display all workloads:

```bash
kubectl get pods -A
```
