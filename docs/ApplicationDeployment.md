# Application Deployment - Whoami

## Overview

The first application deployed to the Kubernetes homelab platform.

The deployment demonstrates:

- Kubernetes namespaces
- Deployments
- ReplicaSets
- Services
- Ingress routing
- Kustomize deployment management

## Architecture


Client
|
|
192.168.2.210
|
|
Traefik Ingress Controller
|
|
whoami Service
|
|
+-------------+
| |
Pod Replica 1 Pod Replica 2


## Deployment

Application manifests:


applications/whoami/

├── namespace.yaml
├── deployment.yaml
├── service.yaml
├── ingress.yaml
└── kustomization.yaml


Deployment command:

```bash
kubectl apply -k applications/whoami/
Validation
kubectl get all -n demo

Expected:

2 running pods
ClusterIP service
Deployment available
Notes

The initial deployment used:

kubectl apply -f applications/whoami/

This highlighted the importance of resource ordering when creating namespaces and workloads.

The project was updated to use Kustomize, providing a repeatable deployment method.
