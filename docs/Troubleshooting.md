# Troubleshooting

## Raspberry Pi: k3s fails with "failed to find memory cgroup (v2)"

### Date

2026-07-19

### Environment

| Component               | Details              |
| ----------------------- | -------------------- |
| Hardware                | Raspberry Pi         |
| Operating System        | Debian 12 (Bookworm) |
| Kubernetes Distribution | k3s                  |
| Architecture            | ARM64                |

---

## Issue

During the initial k3s installation, the service failed to start.

The installation completed successfully, but the Kubernetes service entered a restart loop.

Error message:

```
Error: failed to find memory cgroup (v2)
```

Systemd reported:

```
k3s.service: Main process exited, code=exited, status=1/FAILURE
```

---

## Investigation

The k3s logs showed that the installation progressed through:

* Database initialisation
* Bootstrap data generation
* Kine datastore startup

before failing during resource controller validation.

Checking the Raspberry Pi boot configuration:

```bash
cat /boot/firmware/cmdline.txt
```

showed that Kubernetes-required memory cgroup parameters were missing.

---

## Root Cause

Kubernetes requires Linux cgroup controllers to manage resources such as:

* CPU limits
* Memory limits
* Pod resource quotas

The Raspberry Pi Debian configuration did not have the memory cgroup controller enabled during boot.

---

## Resolution

Updated:

```
/boot/firmware/cmdline.txt
```

Added the following parameters to the existing single-line configuration:

```
cgroup_memory=1 cgroup_enable=memory
```

Rebooted the Raspberry Pi:

```bash
sudo reboot
```

Verified cgroup availability:

```bash
cat /proc/cgroups | grep memory
```

Restarted k3s:

```bash
sudo systemctl restart k3s
```

Validated the cluster:

```bash
kubectl get nodes
```

---

## Lessons Learned

* Kubernetes installations should validate host prerequisites before deployment.
* Raspberry Pi Kubernetes environments require additional kernel configuration compared with standard server installations.
* Automation scripts should include pre-flight checks for:

  * cgroup availability
  * swap configuration
  * kernel modules
  * network requirements

---

## Future Improvement

The k3s installation script will be enhanced to detect missing Kubernetes prerequisites before attempting installation.

Planned checks:

* Verify memory cgroup support
* Validate kernel modules
* Confirm required sysctl settings
* Provide actionable remediation instructions

## Kubernetes Swap Configuration

### Issue

Kubernetes nodes should run with swap disabled. Raspberry Pi Debian installations commonly use `dphys-swapfile` to manage swap.

### Check swap status

```bash
swapon --show

Resolution

Disable the Raspberry Pi swap service:

sudo dphys-swapfile swapoff
sudo systemctl disable dphys-swapfile
sudo systemctl stop dphys-swapfile
Validation

Confirm swap is disabled:

free -h

Expected:

Swap: 0B
Reason

Kubernetes relies on Linux cgroups for resource management. Disabling swap ensures predictable pod memory scheduling and avoids kubelet resource management conflicts.
