# 04 – Container Lifecycle: Start, Stop, and Restart

## 1. Basics: Container Lifecycle

A Docker container follows a **defined lifecycle** from creation to termination.
Understanding this lifecycle is critical for debugging, automation, and Kubernetes readiness.

### Container Lifecycle Stages
1. Created
2. Started
3. Running
4. Paused (optional)
5. Stopped
6. Removed

Containers are **ephemeral** by design. Once stopped and removed, they do not retain state unless external storage is used. This can discussed in the volumes concepts.

## 2. Container Lifecycle States Explained

### Created
- Container is created but not started
- Resources are allocated
- Entry command is not executed

### Running
- Container process is actively running
- Application is executing

### Paused
- Container execution is frozen
- Processes are suspended

### Stopped
- Main process has exited
- Container still exists on disk

### Removed
- Container metadata is deleted
- Container no longer exists


## 3. How Container Lifecycle Works (Kubernetes Perspective)

### Docker vs Kubernetes Lifecycle Mapping

| Docker Lifecycle | Kubernetes Equivalent |
|-----------------|----------------------|
| docker create | Pod creation |
| docker start | Container start |
| docker stop | Pod termination |
| docker restart | Pod restart |
| docker rm | Pod deletion |

Kubernetes constantly monitors container state and **restarts containers automatically** based on restart policy.


## 4. Hands-on Practice: Container Lifecycle Commands

### Step 1: Create a Container (Not Started)

```bash
docker create --name lifecycle-demo nginx
````

Verify container state:

```bash
docker ps -a
```

### Step 2: Start the Container

```bash
docker start lifecycle-demo
```

Verify:

```bash
docker ps
```

### Step 3: Stop the Container Gracefully

```bash
docker stop lifecycle-demo
```

Explanation:

* Sends SIGTERM
* Allows application to shut down gracefully

Verify:

```bash
docker ps -a
```

### Step 4: Restart the Container

```bash
docker restart lifecycle-demo
```

This command performs:

* Stop
* Start


### Step 5: Pause and Unpause the Container

```bash
docker pause lifecycle-demo
docker unpause lifecycle-demo
```

Pausing freezes all container processes without stopping them.


### Step 6: Remove the Container

```bash
docker rm lifecycle-demo
```

Force remove (if running):

```bash
docker rm -f lifecycle-demo
```

## 5. Signals and Graceful Shutdown

### What Happens During `docker stop`

1. Docker sends `SIGTERM`
2. Container gets time to shut down
3. Docker sends `SIGKILL` if timeout expires

Default timeout: **10 seconds**

Set custom timeout:

```bash
docker stop -t 30 lifecycle-demo
```

## 6. How This Helps in Learning Kubernetes

Understanding container lifecycle helps you:

* Debug crashing Pods
* Understand restart policies
* Implement graceful shutdowns
* Design resilient applications

Kubernetes uses container lifecycle events for:

* Health checks
* Auto-healing
* Rolling updates

## 7. Conclusion and Summary

At the end of this module, you learned:

* All container lifecycle states
* How to start, stop, pause, and restart containers
* Difference between stop and remove
* How Docker lifecycle maps to Kubernetes lifecycle

This knowledge is essential for **stable containerized applications**.

## 8. Practice Questions

### Conceptual Questions

1. What is the difference between stop and remove?
2. What happens when a container receives SIGTERM?
3. Why are containers considered ephemeral?
4. What is the paused state?

### Command-Based Questions

5. Command to create a container without starting it
6. Command to gracefully stop a container
7. Command to restart a container
8. Command to force remove a running container

### Kubernetes-Oriented Questions

9. How does Kubernetes handle container restarts?
10. What happens to a Pod when its container crashes?
11. Why is graceful shutdown important in Kubernetes?

### Hands-on Tasks

12. Create a container and keep it stopped
13. Restart the container multiple times and observe container ID
14. Force remove a running container and observe behavior