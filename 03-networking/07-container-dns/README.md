Below is **ALL FILE CONTENT** for **`07-container-dns`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `07-container-dns/07-container-dns.md`

# 07 – Container DNS and Service Discovery

## 1. Basics: What is Container DNS?

Container DNS allows containers to **discover and communicate with each other using names instead of IP addresses**.

Docker provides an **embedded DNS server** that:

* Resolves container names
* Resolves service names (Swarm)
* Works automatically with user-defined networks

DNS is essential for **scalable, dynamic container systems**.

---

## 2. Why DNS Is Required in Containers

Without DNS:

* Containers must hardcode IP addresses
* IPs change frequently
* Scaling becomes impossible

With DNS:

* Name-based communication
* Automatic service discovery
* Supports load balancing

---

## 3. How Docker DNS Works Internally

* Docker runs an internal DNS server at `127.0.0.11`
* Containers query this DNS server
* Docker resolves:

  * Container names
  * Service names
  * Network aliases

Internal flow:

```
Container → 127.0.0.11 → Docker DNS → Target container/service
```

---

## 4. Default Bridge vs User-Defined Network DNS

| Feature               | Default Bridge | User-Defined Bridge |
| --------------------- | -------------- | ------------------- |
| DNS resolution        | ❌ No           | ✅ Yes               |
| Container name lookup | ❌              | ✅                   |
| Service discovery     | ❌              | ✅                   |
| Recommended           | ❌              | ✅                   |

Always use **user-defined networks** for DNS support.

---

## 5. Hands-on Practice: Container DNS Resolution

### Step 1: Create User-Defined Network

```bash
docker network create dns-net
```

---

### Step 2: Run Containers

```bash
docker run -dit --name web --network dns-net nginx
docker run -dit --name client --network dns-net busybox sh
```

---

### Step 3: Test DNS Resolution

Enter client container:

```bash
docker exec -it client sh
```

Inside container:

```sh
ping -c 3 web
```

Result:

* DNS resolves `web` to container IP
* Ping succeeds

---

### Step 4: Inspect DNS Configuration

Inside client container:

```sh
cat /etc/resolv.conf
```

Expected:

```
nameserver 127.0.0.11
```

---

### Step 5: Cleanup

```bash
docker rm -f web client
docker network rm dns-net
```

---

## 6. Docker DNS in Swarm Mode

In Swarm:

* DNS resolves service names
* VIP load balancing is enabled
* Multiple replicas are balanced automatically

Example:

```bash
docker service create --name api --network app-overlay nginx
```

DNS name:

```
api
```

---

## 7. Docker DNS vs Kubernetes DNS

| Docker         | Kubernetes   |
| -------------- | ------------ |
| Embedded DNS   | CoreDNS      |
| Container name | Pod name     |
| Service name   | Service name |
| Network alias  | DNS record   |

Understanding Docker DNS simplifies learning **Kubernetes service discovery**.

---

## 8. How This Helps in Learning Kubernetes

This module prepares you to understand:

* CoreDNS
* Service-to-service communication
* Cluster-wide DNS resolution
* Why IPs are never used directly

DNS is a **core pillar of Kubernetes networking**.

---

## 9. Conclusion and Summary

At the end of this module, you learned:

* What container DNS is
* How Docker provides built-in DNS
* How to test DNS resolution
* How DNS maps to Kubernetes CoreDNS

Name-based networking enables **scalable microservices**.

---

## 10. Practice Questions

### Conceptual Questions

1. Why is DNS important in container environments?
2. What IP does Docker use for internal DNS?
3. Why does default bridge not support DNS?

---

### Command-Based Questions

4. Command to create a DNS-enabled network
5. Command to test container DNS resolution

---

### Kubernetes-Oriented Questions

6. What is CoreDNS?
7. How does Kubernetes resolve service names?

---

### Hands-on Tasks

8. Create two containers and resolve names
9. Inspect `/etc/resolv.conf` inside container
10. Remove the network and observe failures

---

## FILE: `07-container-dns/dns-test.sh`

```bash
#!/bin/bash

echo "Creating network..."
docker network create dns-test-net

echo "Starting containers..."
docker run -dit --name web --network dns-test-net nginx
docker run -dit --name client --network dns-test-net busybox sh

echo "Testing DNS resolution..."
docker exec client ping -c 3 web

echo "Cleaning up..."
docker rm -f web client
docker network rm dns-test-net

echo "DNS test completed"
```

Make executable:

```bash
chmod +x dns-test.sh
```

---

## FILE: `07-container-dns/README.md`

# Container DNS Demo

This module demonstrates **name-based container communication** using Docker’s built-in DNS.

## Files Included

* `07-container-dns.md` – Concepts and practice
* `dns-test.sh` – Automated DNS verification script

## Learning Outcome

* Understand container DNS
* Perform service discovery
* Prepare for Kubernetes CoreDNS concepts