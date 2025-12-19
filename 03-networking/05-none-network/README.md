# 05 – Docker None Network

## 1. Basics: What is None Network?

The **none network** mode completely **disables networking** for a container.

When a container uses the none network:

* No network interface is attached
* No IP address is assigned
* No inbound or outbound connectivity
* Container is fully isolated at the network level

This mode is used when **network access must be blocked entirely**.



## 2. Key Characteristics of None Network

* Zero network connectivity
* No DNS resolution
* No internet access
* Maximum isolation
* Suitable for high-security or offline workloads



## 3. How None Network Works Internally

Normal bridge mode:

```
Container → veth → bridge → NAT → Internet
```

None network mode:

```
Container → (no network interfaces)
```

Docker creates the container **without attaching any network namespace interfaces**.



## 4. Docker vs Kubernetes Networking Mapping

| Docker         | Kubernetes                 |
| -------------- | -------------------------- |
| --network none | NetworkPolicy (deny all)   |
| No interface   | Isolated Pod               |
| No IP          | Pod without ingress/egress |
| Full isolation | Zero-trust baseline        |

Kubernetes does not have a direct `none` mode, but similar behavior is achieved using **NetworkPolicies**.



## 5. Hands-on Practice: None Network Mode

### Step 1: Run a Container with None Network

```bash
docker run -dit --name none-demo --network none busybox sh
```

---

### Step 2: Inspect Network Configuration

```bash
docker inspect none-demo
```

Look for:

* `"NetworkMode": "none"`
* Empty IP address fields

---

### Step 3: Check Network Interfaces Inside Container

```bash
docker exec -it none-demo ip addr
```

Expected result:

* Only `lo` (loopback) interface exists

---

### Step 4: Test Network Connectivity (Expected Failure)

Ping external host:

```bash
docker exec -it none-demo ping -c 3 google.com
```

Result:

* Network unreachable

Try DNS lookup:

```bash
docker exec -it none-demo nslookup google.com
```

Result:

* Fails

---

### Step 5: Cleanup

```bash
docker stop none-demo
docker rm none-demo
```



## 6. Security Use Cases

None network is useful for:

* Batch processing jobs
* Data processing containers
* Malware analysis sandboxes
* Highly restricted environments

It enforces **network-level zero trust**.


## 7. How This Helps in Learning Kubernetes

Understanding none network helps you:

* Appreciate network isolation
* Design secure workloads
* Understand NetworkPolicies
* Implement least-privilege networking

In Kubernetes:

* Isolation is enforced using CNI + NetworkPolicy
* Default behavior allows traffic unless restricted


## 8. Conclusion and Summary

At the end of this module, you learned:

* What none network mode is
* How it fully isolates containers
* How to verify lack of networking
* How Docker none network maps to Kubernetes security concepts

This mode emphasizes **security-first container design**.


## 9. Practice Questions

### Conceptual Questions

1. What is none network mode?
2. Why would you use none network?
3. What interfaces exist in none network mode?


### Command-Based Questions

4. Command to run a container with none network
5. Command to inspect container network mode


### Kubernetes-Oriented Questions

6. How does Kubernetes implement network isolation?
7. What is the role of NetworkPolicy?


### Hands-on Tasks

8. Run a container with none network
9. Verify only loopback interface exists
10. Attempt outbound traffic and document the failure

<br>
<br>

# Files are readily present in this folder
## FILE: `05-none-network/verify-none-network.sh`

```bash
#!/bin/bash

echo "Starting container with none network..."

docker run -dit --name none-test --network none busybox sh

echo "Checking network interfaces inside container..."
docker exec none-test ip addr

echo "Testing internet connectivity (expected to fail)..."
docker exec none-test ping -c 2 google.com || echo "Ping failed as expected"

echo "Cleaning up..."
docker stop none-test
docker rm none-test

echo "None network verification completed"
```

Make executable:

```bash
chmod +x verify-none-network.sh
```


## How to Run This Demo

```bash
cd 05-none-network
./verify-none-network.sh
```