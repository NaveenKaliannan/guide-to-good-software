# Kubernetes or K8s
******************************
It manages containerized applications. 
* **Containers** packages applications or virtualize application layers. They are an isolated environements, own process, own network, own volume and etc.
* **Container Orchestration** Process of deploying and managing lot of containers in clusteres environment.
* **kubernetes** encapsulates the containered applications such as docker containers and then runs it on worker nodes. 
******************************

# Installation of K8s
******************************
* https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
******************************

# Terminology in K8s
******************************
* **pod** is the basic unit that encapsulates and manages one or more tightly coupled containers for deployment in a Kubernetes cluster. A Kubernetes pod is the fundamental unit that encapsulates and manages one or more tightly coupled containers as a single deployable entity within a Kubernetes cluster

Key characteristics of a Kubernetes pod:
1. A pod is a single instance of an application. It represents a running process in the cluster.
2. Pods contain one or more containers that share the same network, storage, and lifecycle. Typically, a pod contains a single container, but it can also contain multiple containers that work together as part of the same application.
3. Additional containers are not added to an existing pod. To scale up an application, you increase the number of pods running the application. To scale down, you delete pods.
4. Pods are ephemeral in nature - if a pod (or the node it is running on) fails, Kubernetes can automatically create a new replica of that pod to continue operations.
5. Pods are defined using YAML configuration files, which specify the containers, storage, and networking settings for the pod.
6. Kubernetes users can create pods directly, but the Kubernetes controller usually creates pods and pod replicas for high availability or horizontal scaling.
******************************

# Architecture of Kubernetes 
******************************
* **Master** node is a node where Kubernetes installed and it mangaes the cluster, which contains set of nodes. The master server contain kube-apiserver that makes them master. It conatins the etcd, controller, scheduler as well.
* when K8s is installed, we are installing the following components: **API server, etcd, kubelet, container runtime, controller, scheduler**
* **API server** The API server is the front-end for the Kubernetes control plane. It exposes the Kubernetes API, which allows users, management devices, and the cluster's internal components to interact with the cluster. The API server stores the cluster state in etcd and exposes it via a RESTful API
1. When you run a Kubernetes command (e.g., kubectl apply -f pod.yaml), the kubectl client sends a REST API request to the Kubernetes API server. The API server is the central management point for the cluster state.
2. The API server processes the request and creates the Pod resource object in its internal state and writes this new desired state as a serialized key-value pair in etcd (the distributed key-value store).
3. The scheduler watches the API server for newly created Pods that do not have a nodeName assigned yet. Once it finds such a Pod, it selects an appropriate node by evaluating resource availability and other constraints, then updates the Pod resource by assigning the nodeName field through the API server.
4. This update causes the API server to write the updated Pod state (now bound to a node) back into etcd.
5. The controller(s) watch the API server (and thus etcd indirectly) for changes in cluster state. When they detect the Pod is scheduled to a node, they ensure any dependent resources and cluster state are consistent and may trigger other updates as needed.
6. The kubelet, running on the worker node assigned to the Pod (nodeName), monitors the API server for newly assigned or updated Pods on its node. It then communicates with the container runtime (e.g., Docker, containerd) to start and manage the Pod's containers. The kubelet regularly reports Pod and node status back to the API server, which updates that status in etcd as well.

