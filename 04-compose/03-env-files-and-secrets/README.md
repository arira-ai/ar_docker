# Exercise 03 — env_file & local secrets (development)

## Concept
Environment variables and secret management are essential. Compose supports `.env` files and `env_file:` for environment values. For secrets, Compose in non-Swarm mode often uses bind-mounted files (careful with host security). In production (or Swarm/Kubernetes) use native secret stores.

## The Challenge
1. Start the web service that consumes variables from `.env`.
2. Demonstrate that the app reads `FLAVOR` from env and prints it on an endpoint.
3. Show where secret file is mounted and how to read it inside the container.

## Solution — exact commands

```bash
cd 04-compose/03-env-files-and-secrets

# build and start
docker compose up --build -d

# Check container env
docker compose exec web env | grep FLAVOR

# If the secret file was mounted, view it inside
docker compose exec web cat /run/secrets/db_password

# Request the app (assuming it prints FLAVOR)
curl http://localhost:5002/
```

## Expected Output

```
# docker compose exec web env | grep FLAVOR
FLAVOR=dev

# docker compose exec web cat /run/secrets/db_password
pass123

# curl http://localhost:5002/
Hello from John! FLAVOR=dev
```

## Important note
Compose `secrets` feature has limitations outside Swarm. For production secrets use a secrets manager (Vault, AWS Secrets Manager) or Kubernetes Secrets.

## K8s Connection
Kubernetes Secrets/ConfigMaps map environment variables or mount files into Pods. K8s Secrets are base64-encoded objects stored in the API (use appropriate encryption and access controls).
