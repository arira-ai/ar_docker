# Exercise 02 — depends_on and healthcheck

## Concept
`depends_on` in Compose controls start order and (with newer compose versions and condition) can wait for service health. Healthchecks are commands run inside containers to report service readiness.

## The Challenge
1. From this folder, run `docker compose up --build`.
2. Observe that `web` waits for `db` to be healthy before attempting connections.
3. Confirm health status using `docker compose ps`.

## Solution — exact commands

```bash
cd 04-compose/02-depends-on-and-healthcheck
docker compose up --build -d

# Watch health checks
docker compose ps

# View service health info via docker inspect if desired:
docker inspect --format='{{json .State.Health}}' $(docker compose ps -q db)
```

## Expected Output

```
# docker compose up --build -d
Creating network "02-depends-on_and_healthcheck_default" with the default driver
Creating 02-depends-on-and-healthcheck_db_1 ... done
Creating 02-depends-on-and-healthcheck_web_1 ... done

# docker compose ps
      Name                           Command               State                    Ports
----------------------------------------------------------------------------------------------------
02-depends-on-and-healthcheck_db_1   docker-entrypoint.sh postgres   Up (healthy)   5432/tcp
02-depends-on-and-healthcheck_web_1  python app.py                   Up (healthy)   0.0.0.0:5001->5000/tcp
```

## K8s Connection
Compose `healthcheck` ≈ K8s `readinessProbe`/`livenessProbe`. `depends_on` (service_healthy) approximates K8s readiness semantics; in Kubernetes, Pods still get scheduled but Services only route to Pods that pass readiness probes.
