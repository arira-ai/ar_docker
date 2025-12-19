Below is **ALL FILE CONTENT** for **`11-kubernetes-cni-deep-dive`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `11-kubernetes-cni-deep-dive/11-kubernetes-cni-deep-dive.md`

# 11 – Kubernetes CNI Deep Dive

## 1. Basics: What is CNI?

**CNI (Container Network Interface)** is a standard that defines **how containers are connected to a network**.

Kubernetes uses CNI plugins to:

* Assign Pod IP addresses
* Configure routing
* Enable Pod-to-Pod communication
* Enforce networking rules

Without CNI, Kubernetes Pods **cannot communicate**.

---

## 2. Why Kubernetes Needs CNI

Kubernetes networking requirements:

* Every Pod gets a unique IP
* No NAT between Pods
* Pods can communicate across nodes
* Network plugins are pluggable

CNI solves these requirements **without hardcoding networking logic**.

---

## 3. How CNI Works Internally

CNI is invoked by **kubelet** during Pod lifecycle.

High-level flow:

```
Pod creation
   ↓
kubelet
   ↓
CNI plugin (ADD)
   ↓
Network namespace setup
   ↓
Pod IP assigned
```

When Pod is deleted:

```
kubelet → CNI plugin (DEL)
```

---

## 4. CNI Configuration Files

CNI configuration location:

```
/etc/cni/net.d/
```

Binary plugins:

```
/opt/cni/bin/
```

Example CNI config:

```json
{
  "cniVersion": "0.4.0",
  "name": "pod-network",
  "type": "bridge",
  "bridge": "cni0",
  "ipam": {
    "type": "host-local",
    "subnet": "10.244.0.0/16"
  }
}
```

---

## 5. Types of CNI Plugins

| Plugin     | Purpose                  |
| ---------- | ------------------------ |
| bridge     | Simple bridge networking |
| host-local | IPAM                     |
| loopback   | Pod loopback             |
| calico     | Policy-based networking  |
| flannel    | Simple overlay           |
| cilium     | eBPF-based networking    |
| weave      | Mesh overlay             |

---

## 6. Popular Kubernetes CNI Implementations

| CNI     | Features            |
| ------- | ------------------- |
| Flannel | Simple, overlay     |
| Calico  | Network policy, BGP |
| Cilium  | eBPF, observability |
| Weave   | Mesh networking     |

CNI choice affects:

* Performance
* Security
* Observability

---

## 7. Hands-on Practice: Inspect CNI on a Cluster

### Step 1: Check CNI Pods

```bash
kubectl get pods -n kube-system
```

Look for:

* calico-node
* flannel
* cilium

---

### Step 2: Inspect CNI Config on Node

```bash
ls /etc/cni/net.d/
```

---

### Step 3: Inspect Pod Network Interface

```bash
kubectl get pod -o wide
```

Note:

* Pod IP
* Node placement

---

### Step 4: Exec into Pod

```bash
kubectl exec -it <pod-name> -- ip addr
```

---

## 8. CNI and NetworkPolicy

CNI plugins enforce **NetworkPolicy**.

| CNI     | NetworkPolicy Support |
| ------- | --------------------- |
| Flannel | ❌ No                  |
| Calico  | ✅ Yes                 |
| Cilium  | ✅ Yes                 |

NetworkPolicy works **only if CNI supports it**.

---

## 9. CNI vs Docker Overlay Networking

| Docker Overlay | Kubernetes CNI      |
| -------------- | ------------------- |
| Swarm-based    | Cluster-native      |
| Service VIP    | Service abstraction |
| VXLAN          | VXLAN / BGP / eBPF  |
| Limited policy | Full policy support |

CNI is **more powerful and flexible**.

---

## 10. How This Module Helps in Learning Kubernetes

This module enables you to:

* Understand Pod networking internals
* Debug networking issues
* Choose the right CNI
* Design secure clusters

CNI knowledge is **mandatory for production Kubernetes**.

---

## 11. Conclusion and Summary

At the end of this module, you learned:

* What CNI is and why it exists
* How kubelet invokes CNI
* Types of CNI plugins
* Real-world CNI implementations

CNI is the **backbone of Kubernetes networking**.

---

## 12. Practice Questions

### Conceptual Questions

1. What problem does CNI solve?
2. Why doesn’t Kubernetes implement networking directly?
3. What happens during CNI ADD?

---

### Configuration Questions

4. Where are CNI config files stored?
5. Where are CNI binaries located?

---

### Architecture Questions

6. Difference between Calico and Flannel?
7. Why is eBPF important for CNI?

---

### Hands-on Thinking Tasks

8. Identify the CNI plugin in your cluster
9. Inspect Pod network interfaces
10. Check NetworkPolicy enforcement

---

## FILE: `11-kubernetes-cni-deep-dive/README.md`

# Kubernetes CNI Deep Dive

This module explains **how Kubernetes networking works under the hood** using CNI.

## Files Included

* `11-kubernetes-cni-deep-dive.md` – Deep technical explanation

## Learning Outcome

* Master Kubernetes networking internals
* Debug complex networking issues
* Confidently choose and operate CNI plugins

---

### Next Recommended Modules

👉 **12-network-policy-hands-on**
👉 **13-ingress-and-loadbalancer**

Say the word and I’ll generate them in the same **production-grade, copy-ready** format.
