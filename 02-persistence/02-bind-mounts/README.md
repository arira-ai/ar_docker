# Exercise 02 — Bind Mounts

## Concept
Bind mounts map a file or directory from the host into a container. Unlike volumes, bind mounts can reference arbitrary host paths and are not managed by Docker. They are useful for local development where you want to edit code on the host and see changes inside the container.

**Why do we do this?**  
Fast iteration during development; edit files locally and have the container use them immediately.

## The Challenge
1. Create a host directory `./devsite` and a file `index.html` with simple content.
2. Start an nginx container and mount `./devsite` into `/usr/share/nginx/html`.
3. Observe the site content by inspecting the file inside the container.
4. Edit the file on host and verify changes appear without restarting container.

## Solution — exact commands

```bash
# from repository root (creates host folder)
mkdir -p ./02-persistence/02-bind-mounts/devsite
echo "Initial by John - bind mount demo" > ./02-persistence/02-bind-mounts/devsite/index.html

# Run nginx and bind mount the host folder
docker run -d --name nginx_bind_test -p 8080:80 -v "$(pwd)/02-persistence/02-bind-mounts/devsite":/usr/share/nginx/html:ro nginx:alpine

# Inspect file inside container
docker exec nginx_bind_test cat /usr/share/nginx/html/index.html

# On host, change the file
echo "Updated content by John" > ./02-persistence/02-bind-mounts/devsite/index.html

# Inspect again inside container to confirm live update
docker exec nginx_bind_test cat /usr/share/nginx/html/index.html

# Cleanup
docker stop nginx_bind_test
docker rm nginx_bind_test
```

Notes:
- `:ro` mount is used in example to show read-only binding — remove `:ro` if you need container to write.

## Expected Output

```
# docker run ... (gives container id)
<container-id>

# docker exec ... cat index.html
Initial by John - bind mount demo

# After modifying on host:
# docker exec ... cat index.html
Updated content by John

# docker stop nginx_bind_test
nginx_bind_test

# docker rm nginx_bind_test
nginx_bind_test
```

## K8s Connection
Bind mounts on a single node are analogous to `hostPath` volumes in Kubernetes (node-specific). For cluster-level persistent storage, prefer network-backed PVs. Use `hostPath` carefully (node affinity) and for development/debugging only.
