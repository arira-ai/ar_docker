# 02 – Docker Bridge Network

## 1. Basics: Bridge Network

A **bridge network** is the default Docker network type used for **single-host container communication**.

Docker creates a virtual bridge called:

* `docker0` (default bridge)

Containers connected to the same bridge:

* Can communicate using IP
* Are isolated from other networks
* Use NAT to access external networks


## 2. Default Bridge vs User-Defined Bridge

| Feature               | Default Bridge | User-Defined Bridge |
| --------------------- | -------------- | ------------------- |
| DNS resolution        | No           | Yes               |
| Container name lookup | No           | Yes               |
| Isolation             | Basic          | Better              |
| Recommended           | No            | Yes                |

> This module focuses on **default bridge behavior** to understand fundamentals.



## 3. How Bridge Network Works Internally

* Docker creates a Linux bridge
* Each container gets:

  * Its own network namespace
  * A veth pair
* Traffic flows:

  * Container → veth → bridge → destination



## 4. Kubernetes Perspective

| Docker Bridge | Kubernetes Equivalent |
| ------------- | --------------------- |
| docker0       | CNI bridge            |
| Container IP  | Pod IP                |
| NAT           | kube-proxy            |
| Port mapping  | Service               |

Understanding bridge networking makes **Pod-to-Pod communication intuitive**.

## 5. Hands-on Practice: Default Bridge Network

### Step 1: Verify Bridge Network

```bash
docker network ls
```

Ensure `bridge` exists.

---

### Step 2: Inspect Bridge Network

```bash
docker network inspect bridge
```

Observe:

* Subnet
* Gateway
* Connected containers

---

### Step 3: Run Two Containers on Default Bridge

```bash
docker run -d --name web1 nginx
docker run -d --name web2 nginx
```

Check IPs:

```bash
docker inspect web1 | grep IPAddress
docker inspect web2 | grep IPAddress
```

---

### Step 4: Test Container-to-Container Communication (IP)

```bash
docker exec -it web1 ping <web2-ip>
```

This works because both are on the same bridge.

---

### Step 5: Test Name Resolution (Expected Failure)

```bash
docker exec -it web1 ping web2
```

Result:

* ❌ Name resolution fails
* Default bridge does NOT support DNS

---

## 6. Docker Compose Demo (Bridge Network)

This demo shows **two services running on the same bridge network**.

---

## 7. How This Helps in Kubernetes

You now understand:

* How containers talk inside a host
* Why DNS matters for microservices
* Why Kubernetes uses **user-defined networking**

This prepares you for:

* Pod networking
* Services
* CoreDNS



## 8. Conclusion and Summary

At the end of this module, you learned:

* What bridge networks are
* How docker0 works
* Limitations of default bridge
* Container communication using IP
* Why Kubernetes networking is different



## 9. Practice Questions

### Conceptual

1. What is docker0?
2. Why does default bridge not support DNS?
3. How does NAT work in bridge networking?

### Command-Based

4. Command to inspect bridge network
5. Command to check container IP

### Kubernetes-Oriented

6. Why does Kubernetes avoid default bridge?
7. What replaces docker0 in Kubernetes?



### Hands-on Tasks

8. Run three containers and verify IP communication
9. Try DNS resolution on default bridge
10. Inspect bridge before and after container creation

<br>
<br>

# Files are readily present in this folder
## FILE: 02-bridge-network/docker-compose.yml

```yaml
version: "3.8"

services:
  app1:
    image: nginx
    container_name: app1
    ports:
      - "8081:80"
    volumes:
      - ./demo/app1:/usr/share/nginx/html

  app2:
    image: nginx
    container_name: app2
    ports:
      - "8082:80"
    volumes:
      - ./demo/app2:/usr/share/nginx/html
```

---

## FILE: 02-bridge-network/demo/app1/index.html

```html
<!DOCTYPE html>
<html>
<head>
  <title>App 1</title>
</head>
<body>
  <h1>Application 1</h1>
  <p>Running on Docker default bridge network</p>
</body>
</html>
```

---

## FILE: 02-bridge-network/demo/app2/index.html

```html
<!DOCTYPE html>
<html>
<head>
  <title>App 2</title>
</head>
<body>
  <h1>Application 2</h1>
  <p>Running on Docker default bridge network</p>
</body>
</html>
```

---

## How to Run This Demo

```bash
cd 02-bridge-network
docker compose up -d
```

Access:

* [http://localhost:8081](http://localhost:8081) → App 1
* [http://localhost:8082](http://localhost:8082) → App 2

Stop:

```bash
docker compose down
```