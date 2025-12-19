Below is **ALL FILE CONTENT** for **`12-network-policy-hands-on`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `12-network-policy-hands-on/12-network-policy-hands-on.md`

# 12 – Kubernetes NetworkPolicy Hands-on

## 1. Basics: What is a NetworkPolicy?

A **NetworkPolicy** defines **how Pods are allowed to communicate** with each other and with external endpoints.

By default:

* All Pod-to-Pod traffic is **allowed**
* NetworkPolicy is used to **restrict traffic**

NetworkPolicy enforces **zero-trust networking**.

---

## 2. Prerequisites

Before applying NetworkPolicy:

* A CNI plugin that supports NetworkPolicy (Calico, Cilium)
* Kubernetes cluster up and running
* kubectl access

Check CNI:

```bash
kubectl get pods -n kube-system
```

---

## 3. NetworkPolicy Core Concepts

| Concept           | Description            |
| ----------------- | ---------------------- |
| PodSelector       | Selects Pods           |
| Ingress           | Incoming traffic rules |
| Egress            | Outgoing traffic rules |
| NamespaceSelector | Namespace-based rules  |
| ipBlock           | CIDR-based rules       |

---

## 4. Default Behavior Without NetworkPolicy

* Pods can communicate freely
* No isolation exists
* Security risk in production

---

## 5. Hands-on Lab Setup

### Step 1: Create Namespace

```bash
kubectl create namespace netpol-demo
```

---

### Step 2: Deploy Test Pods

```bash
kubectl run frontend --image=nginx -n netpol-demo --labels="app=frontend"
kubectl run backend --image=nginx -n netpol-demo --labels="app=backend"
kubectl run attacker --image=busybox -n netpol-demo --labels="app=attacker" -- sleep 3600
```

---

### Step 3: Test Connectivity (Before Policy)

```bash
kubectl exec -n netpol-demo attacker -- wget -qO- frontend
kubectl exec -n netpol-demo attacker -- wget -qO- backend
```

Result:

* All requests succeed

---

## 6. Apply Default Deny Policy

Create default deny ingress policy.

---

## FILE: `12-network-policy-hands-on/deny-all-ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: netpol-demo
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

Apply:

```bash
kubectl apply -f deny-all-ingress.yaml
```

---

### Step 4: Test Connectivity (After Deny)

```bash
kubectl exec -n netpol-demo attacker -- wget -qO- frontend
```

Result:

* ❌ Connection blocked

---

## 7. Allow Frontend to Backend Only

---

## FILE: `12-network-policy-hands-on/allow-frontend-to-backend.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: netpol-demo
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
```

Apply:

```bash
kubectl apply -f allow-frontend-to-backend.yaml
```

---

### Step 5: Test Connectivity

```bash
kubectl exec -n netpol-demo frontend -- wget -qO- backend
kubectl exec -n netpol-demo attacker -- wget -qO- backend
```

Result:

* frontend → backend: ✅ allowed
* attacker → backend: ❌ denied

---

## 8. Egress Control Example

---

## FILE: `12-network-policy-hands-on/deny-egress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-egress
  namespace: netpol-demo
spec:
  podSelector:
    matchLabels:
      app: attacker
  policyTypes:
  - Egress
```

Apply:

```bash
kubectl apply -f deny-egress.yaml
```

---

## 9. How This Helps in Learning Kubernetes

This module teaches you:

* Zero-trust networking
* Production-grade isolation
* Real security enforcement
* How Kubernetes controls traffic

NetworkPolicy is **mandatory in secure clusters**.

---

## 10. Conclusion and Summary

At the end of this module, you learned:

* How NetworkPolicy works
* How to deny all traffic
* How to allow specific flows
* How to test and validate policies

This skill is **core for Kubernetes security**.

---

## 11. Practice Questions

### Conceptual Questions

1. Why is NetworkPolicy needed?
2. What is default deny?
3. Why does CNI matter for NetworkPolicy?

---

### YAML Questions

4. How do you deny all ingress?
5. How do you allow traffic from specific Pods?

---

### Hands-on Tasks

6. Block all traffic in a namespace
7. Allow frontend to backend only
8. Add egress rules to allow DNS

---

## FILE: `12-network-policy-hands-on/README.md`

# NetworkPolicy Hands-on Lab

This module provides **real-world Kubernetes NetworkPolicy exercises**.

## Files Included

* `12-network-policy-hands-on.md` – Concepts and labs
* `deny-all-ingress.yaml` – Default deny
* `allow-frontend-to-backend.yaml` – Allow specific traffic
* `deny-egress.yaml` – Egress control

## Learning Outcome

* Secure Kubernetes networking
* Implement zero-trust architecture
* Prepare for production clusters

---

### Next Recommended Module

👉 **13-ingress-and-loadbalancer**

Say the word and I’ll generate it with **Ingress YAMLs, Services, and traffic flow labs**.
