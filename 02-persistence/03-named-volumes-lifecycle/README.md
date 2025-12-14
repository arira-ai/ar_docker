# Exercise 03 — Named Volumes & Lifecycle

## Concept
Named volumes are managed by Docker and are easier to use than bind mounts for production or for sharing data between multiple containers. Understanding lifecycle (create, list, inspect, prune) is important for maintenance.

## The Challenge
1. Create a named volume `john_dbdata`.
2. Run a PostgreSQL container using that volume for `/var/lib/postgresql/data`.
3. Demonstrate `docker volume inspect` and how to remove the volume safely after removing the container.
4. Show how `docker volume prune` works.

## Solution — exact commands

```bash
# Create/inspect volume
docker volume create john_dbdata
docker volume ls
docker volume inspect john_dbdata

# Start postgres using named volume (official image uses POSTGRES_PASSWORD)
docker run -d --name pg_test -e POSTGRES_PASSWORD=pass123 -v john_dbdata:/var/lib/postgresql/data postgres:15-alpine

# Wait for DB to init, then show container logs (short)
docker logs --tail 20 pg_test

# Stop and remove container
docker stop pg_test
docker rm pg_test

# Remove volume (only after container removed)
docker volume rm john_dbdata

# Alternatively, prune dangling volumes (careful!)
docker volume prune --force
```

## Expected Output

```
# docker volume create john_dbdata
john_dbdata

# docker volume ls
DRIVER    VOLUME NAME
local     john_dbdata

# docker volume inspect john_dbdata
[
    {
        "CreatedAt": "2025-12-04T...Z",
        "Name": "john_dbdata",
        "Driver": "local",
        "Mountpoint": "/var/lib/docker/volumes/john_dbdata/_data",
        ...
    }
]

# docker run -d ... postgres
<container-id>

# docker logs --tail 20 pg_test
PostgreSQL Database directory appears to contain a database; Skipping initialization
...
LOG:  database system is ready to accept connections

# docker stop pg_test
pg_test

# docker rm pg_test
pg_test

# docker volume rm john_dbdata
john_dbdata

# docker volume prune --force
Total reclaimed space: 0B
```

## K8s Connection
Named Docker volumes correspond to PVs supplied by a StorageClass in Kubernetes. Lifecycle operations move from manual CLI operations to declarative PVC objects in Kubernetes. Pruning volumes is similar to reclaim policies (`Delete` vs `Retain`) on PersistentVolumes.
