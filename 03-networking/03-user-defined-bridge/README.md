# 03 – User-Defined Bridge Network

## 1. Basics: What is a User-Defined Bridge Network?

A **user-defined bridge network** is a custom Docker network created by the user instead of relying on the default `bridge` network.

Key characteristics:

* Automatic DNS-based service discovery
* Better isolation
* Predictable communication
* Recommended for real-world applications

Unlike the default bridge, containers can communicate **using container names**.



## 2. Why User-Defined Bridge is Important

Problems with default bridge:

* No DNS resolution
* Manual IP management
* Poor scalability

User-defined bridge solves:

* Container name resolution
* Cleaner networking
* Microservice-style communication

## 3. How User-Defined Bridge Works Internally

* Docker creates a **custom Linux bridge**
* Containers are attached to this bridge
* Embedded Docker DNS server handles name resolution
* Each container gets:

  * Private IP
  * Network alias
  * DNS entry

## 4. Docker vs Kubernetes Networking Mapping

| Docker              | Kubernetes         |
| ------------------- | ------------------ |
| User-defined bridge | Pod network        |
| Container name      | Pod DNS            |
| Embedded DNS        | CoreDNS            |
| Service name        | Kubernetes Service |

This is the **closest Docker equivalent to Kubernetes networking**.

## 5. Hands-on Practice: User-Defined Bridge Network

### Step 1: Create a User-Defined Network

```bash
docker network create app-network
```

Verify:

```bash
docker network ls
```

---

### Step 2: Run Containers on Custom Network

```bash
docker run -d --name app1 --network app-network nginx
docker run -d --name app2 --network app-network nginx
```

---

### Step 3: Test DNS-Based Communication

```bash
docker exec -it app1 ping app2
```

Result:

* Yes, It Works
* Containers resolve names automatically

---

### Step 4: Inspect the Network

```bash
docker network inspect app-network
```

Observe:

* Subnet
* Connected containers
* IPAM configuration



## 6. Docker Compose Demo (User-Defined Bridge)

Docker Compose **automatically creates a user-defined bridge network**.

Benefits:

* Built-in DNS
* Service name communication
* Clean setup

## 7. How This Helps in Learning Kubernetes

After this module, you understand:

* Why DNS-based networking is critical
* How Pods communicate using names
* Why Services exist in Kubernetes
* How CoreDNS works conceptually

This knowledge is mandatory for:

* Services
* Deployments
* StatefulSets

## 8. Conclusion and Summary

At the end of this module, you learned:

* What a user-defined bridge network is
* How it differs from default bridge
* How Docker DNS works
* How Docker networking maps to Kubernetes networking

This is a **production-ready networking concept**.

## 9. Practice Questions

### Conceptual Questions

1. Why is user-defined bridge preferred over default bridge?
2. How does Docker DNS work?
3. What happens if two containers have the same name?

---

### Command-Based Questions

4. Command to create a custom bridge network
5. Command to connect a container to a network

---

### Kubernetes-Oriented Questions

6. How does CoreDNS relate to Docker DNS?
7. Why does Kubernetes avoid IP-based communication?

---

### Hands-on Tasks

8. Create three containers and test name resolution
9. Disconnect a container from the network
10. Remove the network and observe container behavior


<br>
<br>

# Files are readily present in this folder

## FILE: `03-user-defined-bridge/docker-compose.yml`

```yaml
version: "3.8"

services:
  backend:
    image: nginx
    container_name: backend
    networks:
      - app-network

  frontend:
    image: nginx
    container_name: frontend
    ports:
      - "8083:80"
    networks:
      - app-network

networks:
  app-network:
    driver: bridge
```


## FILE: `03-user-defined-bridge/test-connectivity.sh`

```bash
#!/bin/bash

echo "Testing DNS-based connectivity from frontend to backend..."

docker exec frontend ping -c 3 backend

if [ $? -eq 0 ]; then
  echo "SUCCESS: frontend can reach backend using DNS name"
else
  echo "FAILURE: DNS resolution not working"
fi
```

Make executable:

```bash
chmod +x test-connectivity.sh
```


## How to Run This Demo

```bash
cd 03-user-defined-bridge
docker compose up -d
```

Test connectivity:

```bash
./test-connectivity.sh
```

Inspect network:

```bash
docker network inspect app-network
```

Cleanup:

```bash
docker compose down
docker network rm app-network
```