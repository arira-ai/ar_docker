# docker-to-k8s-mastery

A hands-on tutorial taking learners from Docker basics to Kubernetes readiness. Modules are numbered and progressive. Use the supplied exercises to run locally, experiment, and then map each concept to Kubernetes (Module 06).

Preface:
- Always start each exercise from the exercise folder.
- Use `docker system prune` cautiously between exercises to keep environment clean.
- Encourage students to try converting Compose files to K8s YAML (Module 06 will provide patterns).

Author: Arira Ai

docker-to-k8s-mastery/
├── .gitignore                          # Excludes venv, pycache, .env files
├── LICENSE                             # MIT License for open educational use
├── README.md                           # Master Syllabus, Prerequisites, and Setup Guide

├── 00-setup/                           # Module 0: Environment Preparation
│   ├── README.md                       # Guide for Docker Desktop/Minikube installation
│   └── verify_env.sh                   # Script to validate Docker, Python, Git installation

├── 01-basics/                          # Module 1: Images & Containers
│   ├── README.md                       # Module Overview: The Atom of Cloud Native
│   ├── 01-hello-world/                 # Exercise: The Container Lifecycle
│   │   ├── README.md
│   │   └── Dockerfile
│   ├── 02-custom-images/               # Exercise: Building and Layering
│   │   ├── README.md
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   └── Dockerfile
│   └── 03-multi-stage-builds/          # Exercise: Optimization for Production
│       ├── README.md
│       └── Dockerfile

├── 02-persistence/                     # Module 2: Data Persistence
│   ├── README.md                       # Theory: OverlayFS vs. Volumes
│   ├── 01-ephemeral-data/              # Exercise: Proving Data Volatility
│   │   ├── README.md
│   │   └── Dockerfile
│   ├── 02-named-volumes/               # Exercise: Database Persistence Lifecycle
│   │   ├── README.md
│   │   └── postgres-test.sh
│   └── 03-bind-mounts/                 # Exercise: Config Injection & Dev Workflows
│       ├── README.md
│       ├── nginx.conf
│       └── html/
│           └── index.html

├── 03-networking/                      # Module 3: Networking
│   ├── README.md                       # Theory: Bridge, Host, and Overlay Networks
│   ├── 01-bridge-networks/             # Exercise: Manual Container Linking
│   │   ├── README.md
│   │   └── verify-bridge.sh
│   └── 02-container-dns/               # Exercise: Service Discovery via Names
│       ├── README.md
│       └── network-test.sh

├── 04-compose/                         # Module 4: Docker Compose
│   ├── README.md                       # Theory: Declarative Orchestration
│   ├── 01-the-stack/                   # Exercise: Multi-Service Architecture
│   │   ├── README.md
│   │   ├── docker-compose.yml
│   │   ├── .env
│   │   └── app/
│   │       ├── Dockerfile
│   │       ├── app.py
│   │       └── requirements.txt
│   └── 02-healthchecks-startup/        # Exercise: Handling Dependency Race Conditions
│       ├── README.md
│       ├── docker-compose.yml
│       └── app/
│           ├── wait-for-it.sh          # Legacy script for comparison
│           └── Dockerfile

├── 05-swarm/                           # Module 5: Docker Swarm
│   ├── README.md                       # Theory: Introduction to Clustering
│   ├── 01-service-scaling/             # Exercise: Replicas and Load Balancing
│   │   └── docker-compose-stack.yml
│   └── 02-rolling-updates/             # Exercise: Update Strategies
│       └── docker-compose-update.yml

└── 06-pre-k8s-architecture/            # Module 6: Pre-K8s Architecture
    ├── README.md                       # Theory: The Limits of Compose
    ├── 01-minikube-setup/              # Exercise: Local K8s Validation
    │   └── verify-cluster.sh
    └── 02-manifest-translation/        # Exercise: Kompose and YAML mapping
        ├── pod-vs-container.md
        ├── compose-file.yml
        └── kompose-intro.md