# 01 – Docker Images and Containers

## 1. Basics: Docker Images and Containers

### Docker Image

A Docker image is a **read-only template** used to create containers.
It includes everything required to run an application:

* Application source code
* Runtime environment (for example: Java, Python, Node.js)
* Required libraries and dependencies
* Environment variables and default configuration

A Docker image **cannot run by itself**. It must be used to create a **container**.

### Docker Container

A Docker container is a **running instance of a Docker image**.

Key characteristics of containers:

* Lightweight and fast
* Isolated from the host system
* Can be started, stopped, and deleted quickly
* Multiple containers can be created from a single image

### Image vs Container – Simple Analogy

| Concept          | Analogy                           |
| ---------------- | --------------------------------- |
| Docker Image     | Class / Blueprint                 |
| Docker Container | Object / Instance                 |
| Image            | Application installer             |
| Container        | Installed and running application |



## 2. How Images and Containers Work (Kubernetes Perspective)

### Docker Workflow

1. Create or pull a Docker image
2. Store the image locally or in an image registry
3. Create a container from the image
4. Run the application inside the container


### Docker and Kubernetes Mapping

| Docker Concept      | Kubernetes Equivalent    |
| ------------------- | ------------------------ |
| Docker Image        | Container Image          |
| Container           | Container (inside a Pod) |
| docker run          | kubectl run              |
| Docker Hub          | Image Registry           |
| Multiple containers | Replicas                 |

Kubernetes **never builds or runs Dockerfiles directly**.
It only runs **containers created from pre-built images**.

Understanding images vs containers is mandatory before learning:

* **Pods:** The smallest unit in Kubernetes that runs one or more containers together.
* **Deployments:** Manage and update Pods automatically using a defined configuration.
* **ReplicaSets:** Ensure a specified number of identical Pods are always running.
* **Scaling:** Increasing or decreasing the number of Pods to match workload demand.

## 3. Hands-on Practice: Images and Containers

### Step 1: Verify Docker Installation

Command:

```bash
docker --version
```

Expected output:

```text
Docker version XX.XX.X
```


### Step 2: Pull an Image from Docker Hub

Command:

```bash
docker pull nginx
```

Explanation:

* Downloads the official `nginx` image
* Stores it locally

Verify downloaded images:

```bash
docker images
```

### Step 3: Run a Container from the Image

Command:

```bash
docker run -d -p 8080:80 nginx
```

Explanation:

* `-d` → Runs the container in detached mode
* `-p 8080:80` → Maps host port 8080 to container port 80
* `nginx` → Image name

Verify running container:

```bash
docker ps
```

### Step 4: Access the Running Container

Open a browser and navigate to:

```
http://localhost:8080
```

You should see the **Nginx Welcome Page**, confirming the container is running.

### Step 5: Inspect the Container

Command:

```bash
docker inspect <container_id>
```

This command shows:

* Image used
* Network configuration
* Mounts
* Runtime settings

### Step 6: Stop and Remove the Container

Commands:

```bash
docker stop <container_id>
docker rm <container_id>
```

List all containers (running and stopped):

```bash
docker ps -a
```

### Step 7: Remove the Image

Command:

```bash
docker rmi nginx
```

This removes the image from the local system.



## 4. Key Differences Between Images and Containers

| Feature   | Image      | Container           |
| --------- | ---------- | ------------------- |
| Nature    | Static     | Dynamic             |
| Writable  | No         | Yes                 |
| Execution | Cannot run | Running             |
| Purpose   | Template   | Application runtime |
| Lifecycle | Built once | Created many times  |


## 5. How This Helps in Learning Kubernetes

After understanding images and containers:

* Kubernetes schedules **containers**, not Dockerfiles
* Pods act as wrappers around containers
* Deployments create multiple containers from the same image
* Scaling means running more containers from one image

This concept directly applies to Kubernetes workload management.


## 6. Conclusion and Summary

At the end of this module, you learned:

* What Docker images are and why they are immutable
* What Docker containers are and how they run applications
* How to pull images and run containers
* The difference between images and containers
* How Docker concepts map to Kubernetes concepts

This is the **foundation for container orchestration and Kubernetes learning**.

## 7. Practice Questions

### Conceptual Questions

1. What is a Docker image?
2. What is a Docker container?
3. Why are Docker images read-only?
4. Can multiple containers be created from a single image? Why?
5. What happens to container data when the container is deleted?

### Command-Based Questions

6. Command to list all Docker images
7. Command to list running containers
8. Command to run a container in detached mode
9. Command to stop a running container
10. Command to remove an image

### Kubernetes-Oriented Questions

11. What Kubernetes object replaces `docker run`?
12. Why does Kubernetes require images to exist before deployment?
13. How does Kubernetes use the same image for scaling?

### Hands-on Tasks

14. Run two containers from the same image using different ports
15. Stop one container and verify the other continues running
16. Compare container IDs and explain why they are different
