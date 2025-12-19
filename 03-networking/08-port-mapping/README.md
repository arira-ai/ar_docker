Below is **ALL FILE CONTENT** for **`08-port-mapping-and-exposure`**, fully **ready-to-copy & paste** into your repository.
Create the files exactly as named and paste the content **as-is**.

---

## FILE: `08-port-mapping-and-exposure/08-port-mapping-and-exposure.md`

# 08 – Port Mapping and Port Exposure in Docker

## 1. Basics: What is Port Mapping?

Port mapping allows **external traffic** (host or internet) to access a **container’s internal port**.

Docker containers:

* Run in isolated networks
* Are not reachable externally by default
* Require port mapping to expose services

Syntax:

```bash
-p <host_port>:<container_port>
```

---

## 2. Difference Between EXPOSE and -p

| Feature           | EXPOSE        | -p / --publish      |
| ----------------- | ------------- | ------------------- |
| Purpose           | Documentation | Actual port binding |
| Opens port        | ❌ No          | ✅ Yes               |
| Runtime effect    | ❌ None        | ✅ Host access       |
| Kubernetes impact | Informational | Service required    |

`EXPOSE` **does not publish ports** — it only declares intent.

---

## 3. How Port Mapping Works Internally

Packet flow:

```
Client → Host Port → iptables NAT → Container Port
```

Docker uses:

* iptables rules
* NAT (DNAT/SNAT)
* Kernel networking

You can view rules:

```bash
iptables -t nat -L -n
```

---

## 4. Docker Port Mapping vs Kubernetes Services

| Docker         | Kubernetes          |
| -------------- | ------------------- |
| -p 8080:80     | NodePort            |
| Container port | Pod port            |
| Host port      | Node port           |
| Manual mapping | Declarative Service |

Docker teaches the **fundamentals** behind Kubernetes Services.

---

## 5. Hands-on Practice: Port Mapping

### Step 1: Run Nginx Without Port Mapping

```bash
docker run -d --name web nginx
```

Try access:

```
http://localhost
```

Result:

* ❌ Not reachable

---

### Step 2: Run Nginx With Port Mapping

```bash
docker run -d --name web-published -p 8080:80 nginx
```

Access:

```
http://localhost:8080
```

Result:

* ✅ Nginx page loads

---

### Step 3: Inspect Port Mapping

```bash
docker ps
```

Output includes:

```
0.0.0.0:8080->80/tcp
```

Inspect details:

```bash
docker inspect web-published
```

---

### Step 4: Multiple Port Mapping

```bash
docker run -d --name multi-port \
  -p 8081:80 \
  -p 8443:443 \
  nginx
```

---

### Step 5: Cleanup

```bash
docker rm -f web web-published multi-port
```

---

## 6. EXPOSE Instruction in Dockerfile

Example:

```Dockerfile
FROM nginx
EXPOSE 80
```

Build and run:

```bash
docker build -t expose-demo .
docker run -d -p 8082:80 expose-demo
```

`EXPOSE` helps:

* Documentation
* Tooling
* Kubernetes port definitions

---

## 7. Security Considerations

* Avoid exposing unnecessary ports
* Use non-default host ports
* Bind to localhost if needed:

```bash
-p 127.0.0.1:8080:80
```

---

## 8. How This Helps in Learning Kubernetes

This module prepares you to understand:

* NodePort services
* TargetPort vs Port
* Ingress controllers
* LoadBalancer services

Docker port mapping is the **foundation of Kubernetes service exposure**.

---

## 9. Conclusion and Summary

At the end of this module, you learned:

* What port mapping is
* Difference between EXPOSE and publish
* How Docker exposes container services
* How Docker port mapping maps to Kubernetes Services

Correct port exposure is **critical for production safety**.

---

## 10. Practice Questions

### Conceptual Questions

1. What is port mapping?
2. Why does EXPOSE not open ports?
3. What happens if two containers map the same host port?

---

### Command-Based Questions

4. Command to map host port 8080 to container port 80
5. Command to inspect port mappings

---

### Kubernetes-Oriented Questions

6. How does NodePort work?
7. Difference between NodePort and LoadBalancer?

---

### Hands-on Tasks

8. Run a container without port mapping and test access
9. Run two containers mapping same port and observe error
10. Bind container to localhost only

---

## FILE: `08-port-mapping-and-exposure/port-test.sh`

```bash
#!/bin/bash

echo "Running nginx with port mapping..."
docker run -d --name port-demo -p 8085:80 nginx

echo "Access http://localhost:8085"

sleep 10

echo "Inspecting port mapping..."
docker ps | grep port-demo

echo "Cleaning up..."
docker rm -f port-demo

echo "Port mapping demo completed"
```

Make executable:

```bash
chmod +x port-test.sh
```

---

## FILE: `08-port-mapping-and-exposure/README.md`

# Port Mapping and Exposure Demo

This module demonstrates how Docker exposes container services using host port mapping.

## Files Included

* `08-port-mapping-and-exposure.md` – Concepts and labs
* `port-test.sh` – Automated port mapping test

## Learning Outcome

* Understand container exposure
* Avoid port conflicts
* Prepare for Kubernetes Service concepts

---

### Next Recommended Module

👉 **09-container-network-inspection-and-debugging**

If you want, I’ll continue with **network debugging tools (ip, ss, tcpdump, nsenter)** in the same ready-made format.
