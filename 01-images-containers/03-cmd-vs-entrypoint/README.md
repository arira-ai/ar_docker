# 03 – CMD vs ENTRYPOINT in Docker

## 1. Basics: CMD and ENTRYPOINT

### CMD

`CMD` defines the **default command** that runs when a container starts.

Key characteristics:

* Can be overridden at runtime
* Used to provide default arguments
* Only one `CMD` is effective (last one wins)

Syntax forms:

```Dockerfile
CMD ["executable", "param1", "param2"]
CMD command param1 param2
```

---

### ENTRYPOINT

`ENTRYPOINT` defines the **main executable** for the container.

Key characteristics:

* Cannot be overridden easily
* Makes the container behave like an executable
* Always runs when the container starts

Syntax forms:

```Dockerfile
ENTRYPOINT ["executable", "param1"]
ENTRYPOINT command param1
```

---

### CMD vs ENTRYPOINT – Core Difference

| Feature     | CMD              | ENTRYPOINT         |
| ----------- | ---------------- | ------------------ |
| Purpose     | Default command  | Fixed executable   |
| Overridable | Yes              | No (by default)    |
| Best use    | Default behavior | Mandatory behavior |
| Typical use | App arguments    | Application itself |

---

## 2. How CMD and ENTRYPOINT Work Together (Kubernetes Perspective)

### Combined Usage

When both are used:

* `ENTRYPOINT` = executable
* `CMD` = default arguments

Example:

```Dockerfile
ENTRYPOINT ["echo"]
CMD ["Hello World"]
```

Runtime behavior:

```bash
docker run image-name
```

Output:

```text
Hello World
```

Override CMD:

```bash
docker run image-name "Hello Kubernetes"
```

Output:

```text
Hello Kubernetes
```

---

### Kubernetes Mapping

| Docker              | Kubernetes        |
| ------------------- | ----------------- |
| CMD                 | args              |
| ENTRYPOINT          | command           |
| docker run override | Pod spec override |

Kubernetes directly maps `ENTRYPOINT` and `CMD` to `command` and `args`.

---

## 3. Hands-on Practice: CMD vs ENTRYPOINT

### Step 1: Create Working Directory

```bash
mkdir cmd-entrypoint-demo
cd cmd-entrypoint-demo
```

---

### Step 2: Dockerfile with CMD

Create `Dockerfile.cmd`:

```Dockerfile
FROM ubuntu:22.04
CMD ["echo", "Hello from CMD"]
```

Build image:

```bash
docker build -t cmd-demo -f Dockerfile.cmd .
```

Run container:

```bash
docker run cmd-demo
```

Output:

```text
Hello from CMD
```

Override CMD:

```bash
docker run cmd-demo echo "CMD overridden"
```

---

### Step 3: Dockerfile with ENTRYPOINT

Create `Dockerfile.entrypoint`:

```Dockerfile
FROM ubuntu:22.04
ENTRYPOINT ["echo", "Hello from ENTRYPOINT"]
```

Build image:

```bash
docker build -t entrypoint-demo -f Dockerfile.entrypoint .
```

Run container:

```bash
docker run entrypoint-demo
```

Output:

```text
Hello from ENTRYPOINT
```

Override attempt:

```bash
docker run entrypoint-demo echo "Trying override"
```

Observation:

* ENTRYPOINT still executes

---

### Step 4: Combined CMD and ENTRYPOINT

Create `Dockerfile.combined`:

```Dockerfile
FROM ubuntu:22.04
ENTRYPOINT ["echo"]
CMD ["Hello from CMD"]
```

Build image:

```bash
docker build -t combined-demo -f Dockerfile.combined .
```

Run container:

```bash
docker run combined-demo
```

Output:

```text
Hello from CMD
```

Override CMD only:

```bash
docker run combined-demo "Hello Kubernetes"
```

Output:

```text
Hello Kubernetes
```

---

## 4. CMD vs ENTRYPOINT – Best Practices

* Use `ENTRYPOINT` for the main application
* Use `CMD` for default arguments
* Always use **exec form** (`["executable"]`)
* Avoid shell form for production images

---

## 5. How This Helps in Learning Kubernetes

Understanding CMD and ENTRYPOINT helps you:

* Override container behavior in Pods
* Debug containers easily
* Control startup commands
* Avoid common Pod startup failures

This is critical for:

* Pod specs
* Init containers
* Job and CronJob workloads

---

## 6. Conclusion and Summary

At the end of this module, you learned:

* Difference between CMD and ENTRYPOINT
* How override behavior works
* How both work together
* How Docker startup behavior maps to Kubernetes

This knowledge is essential for writing **production-grade container images**.

---

## 7. Practice Questions

### Conceptual Questions

1. What is the purpose of CMD?
2. What is the purpose of ENTRYPOINT?
3. Why is ENTRYPOINT preferred for main applications?
4. Why should exec form be used?

---

### Command-Based Questions

5. How do you override CMD at runtime?
6. How do you override ENTRYPOINT?
7. Command to build an image using a specific Dockerfile?

---

### Kubernetes-Oriented Questions

8. How does Kubernetes override CMD?
9. What happens if both command and args are defined in a Pod?
10. Why do containers fail if CMD/ENTRYPOINT is misconfigured?

---

### Hands-on Tasks

11. Create an image that prints system date using ENTRYPOINT
12. Override output format using CMD
13. Map CMD and ENTRYPOINT to a Kubernetes Pod YAML