* **etcd** is a distributed, consistent, and highly available key-value store used as the primary data store for Kubernetes. It stores all cluster state and configuration data, making it critical to the reliability and performance of Kubernetes clusters. The API server stores the cluster state in etcd and exposes it via a RESTful API
---
#### 🔧 What is etcd?
- Developed by CoreOS, now part of CNCF.
- Written in Go.
- Uses the **Raft** consensus algorithm for strong consistency.
- Exposes HTTP/gRPC APIs.
---
#### 🚀 Features
- **Strong Consistency:** Achieved through the Raft consensus algorithm.
- **High Availability:** Replicated across multiple master nodes.
- **Hierarchical Key Storage:** Like a virtual filesystem (`/registry/...`).
- **Watch & Notification System:** Clients can watch keys for changes.
---
#### 📦 etcd in Kubernetes
| Node Type   | Typical Count | Runs etcd | Data Location |
|-------------|---------------|-----------|----------------|
| Master Node | 3 or 5        | ✅ Yes     | `/var/lib/etcd/` |
| Worker Node | N (scalable)  | ❌ No      | N/A             |
- **Master Nodes**: Run etcd as a static pod or systemd service.
- **Worker Nodes**: Do **not** run etcd, but communicate via API server.
---
#### 📂 etcd Data File Layout (on Master Node)
```
/var/lib/etcd/
└── member/
    ├── snap/
    │   └── db       # Main database file (BoltDB)
    ├── wal/         # Write-ahead logs
    └── ...          # Metadata and cluster information
```
---
#### 🔑 etcd Key-Value Format in Kubernetes
#### 📌 Pod Creation Example
1. User runs: `kubectl apply -f pod.yaml`
2. API Server receives the request.
3. Writes the pod object under key:
   - `/registry/pods/<namespace>/<podname>`
4. Value is a serialized JSON or protobuf object.
**Example:**
- **Key**: `/registry/pods/default/nginx-deployment-abc123`
- **Value**: Serialized Pod spec and status.
#### 📤 Pod Deletion
- Key `/registry/pods/default/nginx-deployment-abc123` is **deleted** from etcd.
- Change is reflected in the `db` file and WAL.
### 🔁 Pod Update
- Key remains the same.
- Value is overwritten with updated data.
---
#### 🛠 How etcd Changes in Different Scenarios
| Scenario                  | etcd Behavior |
|---------------------------|----------------|
| Pod Created               | New key-value added |
| Pod Updated               | Value updated |
| Pod Deleted               | Key removed |
| Master Node Fails         | Quorum required to proceed (≥ majority) |
| Worker Node Fails         | No effect on etcd |
| etcd Member Added/Removed | Raft reconfigures and syncs data |
| etcd Data Corrupted       | Use snapshot or backup for restore |
---
#### 🧪 Sample Key Listing
Run `etcdctl` with proper TLS/auth to see keys:
```bash
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379   --cacert=/etc/kubernetes/pki/etcd/ca.crt   --cert=/etc/kubernetes/pki/etcd/server.crt   --key=/etc/kubernetes/pki/etcd/server.key   get /registry/pods --prefix --keys-only
```
---
#### 🔄 High Availability: Master Nodes
Deploying 3 or 5 master nodes helps maintain quorum:
- **3 nodes**: Tolerates 1 failure
- **5 nodes**: Tolerates 2 failures
Always keep etcd node count **odd** for optimal quorum.
---
#### 📉 Failure Scenarios and etcd
#### 🔴 etcd Member Down
- Cluster remains functional if quorum is maintained.
- Replace or recover failed etcd node to restore full redundancy.
#### ❌ Pod Fails (CrashLoopBackOff)
- etcd retains pod spec until explicitly deleted.
- Status changes in the value field of the key.
#### ❌ etcd Corruption
- Use `etcdctl snapshot save` and `etcdctl snapshot restore` for backups and disaster recovery.
---
---

