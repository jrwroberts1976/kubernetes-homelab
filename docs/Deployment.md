# Deployment Documentation

## Kubernetes Cluster Deployment

## Environment

| Component               | Details            |
| ----------------------- | ------------------ |
| Hardware                | Raspberry Pi       |
| Hostname                | k3s-node-01        |
| Operating System        | Debian 12 Bookworm |
| Architecture            | ARM64              |
| Kubernetes Distribution | k3s                |
| Kubernetes Version      | v1.36.2+k3s1       |

---

## Initial Cluster Deployment

The Kubernetes cluster was deployed using the automated installation script:

```bash
scripts/02-install-k3s.sh
```

The deployment process performs:

* Host prerequisite validation
* Kernel module configuration
* Kubernetes networking configuration
* k3s installation
* Service enablement
* Cluster validation

---

## Cluster Validation

### Node Status

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

## System Components

Command:

```bash
kubectl get pods -A
```

Current core services:

| Component              | Purpose                  |
| ---------------------- | ------------------------ |
| CoreDNS                | Kubernetes internal DNS  |
| Traefik                | Ingress controller       |
| Metrics Server         | Resource metrics         |
| Local Path Provisioner | Persistent storage       |
| Service Load Balancer  | External service routing |

---

## Installed Components

The default k3s installation provides:

### Traefik

Purpose:

* HTTP/HTTPS ingress routing
* Application exposure
* Reverse proxy functionality

### Metrics Server

Purpose:

* CPU metrics
* Memory metrics
* Resource monitoring

### Local Path Provisioner

Purpose:

* Persistent volume support
* Local storage management

---

## Next Steps

Planned improvements:

* Configure GitOps workflow
* Deploy monitoring stack
* Install Prometheus and Grafana
* Configure MetalLB
* Deploy example applications
* Add security policies
* Implement backup procedures
