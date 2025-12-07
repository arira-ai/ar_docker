# Exercise 01 — Multi-service Compose App (web + db)

## Concept
Docker Compose enables defining and running multiple containers (services) with shared networks and volumes via a single YAML file. This simplifies multi-container app bootstrapping for development.

## The Challenge
1. From `04-compose/01-multi-service-app/`, run `docker compose up --build`.
2. Wait for both services to be healthy (db initialize may take a few seconds).
3. Open `http://localhost:5000/` and ensure the web app returns a message that includes the PostgreSQL version.
4. Tear down the stack and ensure the DB volume persists between runs.

## Solution — exact commands

```bash
# Move into the exercise directory
cd 04-compose/01-multi-service-app

# 1) Build and start the stack
docker compose up --build

# (In another terminal) 2) You can watch logs:
docker compose logs -f

# 3) Test the web endpoint (can use curl)
curl http://localhost:5000/

# 4) Tear down but keep volumes
docker compose down

# 5) To remove volumes too:
docker compose down -v
```

## Expected Output

```
# docker compose up --build
[+] Building 8.0s (9/9) FINISHED
 => [web internal] load build definition...done
 => [web internal] load .dockerignore...done
 => [web internal] load build context...done
 => [web 1/4] FROM python:3.11-alpine...done
 => [web 2/4] WORKDIR /app ...done
 => [web 3/4] COPY requirements.txt ...done
 => [web 4/4] RUN pip install --no-cache-dir -r requirements.txt ...done
 => exporting to image...done
Starting 01-multi-service-app_db_1 ... done
Starting 01-multi-service-app_web_1 ... done
# logs show postgres init and then web connecting...
web_1  |  * Serving Flask app "app" (lazy loading)
web_1  |  * Running on all addresses, port 5000
# curl http://localhost:5000/
Hello from John! DB: PostgreSQL 15.3 (Debian 15.3-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by ...
```

> Note: exact PostgreSQL version text may vary by image tag.

## K8s Connection
A `docker-compose.yml` declares multiple services with networking and volumes. In Kubernetes you do the same via Deployments/StatefulSets, Services, ConfigMaps, Secrets, and PersistentVolumeClaims. `depends_on` and build behavior are local-compose conveniences; in K8s you express dependencies via readiness/liveness probes and Service endpoints.
