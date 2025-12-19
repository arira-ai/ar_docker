Below is **ALL FILE CONTENT** for **`13-ingress-and-loadbalancer`**, fully **ready-to-copy & paste**, strictly following your locked requirements.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `13-ingress-and-loadbalancer/13-ingress-and-loadbalancer.md`

# 13 – Kubernetes Ingress and LoadBalancer

## 1. Basics: Why Ingress and LoadBalancer Exist

In Kubernetes, Pods are not exposed externally by default.

Kubernetes provides **three main ways** to expose applications:

* NodePort
* LoadBalancer
* Ingress

Ingress is the **production-standard** approach.

---

## 2. Service Types Overview

| Service Type | Purpose              | Production Use |
| ------------ | -------------------- | -------------- |
| ClusterIP    | Internal-only access | Yes            |
| NodePort     | Expose via node port | Limited        |
| LoadBalancer | Cloud LB integration | Yes            |
| Ingress      | HTTP/HTTPS routing   | Best practice  |

Ingress always works **on top of Services**.

---

## 3. LoadBalancer Service Explained

A **LoadBalancer Service**:

* Provisions a cloud load balancer
* Exposes the Service externally
* Routes traffic to Pods

Traffic flow:

```
Client → Cloud LoadBalancer → Service → Pod
```

---

## 4. Hands-on: LoadBalancer Service

### Step 1: Deploy Application

```bash
kubectl create namespace ingress-demo
kubectl create deployment web --image=nginx -n ingress-demo
kubectl expose deployment web --port=80 -n ingress-demo
```

---

### Step 2: Create LoadBalancer Service

---

## FILE: `13-ingress-and-loadbalancer/loadbalancer-service.yaml`

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-lb
  namespace: ingress-demo
spec:
  type: LoadBalancer
  selector:
    app: web
  ports:
  - port: 80
    targetPort: 80
```

Apply:

```bash
kubectl apply -f loadbalancer-service.yaml
```

Check:

```bash
kubectl get svc -n ingress-demo
```

---

## 5. Limitations of LoadBalancer

* One load balancer per Service
* Expensive in cloud
* No path-based routing
* Limited TLS control

This leads to **Ingress**.

---

## 6. What is Ingress?

Ingress provides:

* Path-based routing
* Host-based routing
* TLS termination
* Single entry point

Traffic flow:

```
Client → Ingress Controller → Service → Pod
```

Ingress **requires an Ingress Controller**.

---

## 7. Ingress Controller Overview

Popular controllers:

* NGINX Ingress
* Traefik
* HAProxy
* Cloud-native controllers

Ingress Controller runs as Pods in the cluster.

---

## 8. Hands-on: Ingress Setup (NGINX)

### Step 1: Install NGINX Ingress Controller (Minikube)

```bash
minikube addons enable ingress
```

Verify:

```bash
kubectl get pods -n ingress-nginx
```

---

### Step 2: Deploy Two Applications

```bash
kubectl create deployment app1 --image=nginx -n ingress-demo
kubectl create deployment app2 --image=nginx -n ingress-demo

kubectl expose deployment app1 --port=80 -n ingress-demo
kubectl expose deployment app2 --port=80 -n ingress-demo
```

---

## 9. Create Ingress Resource

---

## FILE: `13-ingress-and-loadbalancer/ingress.yaml`

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: demo-ingress
  namespace: ingress-demo
spec:
  rules:
  - host: demo.local
    http:
      paths:
      - path: /app1
        pathType: Prefix
        backend:
          service:
            name: app1
            port:
              number: 80
      - path: /app2
        pathType: Prefix
        backend:
          service:
            name: app2
            port:
              number: 80
```

Apply:

```bash
kubectl apply -f ingress.yaml
```

---

## 10. Test Ingress

### Step 1: Update Hosts File

```text
<INGRESS_IP> demo.local
```

Get IP:

```bash
kubectl get ingress -n ingress-demo
```

---

### Step 2: Test Access

```bash
curl http://demo.local/app1
curl http://demo.local/app2
```

---

## 11. Docker to Kubernetes Mapping

| Docker          | Kubernetes         |
| --------------- | ------------------ |
| -p 8080:80      | NodePort           |
| Reverse proxy   | Ingress Controller |
| Nginx container | Ingress Pod        |
| Port mapping    | Routing rules      |

Ingress is the **Kubernetes-native reverse proxy**.

---

## 12. How This Helps in Learning Kubernetes

This module teaches you:

* External traffic management
* Production-grade routing
* TLS-ready architecture
* Cost-effective exposure

Ingress is **mandatory knowledge** for real clusters.

---

## 13. Conclusion and Summary

At the end of this module, you learned:

* Difference between LoadBalancer and Ingress
* When to use each
* How traffic flows externally
* How Docker concepts map to Kubernetes exposure

Ingress represents **maturity in Kubernetes networking**.

---

## 14. Practice Questions

### Conceptual Questions

1. Why is Ingress preferred over LoadBalancer?
2. What is an Ingress Controller?
3. Can Ingress work without a Service?

---

### YAML Questions

4. Write a LoadBalancer Service YAML
5. Write an Ingress with two paths

---

### Hands-on Tasks

6. Deploy NGINX Ingress
7. Route traffic using paths
8. Enable TLS on Ingress

---

## FILE: `13-ingress-and-loadbalancer/README.md`

# Ingress and LoadBalancer

This module demonstrates **production-grade service exposure** in Kubernetes.

## Files Included

* `13-ingress-and-loadbalancer.md` – Concepts and labs
* `loadbalancer-service.yaml` – LoadBalancer example
* `ingress.yaml` – Path-based routing

## Learning Outcome

* Master external access patterns
* Understand Kubernetes traffic flow
* Design scalable architectures

---

### 🎉 Networking Track Completed

You now have:

* Docker networking mastery
* Kubernetes networking foundations
* Security and policies
* Production ingress patterns

If you want next:
👉 **14-service-mesh-basics**
👉 **15-cilium-ebpf-deep-dive**
👉 **16-real-world-network-troubleshooting**

Just say the module number.
