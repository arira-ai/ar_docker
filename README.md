# docker-to-k8s-mastery

A hands-on tutorial taking learners from Docker basics to Kubernetes readiness. Modules are numbered and progressive. Use the supplied exercises to run locally, experiment, and then map each concept to Kubernetes (Module 06).

Preface:
- Always start each exercise from the exercise folder.
- Use `docker system prune` cautiously between exercises to keep environment clean.
- Encourage students to try converting Compose files to K8s YAML (Module 06 will provide patterns).

Author: Arira Ai

```
docker-to-k8s-mastery/
├── .gitignore
├── LICENSE
├── README.md
├── 00-setup/
│   ├── README.md
│   └── verify_env.sh
├── 01-basics/
│   ├── README.md
│   ├── 01-hello-world/
│   │   ├── README.md
│   │   └── Dockerfile
│   ├── 02-custom-images/
│   │   ├── README.md
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   └── 03-multi-stage-builds/
│       ├── README.md
│       └── Dockerfile
├── 02-persistence/
│   ├── README.md
│   ├── 01-ephemeral-data/
│   │   ├── README.md
│   │   └── Dockerfile
│   ├── 02-named-volumes/
│   │   ├── README.md
│   │   └── postgres-test.sh
│   └── 03-bind-mounts/
│       ├── README.md
│       ├── nginx.conf
│       └── html/
│           └── index.html
├── 03-networking/
│   ├── README.md
│   ├── 01-bridge-networks/
│   │   ├── README.md
│   │   └── verify-bridge.sh
│   └── 02-container-dns/
│       ├── README.md
│       └── network-test.sh
├── 04-compose/
│   ├── README.md
│   ├── 01-the-stack/
│   │   ├── README.md
│   │   ├── docker-compose.yml
│   │   ├── .env
│   │   └── app/
│   │       ├── Dockerfile
│   │       ├── app.py
│   │       └── requirements.txt
│   └── 02-healthchecks-startup/
│       ├── README.md
│       ├── docker-compose.yml
│       └── app/
│           ├── wait-for-it.sh
│           └── Dockerfile
├── 05-swarm/
│   ├── README.md
│   ├── 01-service-scaling/
│   │   └── docker-compose-stack.yml
│   └── 02-rolling-updates/
│       └── docker-compose-update.yml
└── 06-pre-k8s-architecture/
    ├── README.md
    ├── 01-minikube-setup/
    │   └── verify-cluster.sh
    └── 02-manifest-translation/
        ├── pod-vs-container.md
        ├── compose-file.yml
        └── kompose-intro.md
```
