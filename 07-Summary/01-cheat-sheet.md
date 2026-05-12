# Docker Advanced – Cheat Sheet

## 1. Docker Basics

* Containerization platform for building, shipping, and running applications

```bash
docker --version                  # Show Docker version
docker info                       # Show Docker system info
docker help                       # Show Docker help
docker login                      # Login to Docker Hub
docker logout                     # Logout from Docker Hub
docker search <image>             # Search image on Docker Hub
docker pull <image>               # Download image
docker push <image>               # Upload image to registry
```

---

## 2. Image Management

```bash
docker images                     # List local images
docker image ls                   # List images
docker image inspect <image>      # Inspect image details
docker history <image>            # Show image history
docker build -t myapp .           # Build image from Dockerfile
docker tag image newimage:tag     # Tag image
docker rmi <image>                # Remove image
docker image prune                # Remove unused images
docker save -o backup.tar image   # Save image as tar
docker load -i backup.tar         # Load image from tar
```

---

## 3. Container Management

```bash
docker ps                         # List running containers
docker ps -a                      # List all containers
docker run nginx                  # Run container
docker run -it ubuntu bash        # Interactive container
docker run -d nginx               # Run container in background
docker run --name web nginx       # Run with custom name
docker start <container>          # Start container
docker stop <container>           # Stop container
docker restart <container>        # Restart container
docker pause <container>          # Pause container
docker unpause <container>        # Unpause container
docker rm <container>             # Remove container
docker kill <container>           # Force stop container
docker rename old new             # Rename container
```

---

## 4. Container Interaction

```bash
docker exec -it <container> bash  # Access running container
docker logs <container>           # View logs
docker logs -f <container>        # Follow logs live
docker top <container>            # Show running processes
docker stats                      # Resource usage statistics
docker inspect <container>        # Inspect container details
docker cp file.txt cont:/tmp/     # Copy file into container
docker cp cont:/tmp/file.txt .    # Copy file from container
docker attach <container>         # Attach terminal
```

---

## 5. Networking

```bash
docker network ls                 # List networks
docker network inspect bridge     # Inspect network
docker network create mynet       # Create network
docker network rm mynet           # Remove network
docker run --network=mynet nginx  # Connect container to network
docker network connect mynet c1   # Connect container manually
docker network disconnect mynet c1  # Disconnect container
```

### Port Mapping

```bash
docker run -p 8080:80 nginx       # Map host port to container
docker run -P nginx               # Random port mapping
```

---

## 6. Volume Management

```bash
docker volume ls                  # List volumes
docker volume create myvol        # Create volume
docker volume inspect myvol       # Inspect volume
docker volume rm myvol            # Remove volume
docker volume prune               # Remove unused volumes
docker run -v myvol:/data nginx   # Mount named volume
docker run -v /host:/container nginx  # Bind mount
```

---

## 7. Dockerfile Commands

```Dockerfile
FROM ubuntu:22.04                 # Base image
LABEL maintainer="admin"         # Metadata
RUN apt update                    # Execute command during build
COPY . /app                       # Copy files
ADD file.tar.gz /tmp              # Add files with extraction
WORKDIR /app                      # Set working directory
ENV APP_ENV=prod                  # Environment variable
EXPOSE 8080                       # Expose port
CMD ["nginx", "-g", "daemon off;"]  # Default command
ENTRYPOINT ["python3"]           # Main executable
USER appuser                      # Run as user
VOLUME ["/data"]                 # Define volume
```

---

## 8. Docker Compose

### Common Compose Commands

```bash
docker compose up                 # Start services
docker compose up -d              # Start in detached mode
docker compose down               # Stop and remove services
docker compose ps                 # Show containers
docker compose logs               # View logs
docker compose logs -f            # Follow logs
docker compose restart            # Restart services
docker compose build              # Build services
docker compose pull               # Pull latest images
docker compose exec web bash      # Access service container
```

### Sample docker-compose.yml

```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "8080:80"
  db:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: root
```

---

## 9. Registry Management

```bash
docker login                      # Login to registry
docker tag app user/app:v1        # Tag image
docker push user/app:v1           # Push image
docker pull user/app:v1           # Pull image
```

---

## 10. Cleanup Commands

```bash
docker system df                  # Docker disk usage
docker system prune               # Remove unused data
docker system prune -a            # Remove all unused images
docker container prune            # Remove stopped containers
docker image prune                # Remove dangling images
docker volume prune               # Remove unused volumes
docker network prune              # Remove unused networks
```

---

## 11. Resource Limits

```bash
docker run --memory="512m" nginx     # Limit memory
docker run --cpus="1.5" nginx        # Limit CPU
docker run --restart=always nginx     # Restart policy
docker run --read-only nginx          # Read-only filesystem
```

---

## 12. Security Commands

```bash
docker scan <image>               # Scan image vulnerabilities
docker trust inspect <image>      # Verify image signing
docker run --user 1001 nginx      # Run container as non-root
docker run --cap-drop ALL nginx   # Drop Linux capabilities
```

---

## 13. Daily Must-Have Commands

```bash
docker ps                         # Running containers
docker images                     # Local images
docker logs -f <container>        # Live logs
docker exec -it <container> bash  # Access container
docker stop <container>           # Stop container
docker rm <container>             # Remove container
docker system prune               # Cleanup unused resources
```

---

## 14. Docker Architecture

```text
Client → Docker CLI
Docker CLI → Docker Daemon (dockerd)
Docker Daemon → Images
Docker Daemon → Containers
Docker Daemon → Networks
Docker Daemon → Volumes
Docker Daemon → Registry (Docker Hub / Private Registry)
```

---

### Tip

Mastering Docker helps build portable, scalable, and isolated application environments.
