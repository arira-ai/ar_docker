Below is **ALL FILE CONTENT** for **`09-container-network-inspection-and-debugging`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `09-container-network-inspection-and-debugging/09-container-network-inspection-and-debugging.md`

# 09 – Container Network Inspection and Debugging

## 1. Basics: Why Network Debugging Matters

Container networking issues are common due to:

* Isolation layers
* NAT and iptables
* Dynamic IPs
* DNS failures

Effective debugging requires understanding both **Docker-level** and **Linux-level** networking tools.

---

## 2. Common Container Networking Problems

* Container cannot reach internet
* Services unreachable from host
* DNS resolution failure
* Port conflicts
* Network misconfiguration

---

## 3. Core Networking Inspection Commands

### Docker-Level Commands

```bash
docker network ls
docker network inspect <network>
docker inspect <container>
docker ps
```

---

### Linux-Level Commands (Inside Container)

```bash
ip addr
ip route
ss -tuln
cat /etc/resolv.conf
```

---

### Host-Level Commands

```bash
iptables -t nat -L -n
ss -tuln
ip addr show
```

---

## 4. Understanding Container Network Namespaces

Each container has its own network namespace.

Namespace tools:

```bash
lsns -t net
nsenter -t <PID> -n bash
```

Find container PID:

```bash
docker inspect --format '{{.State.Pid}}' <container>
```

---

## 5. Hands-on Practice: Network Debugging Lab

### Step 1: Create Network and Containers

```bash
docker network create debug-net
docker run -dit --name web --network debug-net nginx
docker run -dit --name client --network debug-net busybox sh
```

---

### Step 2: Inspect Network

```bash
docker network inspect debug-net
```

Observe:

* Subnet
* Gateway
* Connected containers

---

### Step 3: Debug Connectivity

From client container:

```bash
docker exec -it client sh
```

Inside container:

```sh
ping web
ip route
cat /etc/resolv.conf
```

---

### Step 4: Debug Port Exposure

```bash
docker run -d --name exposed -p 8086:80 nginx
ss -tuln | grep 8086
```

---

### Step 5: Use nsenter for Deep Debugging

```bash
PID=$(docker inspect --format '{{.State.Pid}}' web)
nsenter -t $PID -n ip addr
```

---

### Step 6: Cleanup

```bash
docker rm -f web client exposed
docker network rm debug-net
```

---

## 6. tcpdump for Container Traffic

Capture traffic on Docker bridge:

```bash
tcpdump -i docker0
```

Inside container namespace:

```bash
nsenter -t <PID> -n tcpdump -i eth0
```

---

## 7. Docker Debugging vs Kubernetes Debugging

| Docker         | Kubernetes       |
| -------------- | ---------------- |
| docker exec    | kubectl exec     |
| docker inspect | kubectl describe |
| nsenter        | kubectl debug    |
| docker network | CNI plugin       |

These skills **directly transfer** to Kubernetes troubleshooting.

---

## 8. How This Helps in Learning Kubernetes

This module prepares you to:

* Debug Pod networking issues
* Inspect Services and Endpoints
* Understand kube-proxy behavior
* Troubleshoot DNS and connectivity

Networking debugging is a **core SRE skill**.

---

## 9. Conclusion and Summary

At the end of this module, you learned:

* How to inspect container networks
* Essential debugging commands
* Namespace-based troubleshooting
* How Docker networking maps to Kubernetes debugging

These skills are **mandatory for production troubleshooting**.

---

## 10. Practice Questions

### Conceptual Questions

1. What is a network namespace?
2. Why do containers use NAT?
3. What causes DNS failures in containers?

---

### Command-Based Questions

4. Command to inspect a Docker network
5. Command to enter a container network namespace

---

### Kubernetes-Oriented Questions

6. Kubernetes equivalent of `docker inspect`
7. How do you debug Pod networking issues?

---

### Hands-on Tasks

8. Inspect a container network
9. Use nsenter to check interfaces
10. Capture traffic using tcpdump

---

## FILE: `09-container-network-inspection-and-debugging/debug-network.sh`

```bash
#!/bin/bash

echo "Setting up debugging environment..."

docker network create debug-net
docker run -dit --name debug-web --network debug-net nginx
docker run -dit --name debug-client --network debug-net busybox sh

echo "Inspecting network..."
docker network inspect debug-net

echo "Testing connectivity..."
docker exec debug-client ping -c 3 debug-web

echo "Finding container PID..."
PID=$(docker inspect --format '{{.State.Pid}}' debug-web)

echo "Inspecting network namespace using nsenter..."
nsenter -t $PID -n ip addr

echo "Cleaning up..."
docker rm -f debug-web debug-client
docker network rm debug-net

echo "Network debugging demo completed"
```

Make executable:

```bash
chmod +x debug-network.sh
```

---

## FILE: `09-container-network-inspection-and-debugging/README.md`

# Container Network Inspection and Debugging

This module focuses on **real-world container network troubleshooting**.

## Files Included

* `09-container-network-inspection-and-debugging.md` – Concepts and labs
* `debug-network.sh` – Automated debugging lab

## Learning Outcome

* Inspect Docker networks
* Debug container connectivity
* Prepare for Kubernetes troubleshooting

---

### Next Recommended Module

👉 **10-kubernetes-networking-mapping**

This will tie **all Docker networking concepts** directly into Kubernetes networking architecture (CNI, Services, Ingress).
