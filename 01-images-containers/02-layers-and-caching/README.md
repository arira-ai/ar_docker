# 02 – Docker Image Layers and Caching

## 1. Basics: Docker Image Layers and Caching

### Docker Image Layers

A Docker image is built using **multiple layers**.
Each instruction in a `Dockerfile` (such as `FROM`, `RUN`, `COPY`, `ADD`) creates **one immutable layer**.

Characteristics of layers:

* Read-only and immutable
* Reusable across images
* Stacked to form a final image
* Shared between multiple images and containers

Docker uses a **Union File System (UnionFS)** to combine these layers into a single view.

### Docker Layer Caching

Docker uses **layer caching** to speed up image builds.

Key points:

* Docker reuses unchanged layers from previous builds
* If a layer changes, all layers **after it** are rebuilt
* Cache improves build speed and reduces resource usage

## 2. How Layers and Caching Work (Kubernetes Perspective)

### Image Build Workflow

1. Docker reads the Dockerfile from top to bottom
2. Each instruction creates a new layer
3. Layers are cached locally
4. Final image is pushed to a registry

### Why Layers Matter in Kubernetes

| Docker Concept | Kubernetes Impact          |
| -------------- | -------------------------- |
| Image layers   | Faster image pulls         |
| Shared layers  | Reduced network usage      |
| Cached layers  | Faster Pod startup         |
| Smaller images | Better cluster performance |

Kubernetes nodes pull only **missing layers**, not the entire image.

## 3. Hands-on Practice: Understanding Layers and Cache

### Step 1: Create a Working Directory

```bash
mkdir layers-demo
cd layers-demo
```


### Step 2: Create a Sample Dockerfile

Create a file named `Dockerfile`:

```Dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl

COPY app.txt /app.txt

RUN echo "Docker Layers Demo" >> /app.txt

CMD ["cat", "/app.txt"]
```

### Step 3: Create Application File

Create `app.txt`:

```text
Hello from Docker
```

### Step 4: Build the Image

```bash
docker build -t layers-demo:1.0 .
```

Observe the output:

* Each Dockerfile instruction creates a layer
* Cached layers will be reused on subsequent builds

### Step 5: Rebuild the Image (Cache Hit)

```bash
docker build -t layers-demo:1.0 .
```

You should see:

```text
Using cache
```

This indicates Docker reused existing layers.

### Step 6: Modify the Application File

Edit `app.txt`:

```text
Hello from Docker - Updated
```

Rebuild:

```bash
docker build -t layers-demo:1.0 .
```

Observation:

* `COPY` layer is rebuilt
* All layers **after** it are rebuilt
* Layers before remain cached

### Step 7: Run the Container

```bash
docker run --rm layers-demo:1.0
```

Expected output:

```text
Hello from Docker - Updated
Docker Layers Demo
```

## 4. Best Practices for Layer Caching

### Optimizing Dockerfile Order

* Place rarely changing instructions at the top
* Place frequently changing files at the bottom
* Combine related commands to reduce layers

Example:

```Dockerfile
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
```

### Why This Matters for Kubernetes

* Faster CI/CD pipelines
* Faster Pod restarts
* Reduced image pull time
* Lower network and storage usage

## 5. How This Helps in Learning Kubernetes

Understanding layers and caching helps you:

* Optimize container images for Kubernetes
* Reduce Pod startup latency
* Improve rolling deployment speed
* Save cluster bandwidth and storage

Efficient images lead to **stable and performant clusters**.

## 6. Conclusion and Summary

At the end of this module, you learned:

* What Docker image layers are
* How each Dockerfile instruction creates a layer
* How Docker caching works
* How changes affect cache invalidation
* Why optimized images are important for Kubernetes

This knowledge is critical for **production-ready containers**.

## 7. Practice Questions

### Conceptual Questions

1. What is a Docker image layer?
2. Why are Docker layers immutable?
3. What is Docker layer caching?
4. Why are layers rebuilt after a change?

### Command-Based Questions

5. Command to build a Docker image
6. How do you tag an image during build?
7. Command to run a container from an image

### Kubernetes-Oriented Questions

8. Why does Kubernetes pull only missing layers?
9. How do optimized layers improve Pod startup time?
10. What happens in Kubernetes when a new image version is deployed?

### Hands-on Tasks

11. Change only the `CMD` instruction and rebuild the image
12. Observe which layers are rebuilt
13. Reorder Dockerfile instructions to improve caching
