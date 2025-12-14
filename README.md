# docker-to-k8s-mastery

A hands-on tutorial taking learners from Docker basics to Kubernetes readiness. Modules are numbered and progressive. Use the supplied exercises to run locally, experiment, and then map each concept to Kubernetes (Module 06).

Preface:
- Always start each exercise from the exercise folder.
- Use `docker system prune` cautiously between exercises to keep environment clean.
- Encourage students to try converting Compose files to K8s YAML (Module 06 will provide patterns).

Author: Arira Ai

```
docker-to-k8s-mastery/
├── 01-images-containers/
│   ├── 01-dockerfile-basics/
│   ├── 02-layers-and-caching/
│   ├── 03-cmd-vs-entrypoint/
│   └── 04-lifecycle-start-stop/
├── 02-persistence/
│   ├── 01-basic-volumes/
│   ├── 02-bind-mounts/
│   ├── 03-named-volumes-lifecycle/
│   └── 04-backup-restore-volume/
├── 03-networking/
│   ├── 01-bridge-network/
│   ├── 02-container-to-container/
│   ├── 03-user-defined-networks/
│   └── 04-dns-and-service-discovery/
├── 04-compose/
│   ├── 01-multi-service-app/
│   ├── 02-depends-on-and-healthcheck/
│   ├── 03-env-files-and-secrets/
│   └── 04-scale-and-recreate/
├── 05-swarm/
│   ├── 01-init-swarm/
│   ├── 02-services-and-replicas/
│   ├── 03-updates-and-rollbacks/
│   └── 04-overlay-networks/
├── 06-pre-k8s-architecture/
│   ├── 01-imperative-vs-declarative/
│   ├── 02-application-structure-for-k8s/
│   └── 03-mapping-docker-concepts-to-k8s/
└── README.md

```