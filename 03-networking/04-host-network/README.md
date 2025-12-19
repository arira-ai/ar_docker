# 04 – Docker Host Network

## 1. Basics: What is Host Network?

The **host network** mode removes network isolation between the container and the Docker host.

When a container uses host networking:

* It shares the host’s network namespace
* It uses the host’s IP address
* It binds directly to host ports
* No virtual bridge or NAT is used



## 2. Key Characteristics of Host Network

* No container IP (uses host IP)
* No port mapping (`-p` is ignored)
* Highest network performance
* Least network isolation

This mode is mainly used for:

* Performance-critical applications
* Network diagnostics
* Monitoring agents


## 3. How Host Network Works Internally

Normal bridge mode:

```
Container → veth → bridge → NAT → Host NIC
```

Host network mode:

```
Container → Host NIC (direct)
```

Because there is no virtual networking layer, packets flow directly through the host stack.


## 4. Docker vs Kubernetes Networking Mapping

| Docker         | Kubernetes        |
| -------------- | ----------------- |
| --network host | hostNetwork: true |
| Container port | Node port         |
| Host IP        | Node IP           |
| No NAT         | Direct routing    |

Kubernetes supports host networking but discourages it unless required.


## 5. Hands-on Practice: Host Network Mode

### Step 1: Check Host IP and Open Ports

```bash
ip addr show
ss -tuln
```

Note available ports (for example: 80, 8080).

---

### Step 2: Run Container Using Host Network

```bash
docker run -d --name host-nginx --network host nginx
```

Important:

* `-p` option will not work
* Nginx listens directly on host port `80`

---

### Step 3: Access Application

Open browser:

```
http://localhost
```

You should see the **Nginx Welcome Page**.

---

### Step 4: Verify No Container IP

```bash
docker inspect host-nginx | grep IPAddress
```

Result:

* Empty or null
* Confirms container uses host network

---

### Step 5: Stop and Remove Container

```bash
docker stop host-nginx
docker rm host-nginx
```


## 6. Security Implications

Using host network:

* Removes network isolation
* Exposes host ports directly
* Increases attack surface

Avoid host networking for:

* Multi-tenant environments
* Internet-facing workloads
* Microservices



## 7. How This Helps in Learning Kubernetes

Understanding host networking helps you:

* Debug node-level issues
* Understand DaemonSets
* Learn why Kubernetes defaults to Pod networking
* Avoid dangerous configurations

In Kubernetes, `hostNetwork: true` is mainly used for:

* CNI plugins
* kube-proxy
* Monitoring agents


## 8. Conclusion and Summary

At the end of this module, you learned:

* What host network mode is
* How it bypasses Docker networking
* When to use and avoid it
* How it maps to Kubernetes host networking

This is a **special-purpose networking mode**, not a default choice.


## 9. Practice Questions

### Conceptual Questions

1. What is host network mode?
2. Why does host networking improve performance?
3. Why is host networking risky?

---

### Command-Based Questions

4. Command to run a container in host network mode
5. Why does `-p` not work with host networking?

---

### Kubernetes-Oriented Questions

6. What does `hostNetwork: true` do?
7. Which Kubernetes components use host networking?

---

### Hands-on Tasks

8. Run a container using host networking
9. Try running two containers on the same port
10. Observe port conflicts and explain why they happen

---

<br>
<br>

# Files are readily present in this folder

## FILE: `04-host-network/run-host-network.sh`

```bash
#!/bin/bash

echo "Running Nginx container using host network..."

docker run -d --name host-net-demo --network host nginx

sleep 3

echo "Access Nginx at: http://localhost"
echo "Stopping container in 10 seconds..."

sleep 10

docker stop host-net-demo
docker rm host-net-demo

echo "Host network demo completed"
```

Make executable:

```bash
chmod +x run-host-network.sh
```

---

## How to Run This Demo

```bash
cd 04-host-network
./run-host-network.sh
```

---