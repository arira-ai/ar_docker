# 06 – Docker Overlay Network

## 1. Basics: What is an Overlay Network?

An **overlay network** enables **container communication across multiple Docker hosts**.

It is used when:

* Containers run on different machines
* Applications need cross-host networking
* Cluster-level communication is required

Overlay networks require **Docker Swarm mode**.



## 2. Key Characteristics of Overlay Network

* Multi-host networking
* Built on VXLAN tunneling
* Encrypted communication (optional)
* Service-based DNS resolution
* Cluster-scoped network

Overlay networking is the **foundation concept for Kubernetes CNI**.



## 3. How Overlay Network Works Internally

High-level flow:

```
Container → VXLAN tunnel → Overlay network → Remote host → Container
```

Internal components:

* Swarm manager maintains network state
* VXLAN encapsulates packets
* Docker DNS resolves service names
* Routing mesh handles traffic distribution


## 4. Docker Overlay vs Kubernetes Networking

| Docker             | Kubernetes         |
| ------------------ | ------------------ |
| Overlay network    | CNI plugin         |
| Service name       | Kubernetes Service |
| Swarm routing mesh | kube-proxy         |
| VXLAN              | VXLAN / IP-in-IP   |

Understanding overlay networks makes **Kubernetes networking concepts easier**.


## 5. Hands-on Practice: Overlay Network Setup

### Step 1: Initialize Docker Swarm

```bash
docker swarm init
```

Verify:

```bash
docker node ls
```

You should see:

* One manager node

---

### Step 2: Create Overlay Network

```bash
docker network create \
  --driver overlay \
  --attachable \
  app-overlay
```

Verify:

```bash
docker network ls
```

---

### Step 3: Deploy Services on Overlay Network

```bash
docker service create \
  --name web \
  --network app-overlay \
  --replicas 2 \
  nginx
```

Verify services:

```bash
docker service ls
docker service ps web
```

---

### Step 4: Test Service Networking

```bash
docker service inspect web
```

Observe:

* Virtual IP (VIP)
* Endpoint mode

Swarm routes traffic to any replica.


## 6. Docker Compose with Overlay Network

Docker Compose can deploy stacks to Swarm using overlay networks.


## 7. How This Helps in Learning Kubernetes

After this module, you understand:

* Cluster-wide networking
* Service discovery across nodes
* Load balancing fundamentals
* Why Kubernetes needs CNI plugins

Overlay networking concepts directly map to:

* Pod-to-Pod networking
* Services
* Ingress controllers



## 8. Conclusion and Summary

At the end of this module, you learned:

* What overlay networks are
* Why Swarm mode is required
* How multi-host container networking works
* How overlay networking maps to Kubernetes

This is the **bridge between Docker and Kubernetes networking**.



## 9. Practice Questions

### Conceptual Questions

1. Why are overlay networks needed?
2. What problem does VXLAN solve?
3. Why does overlay require Swarm?



### Command-Based Questions

4. Command to initialize Docker Swarm
5. Command to create overlay network
6. Command to deploy a service



### Kubernetes-Oriented Questions

7. What replaces overlay networks in Kubernetes?
8. How does kube-proxy compare to routing mesh?



### Hands-on Tasks

9. Scale the service to 5 replicas
10. Inspect service VIP and endpoints
11. Remove the overlay network

<br>
<br>

# Files are readily present in this folder
## FILE: `06-overlay-network/swarm-setup.md`

check the swarm-setup.md file and self help to initilialise the docker swarm-setup

## FILE: `06-overlay-network/docker-compose.yml`

```yaml
version: "3.8"

services:
  frontend:
    image: nginx
    ports:
      - "8084:80"
    networks:
      - app-overlay
    deploy:
      replicas: 2

networks:
  app-overlay:
    driver: overlay
    attachable: true
```


## How to Deploy This Stack

```bash
docker stack deploy -c docker-compose.yml overlay-demo
```

Verify:

```bash
docker stack ls
docker service ls
```

Remove:

```bash
docker stack rm overlay-demo
```


## FILE: `06-overlay-network/README.md`

# Overlay Network Demo Guide

This directory demonstrates **multi-host container networking** using Docker Overlay Networks.

## Files Included

* `06-overlay-network.md` – Concept + theory
* `swarm-setup.md` – Swarm initialization
* `docker-compose.yml` – Overlay-based service deployment

## Key Learning Outcome

* Understand how containers communicate across hosts
* Learn cluster networking fundamentals
* Prepare for Kubernetes CNI concepts