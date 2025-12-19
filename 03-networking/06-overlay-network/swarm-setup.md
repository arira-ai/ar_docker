# Docker Swarm Setup for Overlay Networking

## Initialize Swarm (Manager Node)

```bash
docker swarm init
```



## Join Worker Node (Optional)

Run on manager:

```bash
docker swarm join-token worker
```

Run on worker:

```bash
docker swarm join <token>
```



## Verify Cluster

```bash
docker node ls
```



## Leave Swarm (Cleanup)

```bash
docker swarm leave --force
```