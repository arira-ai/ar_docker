# Exercise 04 — Scaling services with Compose

## Concept
Compose can scale stateless services for local testing using `docker compose up --scale` or `docker compose up` for multiple replicas in Compose v2. For real production scaling use an orchestrator (Swarm or Kubernetes).

## The Challenge
1. Use the `01-multi-service-app` stack but scale the `web` service to 3 instances.
2. Show that multiple containers are running and accessible (on distinct internal ports or with simple round-robin tested in logs).
3. Recreate a single service instance without bringing entire stack down.

## Solution — exact commands

```bash
# from 01-multi-service-app directory
cd 04-compose/01-multi-service-app

# Scale web to 3 replicas (note: when mapping host port to multiple replicas you must use a load balancer; for this demo we will not publish host port)
docker compose up --build -d --scale web=3

# List containers
docker compose ps

# If you mapped host ports for each instance you can curl them; otherwise inspect logs for multiple web container names:
docker compose logs --tail=10 --no-log-prefix web

# Recreate only the web service (zero-downtime depends on app)
docker compose up -d --no-deps --build web
```

## Expected Output

```
# docker compose up --scale web=3 -d
Creating network "..." with the default driver
Creating ..._db_1 ... done
Creating ..._web_1 ... done
Creating ..._web_2 ... done
Creating ..._web_3 ... done

# docker compose ps
    Name                      Command               State   Ports
--------------------------------------------------------------
..._db_1             docker-entrypoint.sh postgres   Up      5432/tcp
..._web_1            python app.py                   Up
..._web_2            python app.py                   Up
..._web_3            python app.py                   Up
```

## K8s Connection
Scaling in Compose is a developer convenience. Kubernetes handles scaling via `replicas` in a Deployment or via a Horizontal Pod Autoscaler (HPA) that scales based on metrics. Load-balancing is provided by Services in Kubernetes.