#### 🧰 Useful Commands
```bash
# Get a key
etcdctl get /registry/pods/default/nginx

# List all keys
etcdctl get "" --prefix --keys-only

# Watch for changes
etcdctl watch /registry/pods --prefix

# Take a snapshot
etcdctl snapshot save snapshot.db

# Restore from snapshot
etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd
```
* **controller**  is a daemon that embeds the core control loops shipped with Kubernetes. It watches the shared state of the cluster through the API server and makes changes to move the current state towards the desired state. Controllers monitor cluster resources and make changes by creating, updating, or deleting Kubernetes objects to match the desired state. Controllers typically run on the master (control plane) nodes. Controllers continuously watch the cluster state via the API server, looking for discrepancies between the desired state and actual state. When they detect changes (e.g., Pod failed, insufficient replicas), they write updates or create/delete resources via the API server to reconcile the difference. The controller does not assign nodes but monitors the cluster state continuously via the API server. It ensures that the overall desired state is maintained by creating or deleting Pods and other resources as needed. For example, if a Pod fails or a node becomes unhealthy, controllers react to those changes by adjusting replicas, rescheduling Pods, or managing node lifecycle events.
* **scheduler** is responsible for distributing work or containers across the nodes in the cluster. It watches for newly created Pods with no assigned node, and selects a node for them to run on. The scheduler runs on master nodes as part of the control plane. The scheduler decides which node each Pod should run on by evaluating the cluster state and Pod requirements. The scheduler watches newly created Pods that have no assigned node by watching the API server for Pods without a nodeName. It decides on the best-fit worker node for each Pod, then updates the Pod's specification with the selected node by writing this information back to the API server. This update propagates as a change in the cluster state stored in etcd
* **container runtime** is the software that is responsible for running containers. Kubernetes supports several container runtimes, such as Docker, containerd, and CRI-O.
* **kubelet** is the primary "node agent" that runs on each node. The kubelet is the primary agent that runs on each worker node. It watches for Pods that have been assigned to its node, and ensures that the containers in those Pods are healthy and running. It communicates with the container runtime (Docker, containerd, CRI-O) to create, start, stop, and monitor containers. The kubelet on each worker node watches the API server for Pods assigned to its node (nodeName set). After detecting new or updated Pods, the kubelet uses the container runtime to start or manage containers accordingly and continuously reports the Pod and node status back to the API server
* **Nodes** Nodes are the physical or virtual machines where the containers will be launched. Each worker node runs a kubelet, which is the agent responsible for interacting with the Kubernetes master components.  The Nodes server contain kublet that makes them nodes.
* **Cluster** A Kubernetes cluster is a set of nodes that run containerized applications. The cluster is managed by the Kubernetes master components. 
******************************
* **kubectl** is a command-line interface and primary tool for interacting with and controlling Kubernetes clusters, enabling deployment, inspection, and management of applications and cluster resources. It communicates with the Kubernetes API server by sending commands and instructions to control the cluster state
* **kubectl run --hello-minikube** This command is used to run a simple Hello Minikube application in a Kubernetes cluster. It creates a Deployment and a Service, and then outputs the URL to access the Hello Minikube application.
* **kubectl cluster-info** command does provide information about the status of the Kubernetes cluster, including the URLs of the API server, the Kubernetes dashboard (if enabled), and any additional services running in the cluster.
* **kubectl get nodes** This command will list all the nodes in the cluster and their current status (e.g., Ready, NotReady, etc.).
* **kubectl describe node <node-name>** get more detailed information about a specific node.
******************************

# Command
******************************
* **kubectl run name --image=image [options]** create and run a particular Docker image in a Kubernetes pod. `<name>` is the name you want to assign to the pod.
* **kubectl get pods** list of all pods in the current namespace.   or **kubectl get pods -o wide**   To get more detailed information about the pods
******************************

# Kubernetes Top 100 Commands Cheat Sheet

This cheat sheet lists common Kubernetes (`kubectl`) commands with brief descriptions to help you manage and troubleshoot your Kubernetes clusters efficiently.

---

## Cluster and Node Management

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl cluster-info`             | Show cluster info and API server endpoints.  |
| `kubectl get nodes`                | List all nodes in the cluster.                 |
| `kubectl describe node <node>`    | Show detailed info about a specific node.     |
| `kubectl drain <node>`             | Safely evict pods before node maintenance.    |
| `kubectl cordon <node>`            | Mark node as unschedulable.                     |
| `kubectl uncordon <node>`          | Mark node as schedulable again.                 |
| `kubectl label node <node> key=val` | Add or update label on node.                   |
| `kubectl annotate node <node> key=val` | Add or update annotation on node.             |
| `kubectl get nodes --show-labels` | Show labels attached to nodes.                  |
| `kubectl top node <node>`          | Display resource usage (CPU/memory) of node.  |

---

## Pod Management

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get pods`                 | List pods in the current namespace.            |
| `kubectl get pods -o wide`         | List pods with detailed info (including node). |
| `kubectl describe pod <pod>`      | Show detailed info of a pod.                     |
| `kubectl logs <pod>`               | View logs for a pod's main container.          |
| `kubectl logs <pod> -c <container>` | View logs for a specific container in the pod. |
| `kubectl exec -it <pod> -- /bin/bash` | Open interactive shell in a pod container.    |
| `kubectl delete pod <pod>`        | Delete a specific pod.                           |
| `kubectl create -f pod.yaml`      | Create a pod from a YAML manifest file.         |
| `kubectl apply -f pod.yaml`       | Apply changes or create resources from YAML.    |
| `kubectl get pods --field-selector=status.phase=Running` | List running pods only.    |
| `kubectl annotate pod <pod> key=val` | Add or update annotation on a pod.              |
| `kubectl label pod <pod> key=val` | Add or update label on a pod.                     |
| `kubectl top pod <pod>`            | Show resource usage for pod.                      |

