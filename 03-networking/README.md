# Docker Networking – Recommended Folder Structure

## What Each Folder Covers (Concept Map)

### 01 – Network Basics

* What is container networking
* How containers talk to host and each other
* Linux networking overview (bridge, veth)

---

### 02 – Default Bridge Network

* `docker0`
* IP assignment
* Container isolation
* Limitations of default bridge

---

### 03 – User-Defined Bridge Network

* Custom bridges
* Automatic DNS
* Container name resolution
* Recommended for production

---

### 04 – Host Network

* No isolation
* Direct host port usage
* Performance use cases
* Security risks

---

### 05 – None Network

* Complete isolation
* Debugging and security use cases

---

### 06 – Overlay Network

* Multi-host communication
* Docker Swarm basics
* Foundation for Kubernetes CNI

---

### 07 – Container DNS

* Embedded Docker DNS
* Service name resolution
* Networking by container name

---

### 08 – Port Mapping

* `-p` vs `--expose`
* Host-to-container traffic
* Kubernetes Service comparison

---

### 09 – Network Inspection

* `docker network inspect`
* Understanding IPAM
* Debugging connectivity

---

### 10 – Network Troubleshooting

* Common issues
* Tools: ping, curl, netstat, ss
* Debug containers

---

### 11 – Docker Compose Networking

* Multi-container apps
* Automatic network creation
* Service-to-service communication

---

### 12 – Network Security

* Isolation between networks
* Attack surface reduction
* Best practices

---

### 13 – Docker to Kubernetes Networking

* Docker bridge vs Kubernetes Pod network
* Service abstraction
* Ingress mapping
* CNI overview



```
docker-networking/
│
├── README.md
│
├── 01-network-basics/
│   ├── 01-network-basics.md
│   └── diagrams/
│       └── docker-network-types.png
│
├── 02-bridge-network/
│   ├── 02-bridge-network.md
│   ├── docker-compose.yml
│   └── demo/
│       ├── app1/
│       │   └── index.html
│       └── app2/
│           └── index.html
│
├── 03-user-defined-bridge/
│   ├── 03-user-defined-bridge.md
│   ├── docker-compose.yml
│   └── test-connectivity.sh
│
├── 04-host-network/
│   ├── 04-host-network.md
│   └── run-host-network.sh
│
├── 05-none-network/
│   ├── 05-none-network.md
│   └── verify-none-network.sh
│
├── 06-overlay-network/
│   ├── 06-overlay-network.md
│   ├── swarm-setup.md
│   └── docker-compose.yml
│
├── 07-container-dns/
│   ├── 07-container-dns.md
│   └── dns-test.sh
│
├── 08-port-mapping/
│   ├── 08-port-mapping.md
│   └── port-map-demo.sh
│
├── 09-network-inspection/
│   ├── 09-network-inspection.md
│   └── inspect-network.sh
│
├── 10-network-troubleshooting/
│   ├── 10-network-troubleshooting.md
│   └── troubleshooting-commands.sh
│
├── 11-docker-compose-networking/
│   ├── 11-compose-networking.md
│   ├── docker-compose.yml
│   └── multi-service-demo/
│       ├── backend/
│       └── frontend/
│
├── 12-network-security/
│   ├── 12-network-security.md
│   └── isolation-demo.sh
│
└── 13-docker-to-kubernetes-networking/
    ├── 13-docker-to-k8s-networking.md
    └── k8s-manifests/
        ├── pod.yaml
        ├── service.yaml
        └── ingress.yaml
```

---
