# 01 – Docker Network Basics

## 1. Basics: What is Docker Networking?

Docker networking allows containers to **communicate with each other**, with the **Docker host**, and with **external systems** (internet, APIs, databases).

By default, Docker creates virtual networks and connects containers to them automatically.

Key goals of Docker networking:

* Isolation between containers
* Controlled communication
* Port exposure to host
* Scalable application design



## 2. Why Container Networking Exists

Without container networking:

* Containers would be isolated processes with no communication
* Multi-tier applications (frontend, backend, DB) would not work
* Kubernetes-style service discovery would not be possible

Docker networking solves:

* IP assignment
* DNS resolution
* Traffic routing
* Network isolation


## 3. Core Networking Components in Docker

### Linux Bridge

* Virtual switch on the host
* Connects containers together
* Default bridge name: `docker0`

### veth (Virtual Ethernet)

* Network cable between container and bridge
* One end inside container
* One end on host bridge

### IP Addressing

* Each container gets a private IP
* Managed by Docker IPAM


## 4. Docker Network Types (Overview)

| Network Type | Purpose                        |
| ------------ | ------------------------------ |
| bridge       | Default single-host networking |
| host         | No network isolation           |
| none         | Complete isolation             |
| overlay      | Multi-host networking          |
| macvlan      | Direct LAN access              |

## 5. How Docker Networking Works (Kubernetes Context)

### Docker Networking Flow

1. Docker creates a network namespace
2. A veth pair is created
3. One end attached to container
4. Other end attached to bridge
5. IP assigned via IPAM
6. NAT used for external access



### Docker vs Kubernetes Networking

| Docker         | Kubernetes |
| -------------- | ---------- |
| Container IP   | Pod IP     |
| Bridge network | CNI Plugin |
| Port mapping   | Service    |
| Docker DNS     | CoreDNS    |

Understanding Docker networking makes Kubernetes networking **much easier**.


## 6. Hands-on Practice: Exploring Network Basics

### Step 1: List Docker Networks

```bash
docker network ls
```

Expected output:

* bridge
* host
* none

---

### Step 2: Inspect Default Bridge Network

```bash
docker network inspect bridge
```

Observe:

* Subnet
* Gateway
* Connected containers

---

### Step 3: Run a Container and Check Network

```bash
docker run -d --name net-demo nginx
```

Inspect container network:

```bash
docker inspect net-demo
```

Look for:

* IPAddress
* NetworkMode

---

### Step 4: Access Container from Host

```bash
docker run -d -p 8081:80 --name net-web nginx
```

Access via browser:

```
http://localhost:8081
```

---

### Step 5: Test Outbound Connectivity

```bash
docker exec -it net-demo ping -c 3 google.com
```

This confirms:

* DNS resolution
* Internet access


## 7. How This Helps in Learning Kubernetes

After this module, you understand:

* How containers get IPs
* How traffic flows inside a host
* How NAT and bridges work
* Why Kubernetes uses CNI instead of Docker bridges

This knowledge is essential before learning:

* Pod networking
* Services
* Ingress


## 8. Conclusion and Summary

At the end of this module, you learned:

* What Docker networking is
* Why container networking is needed
* Core networking components (bridge, veth, IPAM)
* Docker network types
* How Docker networking maps to Kubernetes

This is the **foundation of container and Kubernetes networking**.


## 9. Practice Questions

### Conceptual Questions

1. What problem does Docker networking solve?
2. What is a Linux bridge?
3. What is a veth pair?
4. How does Docker assign IP addresses?


### Command-Based Questions

5. Command to list Docker networks
6. Command to inspect a Docker network
7. Command to inspect a container network

### Kubernetes-Oriented Questions

8. What replaces Docker bridge in Kubernetes?
9. Why does Kubernetes not use port mapping?
10. How does Kubernetes handle DNS differently?

### Hands-on Tasks

11. Run two containers and inspect their IPs
12. Verify internet access from a container
13. Inspect bridge network before and after running containers