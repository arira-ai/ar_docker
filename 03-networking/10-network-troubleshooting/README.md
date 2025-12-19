Below is **ALL FILE CONTENT** for **`10-kubernetes-networking-mapping`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `10-kubernetes-networking-mapping/10-kubernetes-networking-mapping.md`

# 10 – Docker to Kubernetes Networking Mapping

## 1. Basics: Why Networking Mapping Matters

Docker networking concepts are the **foundation** for Kubernetes networking.

Kubernetes does **not reinvent networking** — it builds on:

* Linux networking
* Container networking principles
* Overlay and DNS concepts

Understanding this mapping avoids confusion when learning:

* Pods
* Services
* Ingress
* CNI plugins

---

## 2. Core Networking Philosophy Difference

### Docker

* Container-centric
* Explicit network selection
* Manual port mapping

### Kubernetes

* Pod-centric
* Flat cluster network
* Declarative networking

---

## 3. Docker to Kubernetes Networking Mapping Table

| Docker Concept  | Kubernetes Equivalent | Explanation              |
| --------------- | --------------------- | ------------------------ |
| Container       | Pod                   | Smallest deployable unit |
| Bridge network  | Pod network           | Flat IP model            |
| Overlay network | CNI plugin            | Cluster-wide networking  |
| docker0 bridge  | Node network          | Node-level routing       |
| Container IP    | Pod IP                | Routable within cluster  |
| -p port mapping | NodePort              | External access          |
| EXPOSE          | containerPort         | Metadata                 |
| Docker DNS      | CoreDNS               | Service discovery        |
| Service name    | Service name          | Stable access            |
| Host network    | hostNetwork: true     | Node-level networking    |
| None network    | NetworkPolicy deny    | Isolation                |

---

## 4. Kubernetes Networking Model (Flat Network)

Kubernetes enforces:

* Every Pod gets a unique IP
* Pod-to-Pod communication without NAT
* IP reachable across nodes

Network flow:

```
Pod → CNI → Node routing → Remote Pod
```

This model is inspired by **Docker overlay networking**.

---

## 5. Container DNS vs Kubernetes DNS

### Docker DNS

* Embedded DNS (127.0.0.11)
* Resolves container names
* Network-scoped

### Kubernetes CoreDNS

* Cluster-wide DNS
* Resolves Services and Pods
* Namespace-aware

Example:

```
service.namespace.svc.cluster.local
```

---

## 6. Port Exposure: Docker vs Kubernetes

### Docker

```bash
docker run -p 8080:80 nginx
```

### Kubernetes

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
```

Ingress replaces manual port mapping in production.

---

## 7. Network Isolation Mapping

| Docker            | Kubernetes             |
| ----------------- | ---------------------- |
| None network      | NetworkPolicy deny all |
| Separate networks | Namespaces             |
| Firewall rules    | NetworkPolicies        |
| iptables          | kube-proxy + CNI       |

Security is **policy-driven** in Kubernetes.

---

## 8. Hands-on Conceptual Mapping Exercise

### Step 1: Think in Docker Terms

* Container = Pod
* Network = CNI
* Port mapping = Service

### Step 2: Translate to Kubernetes YAML

Docker:

```bash
docker run -d -p 8080:80 nginx
```

Kubernetes:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```

---

## 9. How This Module Helps in Learning Kubernetes

After this module, you can:

* Translate Docker networking to Kubernetes
* Understand Services and Ingress faster
* Debug networking with confidence
* Avoid common beginner mistakes

This is the **bridge module** between Docker and Kubernetes.

---

## 10. Conclusion and Summary

At the end of this module, you learned:

* Direct mapping between Docker and Kubernetes networking
* Why Kubernetes networking feels complex
* How Docker knowledge accelerates Kubernetes mastery
* How CNI, Services, and DNS fit together

If you understand this module, **Kubernetes networking will no longer feel abstract**.

---

## 11. Practice Questions

### Conceptual Questions

1. Why does Kubernetes use a flat network?
2. What replaces Docker overlay networks in Kubernetes?
3. Why is NAT avoided in Kubernetes Pod networking?

---

### Mapping Questions

4. Map Docker `-p` to Kubernetes
5. Map Docker DNS to Kubernetes DNS

---

### Architecture Questions

6. What role does CNI play?
7. How does kube-proxy handle traffic?

---

### Hands-on Thinking Tasks

8. Convert a Docker run command to Kubernetes YAML
9. Identify Docker concepts inside Kubernetes
10. Explain Pod-to-Pod communication across nodes

---

## FILE: `10-kubernetes-networking-mapping/README.md`

# Docker to Kubernetes Networking Mapping

This module connects **all Docker networking concepts** to Kubernetes networking architecture.

## Files Included

* `10-kubernetes-networking-mapping.md` – Conceptual and practical mapping

## Learning Outcome

* Clear mental model of Kubernetes networking
* Faster transition from Docker to Kubernetes
* Strong troubleshooting foundation

---

### Networking Series Completed 🎯

You now have:

* Docker networking fundamentals
* Hands-on labs
* Debugging skills
* Kubernetes networking mapping

If you want next:
👉 **11-kubernetes-cni-deep-dive**
👉 **12-network-policy-hands-on**
👉 **13-ingress-and-loadbalancer**