---

## Deployment and ReplicaSet

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get deployments`          | List deployments in the current namespace.    |
| `kubectl describe deployment <name>` | Show detailed info of a deployment.            |
| `kubectl apply -f deployment.yaml` | Create or update a deployment from YAML.       |
| `kubectl rollout status deployment/<name>` | Show rollout status of a deployment.       |
| `kubectl scale deployment <name> --replicas=N` | Scale deployment replicas to N.         |
| `kubectl delete deployment <name>` | Delete a deployment.                            |

---

## Service and Networking

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get services`             | List services in the current namespace.       |
| `kubectl describe service <name>` | Show detailed service info.                     |
| `kubectl expose pod <pod> --port=80 --target-port=80` | Expose a pod as a service.      |
| `kubectl get endpoints`            | List service endpoints.                         |

---

## Namespace Management

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get namespaces`            | List all namespaces.                           |
| `kubectl create namespace <name>` | Create a new namespace.                         |
| `kubectl delete namespace <name>` | Delete a namespace.                             |
| `kubectl config set-context --current --namespace=<name>` | Switch current namespace. |

---

## Configuration and Context Management

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl config view`              | Display kubeconfig details.                    |
| `kubectl config get-contexts`      | List available contexts.                        |
| `kubectl config use-context <name>` | Switch to a specific context.                  |

---

## Secrets and ConfigMaps

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get secrets`              | List secrets in the current namespace.         |
| `kubectl create secret generic <name> --from-literal=key=value` | Create a generic secret. |
| `kubectl get configmaps`           | List config maps in the current namespace.      |
| `kubectl create configmap <name> --from-file=path/to/file` | Create config map from file. |

---

## Debugging and Troubleshooting

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get events`               | List cluster events.                           |
| `kubectl describe <resource> <name>` | Describe resource and recent events.          |
| `kubectl exec -it <pod> -- /bin/sh` | Open shell inside container for debugging.    |
| `kubectl logs <pod> -p`            | Get logs from the previous container instance.|
| `kubectl top pods`                 | Show resource usage of pods.                    |

---

## Common Resource Commands (applicable to any resource)

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get <resource>`           | List resources of a given type (pods, svc, etc). |
| `kubectl describe <resource> <name>` | Show detailed information about a resource.     |
| `kubectl delete <resource> <name>` | Delete a resource.                               |
| `kubectl apply -f <file.yaml>`    | Apply a configuration file to create/update resource. |
| `kubectl edit <resource> <name>`  | Edit a resource on the fly in an editor.        |

---

## Advanced/Additional Commands

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl rollout undo deployment/<name>` | Roll back deployment to previous revision.  |
| `kubectl expose deployment <name> --type=LoadBalancer --port=80` | Expose deployment as load balancer service. |
| `kubectl port-forward <pod> <local_port>:<pod_port>` | Forward local port to pod port for access.  |
| `kubectl scale --replicas=<num> <resource>/<name>` | Scale replicas of resource.                   |
| `kubectl wait --for=condition=ready pod/<pod>` | Wait for pod to be ready.                      |
| `kubectl proxy`                   | Run proxy to access Kubernetes API locally.    |

---

This cheat sheet highlights the most commonly used commands that cover everyday cluster management, resource management, debugging, and configuration tasks.

For a complete and regularly updated list, official Kubernetes documentation and cheat sheets like:

