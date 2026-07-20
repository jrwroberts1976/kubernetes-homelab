# Architecture Decision Record (ADR)

## ADR-001: Replace k3s ServiceLB with MetalLB

**Status:** Accepted

**Date:** 19 July 2026

### Context

The initial k3s installation includes **ServiceLB (Klipper LoadBalancer)**, which automatically exposes Kubernetes `LoadBalancer` services using the node's IP address.

While ServiceLB is suitable for lightweight clusters and development environments, it is specific to k3s and does not reflect the networking model commonly used in production Kubernetes environments.

As the objective of this project is to demonstrate transferable Kubernetes and platform engineering skills, a more production-oriented load-balancing solution was required.

### Decision

The built-in **k3s ServiceLB** will be disabled and replaced with **MetalLB**.

MetalLB provides a standards-based implementation of the Kubernetes `LoadBalancer` service type for bare-metal clusters by allocating IP addresses from a dedicated pool on the local network.

For this homelab, MetalLB will manage addresses within the following range:

```text
192.168.2.220 - 192.168.2.230
```

### Rationale

MetalLB was selected because it:

* Implements the standard Kubernetes `LoadBalancer` model.
* Is widely adopted for bare-metal Kubernetes deployments.
* Provides experience with IP address pools and Layer 2 advertisements.
* Closely mirrors cloud networking concepts found in AWS, Azure and Google Cloud.
* Demonstrates skills that are directly transferable to production Kubernetes environments.

### Consequences

#### Benefits

* Cloud-like networking on bare-metal infrastructure.
* Improved understanding of Kubernetes networking concepts.
* Better separation between infrastructure and application services.
* Enables future deployment of externally accessible services such as Grafana, Argo CD and custom applications.
* Increases the professional value of the project for portfolio and CV purposes.

#### Trade-offs

* Requires additional Kubernetes resources to operate.
* Introduces management of IP address pools.
* Adds a dependency on MetalLB components.

### Implementation

The implementation consists of:

* Disabling the built-in k3s ServiceLB.
* Installing MetalLB using Helm.
* Creating an IP address pool for the local network.
* Configuring Layer 2 advertisements.
* Migrating `LoadBalancer` services to MetalLB-managed IP addresses.

### Outcome

Replacing ServiceLB with MetalLB aligns the homelab more closely with enterprise Kubernetes deployments while providing practical experience with networking concepts commonly used in production environments.

This decision supports the project's primary objective of demonstrating real-world Kubernetes platform engineering skills to prospective employers.