- [Kubernetes Official Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Kubectl Commands Overview](https://spacelift.io/blog/kubernetes-cheat-sheet)
- [Kubectl Cheat Sheet by StrongDM](https://www.strongdm.com/blog/kubernetes-cheat-sheet)

are recommended.

---

*Note: Replace angle brackets like `<pod>` or `<node>` with the actual resource names in your cluster.*


### YAML files for POD
- apiVersion: apps/v1 for Deployment resource.
- kind: Deployment (could also be Pod, StatefulSet, etc. depending on need).
- metadata: Name, labels, and optional annotations (used here for proxy example).
- spec: Defines replicas, selector, and template.
* Example. 
******************************
```text
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-multi-app-deployment
  labels:
    app: multi-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: multi-app
  template:
    metadata:
      labels:
        app: multi-app
      annotations:
        example.com/proxy: "http://proxy.example.com:3128"
    spec:
      containers:
        - name: postgres
          image: postgres:14
          env:
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: username
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: password
          ports:
            - containerPort: 5432
          volumeMounts:
            - name: pgdata
              mountPath: /var/lib/postgresql/data

        - name: jenkins
          image: jenkins/jenkins:lts
          env:
            - name: JENKINS_ADMIN_ID
              valueFrom:
                secretKeyRef:
                  name: jenkins-secret
                  key: admin_id
            - name: JENKINS_ADMIN_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: jenkins-secret
                  key: admin_password
          ports:
            - containerPort: 8080
            - containerPort: 50000

        - name: apache-airflow
          image: apache/airflow:2.6.1
          env:
            - name: AIRFLOW__CORE__EXECUTOR
              value: "LocalExecutor"
            - name: AIRFLOW__CORE__FERNET_KEY
              valueFrom:
                secretKeyRef:
                  name: airflow-secret
                  key: fernet_key
            - name: AIRFLOW__CORE__SQL_ALCHEMY_CONN
              value: postgresql+psycopg2://postgres:password@postgres-service:5432/airflow
          ports:
            - containerPort: 8080

        - name: jfrog-artifactory
          image: releases-docker.jfrog.io/jfrog/artifactory-cpp-ce:latest
          env:
            - name: ARTIFACTORY_ADMIN_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: artifactory-secret
                  key: admin_password
          ports:
            - containerPort: 8081
          volumeMounts:
            - name: artifactory-data
              mountPath: /var/opt/jfrog/artifactory

        - name: docker-registry
          image: registry:2
          env:
            - name: REGISTRY_AUTH_HTPASSWD_PATH
              value: /auth/htpasswd
          ports:
            - containerPort: 5000
          volumeMounts:
            - name: registry-data
              mountPath: /var/lib/registry
            - name: auth
              mountPath: /auth

        - name: github-api-client
          image: some-github-api-client-image
          env:
            - name: GITHUB_API_KEY
              valueFrom:
                secretKeyRef:
                  name: github-secret
                  key: api_key
            - name: GITHUB_USERNAME
              valueFrom:
                secretKeyRef:
                  name: github-secret
                  key: username

        - name: rest-api-server
          image: example/rest-api:latest
          env:
            - name: API_KEY
              valueFrom:
                secretKeyRef:
                  name: restapi-secret
                  key: api_key
            - name: PROXY_URL
              value: "http://proxy.example.com:3128"
          ports:
            - containerPort: 8080

      volumes:
        - name: pgdata
          persistentVolumeClaim:
            claimName: pgdata-pvc
        - name: artifactory-data
          persistentVolumeClaim:
            claimName: artifactory-pvc
        - name: registry-data
          persistentVolumeClaim:
            claimName: registry-pvc
        - name: auth
          secret:
            secretName: registry-auth-secret
```
******************************

# Networking
Kubernetes assigns IP addresses to pods from a predefined range called the pod CIDR (Classless Inter-Domain Routing). Kubernetes networking is achieved via various solutions, including Cisco's offerings as well as other third-party networking providers. Kubernetes itself does not provide a built-in networking implementation. Instead, it relies on external Container Network Interface (CNI) plugins to handle pod-to-pod networking within a cluster. Some popular CNI plugins include: Calico (open-source, used by Cisco Intersight Kubernetes Service) Flannel Weave Net Cilium. Other vendors like VMware (NSX-T), Juniper (Contrail), and cloud providers like AWS (VPC CNI), Azure (Azure CNI), and GCP (GCP CNI) also offer their own CNI plugins for Kubernetes networking
