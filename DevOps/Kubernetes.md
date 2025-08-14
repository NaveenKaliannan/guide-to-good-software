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
| `kubectl describe deployments`          | describe the deployment.    |
| `kubectl get deployments`          | List deployments in the current namespace.    |
|`kubectl edit deployment deployment-name`|when edited using the kubectl edi. The Deployment controller then automatically applies your changes by creating new Pods or updating existing ones according to the new spec|
| `kubectl get rs` or `kubectl get replicaset`         | List replicasets in the current namespace.    |
| `kubectl get rs <replicaset-name> -o jsonpath="{.spec.selector.matchLabels}"` | Image used to creae pods in the replica set |
|`kubectl get pods -o jsonpath="{..image}"`|To directly list all images for Pods across your cluster (adjust label selector for your RS if needed)|
|`kubectl scale --replicas=5 rs/my-replicaset`| to scale up/scale down the pods. otherwise one has to kill the repplicaset and rename the replica in yaml and run it|
|`kubectl delete rs replica-name`| deletes the replicaset|
| `kubectl describe deployment <name>` | Show detailed info of a deployment.            |
| `kubectl apply -f deployment.yaml` | Create or update a deployment from YAML.       |
| `kubectl rollout status deployment/<name>` | Show rollout status of a deployment.       |
| `kubectl scale deployment <name> --replicas=N` | Scale deployment replicas to N.         |
| `kubectl delete deployment <name>` | Delete a deployment.                            |


| Strategy Type     | Description                                                                                           | Key Parameters                                         | Use Case Example |
|-------------------|-------------------------------------------------------------------------------------------------------|--------------------------------------------------------|------------------|
| **RollingUpdate** | Gradually replaces Pods with new ones, ensuring some are always available during the update.          | `maxUnavailable` (Pods allowed to be down during update)<br>`maxSurge` (extra Pods allowed above desired count) | Updating a live web app without downtime. |
| **Recreate**      | Stops all existing Pods before creating new ones.                                                      | *(No additional parameters — simply stops then starts)* | When the app can't have old and new versions running at the same time (e.g., DB schema changes). |

---

| #  | Command Example                                                           | Description                                                                                       |
|----|---------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| 1  | `kubectl get deployment`                                                  | List all Deployments in the current namespace.                                                    |
| 2  | `kubectl get deployment my-deploy`                                        | Get details of a specific Deployment.                                                             |
| 3  | `kubectl describe deployment my-deploy`                                   | Show detailed configuration and status of a Deployment.                                           |
| 4  | `kubectl rollout status deployment/my-deploy`                             | Watch the rollout status of a Deployment until it’s complete.                                     |
| 5  | `kubectl rollout history deployment/my-deploy`                            | View the revision history of a Deployment.                                                        |
| 6  | `kubectl rollout history deployment/my-deploy --revision=3`               | View details of a specific revision.                                                              |
| 7  | `kubectl set image deployment/my-deploy nginx=nginx:1.21.0`                | Update the container image in a Deployment (triggers rolling update).                             |
| 8  | `kubectl edit deployment my-deploy`                                       | Edit a Deployment’s configuration in-place.                                                       |
| 9  | `kubectl apply -f deployment.yaml`                                        | Apply changes to a Deployment manifest (updates if exists).                                       |
| 10 | `kubectl scale deployment my-deploy --replicas=5`                         | Scale a Deployment to the desired number of replicas.                                             |
| 11 | `kubectl rollout pause deployment/my-deploy`                              | Pause a Deployment’s rollout (useful before multiple changes).                                    |
| 12 | `kubectl rollout resume deployment/my-deploy`                             | Resume a paused Deployment’s rollout.                                                             |
| 13 | `kubectl rollout undo deployment/my-deploy`                               | Roll back a Deployment to the previous revision.                                                   |
| 14 | `kubectl rollout undo deployment/my-deploy --to-revision=2`               | Roll back a Deployment to a specific revision.                                                     |
| 15 | `kubectl delete deployment my-deploy`                                     | Delete a Deployment and all managed Pods.                                                          |
| 16 | `kubectl replace -f deployment.yaml`                                      | Replace the Deployment with a new manifest (overwrites configuration).                            |
| 17 | `kubectl patch deployment my-deploy -p '{"spec":{"replicas":4}}'`         | Patch a Deployment with updated replica count.                                                     |
| 18 | `kubectl rollout status deployment/my-deploy --timeout=60s`               | Check rollout status with a custom timeout.                                                        |
| 19 | `kubectl get rs -l app=myapp`                                             | Get ReplicaSets created by a Deployment.                                                           |
| 20 | `kubectl delete rs my-deploy-abc123`                                      | Delete a specific ReplicaSet (forces Deployment to recreate Pods if replicas are missing).         |

---
## Service and Networking

| Command                             | Description                                   |
|-----------------------------------|-----------------------------------------------|
| `kubectl get services`             | List services in the current namespace.       |
| `kubectl describe service <name>` | Show detailed service info.                     |
| `kubectl expose pod <pod> --port=80 --target-port=80` | Expose a pod as a service.      |
| `kubectl get endpoints`            | List service endpoints.                         |

| Service Type    | Description                                                                                      | YAML Example |
|-----------------|--------------------------------------------------------------------------------------------------|--------------|
| **ClusterIP**   | Default service type. Exposes the Service on an internal IP in the cluster, accessible only inside the cluster. | ```yaml<br>apiVersion: v1<br>kind: Service<br>metadata:<br>  name: my-service<br>spec:<br>  selector:<br>    app: myapp<br>  ports:<br>  - port: 80<br>    targetPort: 8080<br>  type: ClusterIP<br>``` |
| **NodePort**    | Exposes the Service on each Node’s IP at a static port (30000–32767). Accessible from outside the cluster via `<NodeIP>:<NodePort>`. | ```yaml<br>apiVersion: v1<br>kind: Service<br>metadata:<br>  name: my-service<br>spec:<br>  selector:<br>    app: myapp<br>  ports:<br>  - port: 80<br>    targetPort: 8080<br>    nodePort: 30007<br>  type: NodePort<br>``` |
| **LoadBalancer**| Creates an external load balancer (on supported clouds) and assigns a fixed, external IP to the Service. | ```yaml<br>apiVersion: v1<br>kind: Service<br>metadata:<br>  name: my-service<br>spec:<br>  selector:<br>    app: myapp<br>  ports:<br>  - port: 80<br>    targetPort: 8080<br>  type: LoadBalancer<br>``` |


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
| Option           | Description                                                             | Example Value / Notes                                  |
|------------------|-------------------------------------------------------------------------|-------------------------------------------------------|
| **apiVersion**   | API version of the Kubernetes object                                   | `v1`                                                  |
| **kind**         | Type of resource                                                       | `Pod`                                                 |
| **metadata**     | Metadata about the Pod, including name, namespace, labels, annotations | `name: my-pod`, `labels: app: frontend`               |
| **spec**         | Specification of the Pod and its contents                             | Defines containers, volumes, restartPolicy, etc.      |

| #  | Use Case Title                                  | Question                                                   | Answer (Summary)                                                                                       | Example Snippet |
|----|-------------------------------------------------|-------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|-----------------|
| 1  | **Basic Single-Container Pod**                  | How to run a simple container in Kubernetes?               | A Pod can run one container with its own image and ports.                                               | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: mypod<br>spec:<br>  containers:<br>  - name: mycontainer<br>    image: nginx:latest<br>    ports:<br>    - containerPort: 80<br>``` |
| 2  | **Multi-Container Pod (Sidecar Pattern)**       | Can a Pod run multiple containers?                         | Yes, containers in the same Pod share network and storage, useful for sidecars.                         | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: sidecar-pod<br>spec:<br>  containers:<br>  - name: main-app<br>    image: nginx<br>  - name: sidecar<br>    image: busybox<br>    command: ["sh", "-c", "while true; do echo hello; sleep 10; done"]<br>``` |
| 3  | **Pod with Environment Variables**               | How to pass configuration to a Pod?                        | Use `env` for key-value pairs or from ConfigMaps/Secrets.                                               | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: env-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: alpine<br>    env:<br>    - name: MY_VAR<br>      value: "my-value"<br>``` |
| 4  | **Pod with Volume Mount**                        | How can a Pod use storage?                                 | Define `volumes` in Pod spec and mount them in containers.                                              | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: volume-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: nginx<br>    volumeMounts:<br>    - name: myvol<br>      mountPath: /data<br>  volumes:<br>  - name: myvol<br>    emptyDir: {}<br>``` |
| 5  | **Pod with ConfigMap Data**                      | How to inject configuration from ConfigMap?                | Mount ConfigMap as files or inject as env vars.                                                         | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: configmap-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: nginx<br>    envFrom:<br>    - configMapRef:<br>        name: my-config<br>``` |
| 6  | **Pod with Secret**                              | How to securely use secrets?                               | Use Secrets as env vars or mounted volumes.                                                             | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: secret-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: nginx<br>    envFrom:<br>    - secretRef:<br>        name: my-secret<br>``` |
| 7  | **Pod with Resource Limits**                     | How to control CPU/memory usage?                           | Use `resources.requests` and `resources.limits`.                                                        | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: resource-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: nginx<br>    resources:<br>      requests:<br>        memory: "128Mi"<br>        cpu: "250m"<br>      limits:<br>        memory: "256Mi"<br>        cpu: "500m"<br>``` |
| 8  | **Pod with Liveness and Readiness Probes**       | How to ensure Pod health?                                  | Add probes to restart unhealthy containers and mark readiness.                                          | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: probe-pod<br>spec:<br>  containers:<br>  - name: app<br>    image: nginx<br>    livenessProbe:<br>      httpGet:<br>        path: /<br>        port: 80<br>      initialDelaySeconds: 5<br>      periodSeconds: 10<br>    readinessProbe:<br>      httpGet:<br>        path: /<br>        port: 80<br>      initialDelaySeconds: 5<br>      periodSeconds: 10<br>``` |
| 9  | **Init Containers in a Pod**                     | How to run setup tasks before main containers?             | Use `initContainers` to prepare data/config before main containers start.                               | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: init-pod<br>spec:<br>  initContainers:<br>  - name: init-myservice<br>    image: busybox<br>    command: ['sh', '-c', 'echo Initializing...']<br>  containers:<br>  - name: app<br>    image: nginx<br>``` |
| 10 | **Node Selection for Pods**                       | How to schedule Pod on specific nodes?                     | Use `nodeSelector` or `affinity` in Pod spec.                                                            | ```yaml<br>apiVersion: v1<br>kind: Pod<br>metadata:<br>  name: node-select-pod<br>spec:<br>  nodeSelector:<br>    disktype: ssd<br>  containers:<br>  - name: app<br>    image: nginx<br>``` |

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: complex-pod
  labels:
    app: complex-app
    environment: production
    tier: backend
  annotations:
    description: "A complex pod with multiple containers, volumes, probes, and node constraints."
spec:
  nodeSelector:
    disktype: ssd
  tolerations:
    - key: "dedicated"
      operator: "Equal"
      value: "special"
      effect: "NoSchedule"
  affinity:
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        - labelSelector:
            matchExpressions:
              - key: app
                operator: In
                values:
                  - complex-app
          topologyKey: "kubernetes.io/hostname"
  hostNetwork: false
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
    - name: shared-data
      emptyDir: {}
    - name: app-config
      configMap:
        name: complex-app-config
    - name: app-secret
      secret:
        secretName: complex-app-secret
    - name: persistent-storage
      persistentVolumeClaim:
        claimName: complex-app-pvc
  initContainers:
    - name: init-setup
      image: busybox:1.36
      command: ["sh", "-c", "echo Initialization complete > /shared/init.log"]
      volumeMounts:
        - name: shared-data
          mountPath: /shared
  containers:
    - name: main-container
      image: myregistry.com/complex-app:latest
      ports:
        - containerPort: 8080
          protocol: TCP
      env:
        - name: APP_ENV
          valueFrom:
            configMapKeyRef:
              name: complex-app-config
              key: ENV
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: complex-app-secret
              key: db-password
      volumeMounts:
        - name: shared-data
          mountPath: /var/cache/app
        - name: persistent-storage
          mountPath: /var/lib/app/data
      resources:
        requests:
          memory: "512Mi"
          cpu: "500m"
        limits:
          memory: "2Gi"
          cpu: "2"
      livenessProbe:
        httpGet:
          path: /healthz
          port: 8080
        initialDelaySeconds: 15
        periodSeconds: 20
        failureThreshold: 3
      readinessProbe:
        exec:
          command: ["cat", "/var/cache/app/ready"]
        initialDelaySeconds: 10
        periodSeconds: 15
      lifecycle:
        postStart:
          exec:
            command: ["/bin/sh", "-c", "echo Pod started > /var/lib/app/start.log"]
        preStop:
          exec:
            command: ["/bin/sh", "-c", "echo Pod is terminating > /var/lib/app/stop.log"]
    - name: sidecar-logger
      image: fluent/fluentd:v1.15-debian-1
      args:
        - "-q"
        - "--no-supervisor"
      volumeMounts:
        - name: persistent-storage
          mountPath: /fluentd/log
  serviceAccountName: complex-app-serviceaccount
```
#### Replicaset
| Option       | Purpose                                   | Example Value                  |
|--------------|-------------------------------------------|-------------------------------|
| `apiVersion` | Kubernetes API version for ReplicaSet     | `apps/v1`                     |
| `kind`       | Type of resource                           | `ReplicaSet`                  |
| `metadata`   | Name and labels for ReplicaSet             | `name: my-replicaset`         |
| `spec.replicas`  | Desired number of pod replicas            | `3`                           |
| `spec.selector`  | Label selector for matching pods          | `matchLabels: {app: myapp}`   |
| `spec.template`  | Pod template for creating new pods        | Defines containers, labels, ports |

| #  | Use Case Title                                  | Question                                                   | Answer (Summary)                                                                                       | Example YAML Snippet |
|----|-------------------------------------------------|-------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|----------------------|
| 1  | **Basic Pod Selection with matchLabels**        | How does a ReplicaSet use `matchLabels` to manage Pods?     | `matchLabels` defines exact key-value pairs a Pod must have to be managed by the ReplicaSet.            | ```yaml<br>selector:<br>  matchLabels:<br>    app: myapp<br>``` |
| 2  | **Complex Selection with matchExpressions**     | When should you use `matchExpressions` instead of `matchLabels`? | Use `matchExpressions` for flexible queries with operators like `In`, `NotIn`, `Exists`, `DoesNotExist`. | ```yaml<br>selector:<br>  matchExpressions:<br>    - key: env<br>      operator: In<br>      values: [prod, staging]<br>``` |
| 3  | **Avoiding Overlap Between ReplicaSets**        | Why should selectors not overlap among ReplicaSets?         | To prevent controllers from managing the same Pods, which causes conflicts and instability.             | *(Ensure unique label sets)* |
| 4  | **Adopting Existing Pods**                      | What happens if Pods already match the label selector?      | ReplicaSet adopts orphan Pods that match its selector and counts them toward desired replicas.           | *(No snippet — happens automatically)* |
| 5  | **Scaling with Selectors**                      | How do selectors impact scaling?                            | ReplicaSet scales only Pods matching its selector, creating or deleting to match `.spec.replicas`.       | ```bash<br>kubectl scale rs my-rs --replicas=5<br>``` |
| 6  | **Multiple Label Matching**                     | Can selectors require multiple labels to match?             | Yes, `matchLabels` can have multiple key-value pairs that must all be present.                           | ```yaml<br>selector:<br>  matchLabels:<br>    app: myapp<br>    tier: frontend<br>``` |
| 7  | **Exists Operator**                              | How to match any Pod with a specific label key, regardless of its value? | Use `operator: Exists` in `matchExpressions`.                                                           | ```yaml<br>matchExpressions:<br>  - key: environment<br>    operator: Exists<br>``` |
| 8  | **Excluding Pods (`NotIn`)**                     | How can you exclude Pods with certain label values?         | Use `operator: NotIn` with `values` list to filter out Pods.                                             | ```yaml<br>matchExpressions:<br>  - key: version<br>    operator: NotIn<br>    values: ["v1"]<br>``` |
| 9  | **Selector-Pod Template Match Requirement**     | Why must a ReplicaSet’s selector match its Pod template labels? | Kubernetes enforces this for accurate Pod ownership; mismatch will reject creation.                     | *(Labels in `.spec.template.metadata.labels` must match `.spec.selector`)* |
| 10 | **Blue-Green / Canary Deployment Selectors**    | How can selectors support deployment strategies?            | By assigning version labels (`version: blue`, `version: green`) to control traffic to different ReplicaSets. | ```yaml<br>selector:<br>  matchLabels:<br>    version: blue<br>``` |


```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: complex-replicaset
  labels:
    app: complex-demo
    tier: backend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: complex-demo
      environment: test
    matchExpressions:
      - key: version
        operator: In
        values:
          - "v1"
          - "v2"
  template:
    metadata:
      labels:
        app: complex-demo
        environment: test
        version: v1
      annotations:
        description: "A complicated ReplicaSet example for training"
    spec:
      nodeSelector:
        disktype: ssd
      tolerations:
        - key: "dedicated"
          operator: "Equal"
          value: "special"
          effect: "NoSchedule"
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            - labelSelector:
                matchExpressions:
                  - key: app
                    operator: In
                    values:
                      - complex-demo
              topologyKey: "kubernetes.io/hostname"
      volumes:
        - name: shared-data
          emptyDir: {}
        - name: app-config
          configMap:
            name: app-configmap
        - name: secrets-store
          secret:
            secretName: app-secret
        - name: persistent-storage
          persistentVolumeClaim:
            claimName: app-pvc
      initContainers:
        - name: busybox-init
          image: busybox:1.36
          command: ["sh", "-c", "echo 'Init: preparing data...' > /shared/start.log"]
          volumeMounts:
            - name: shared-data
              mountPath: /shared
      containers:
        - name: main-backend
          image: ghcr.io/linuxserver/plex:latest
          ports:
            - containerPort: 32400
          env:
            - name: APP_ENV
              valueFrom:
                configMapKeyRef:
                  name: app-configmap
                  key: ENV
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secret
                  key: db-password
          volumeMounts:
            - name: shared-data
              mountPath: /app/cache
            - name: persistent-storage
              mountPath: /app/data
          resources:
            requests:
              memory: "256Mi"
              cpu: "250m"
            limits:
              memory: "1Gi"
              cpu: "1"
          livenessProbe:
            httpGet:
              path: /healthz
              port: 32400
            initialDelaySeconds: 10
            periodSeconds: 15
          readinessProbe:
            exec:
              command: ["cat", "/app/cache/start.log"]
            initialDelaySeconds: 5
            periodSeconds: 10
        - name: sidecar-nginx
          image: nginx:1.25
          ports:
            - containerPort: 8080
          args:
            - "/bin/bash"
            - "-c"
            - "nginx -g 'daemon off;'"
          volumeMounts:
            - name: app-config
              mountPath: /etc/nginx/conf.d
      dnsPolicy: ClusterFirstWithHostNet
      hostNetwork: true
      restartPolicy: Always
```
* Deployment
| #  | Use Case Title                              | Question                                               | Answer Summary                                                                                              | Example Brief |
|----|---------------------------------------------|--------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|---------------|
| 1  | **Basic Deployment with Multiple Replicas** | How to create multiple pods with a Deployment?         | Use `replicas` field to specify the count of pod replicas to run.                                            | `replicas: 3` in the Deployment spec |
| 2  | **Pod Selection Using matchLabels Selector**| How does Deployment select Pods to manage?             | Uses `selector.matchLabels` to find Pods with matching labels created from the Pod template.                 | `selector: matchLabels: app: example` |
| 3  | **Rolling Update Strategy**                 | How to roll out updates without downtime?              | Set `strategy.type: RollingUpdate` with `maxSurge` and `maxUnavailable` to control rolling updates.          | `strategy: type: RollingUpdate` |
| 4  | **Resource Requests and Limits**            | How to manage container resource usage?                | `resources.requests` and `resources.limits` ensure proper CPU and memory allocation on nodes.                | `resources: requests/limits` |
| 5  | **Liveness and Readiness Probes**           | How to check pod health and readiness?                 | Define `livenessProbe` and `readinessProbe` for containers to auto-restart or mark pod ready status.         | `livenessProbe` with HTTP get |
| 6  | **Using Environment Variables inside Pods** | How to pass config to containers?                      | Environment variables can be passed via `env` field (not shown in YAML but supported).                       | `env` field in container spec |
| 7  | **Updating Container Image Version**        | How to update app version?                             | Change container image tag in YAML and apply for Deployment to perform rolling update.                       | Change `image: nginx:latest` |
| 8  | **Scaling Deployment**                      | How to scale pods up or down?                          | Change `replicas` value to increase or decrease Pod count dynamically.                                       | `kubectl scale deployment` command |
| 9  | **Using Labels for Organized Deployment**   | Why use labels in metadata?                            | Labels help identify and organize resources, used by selector, affinity rules, or network policies.          | `metadata.labels: app: example` |
| 10 | **Pod Template Customization**              | How to customize pods created by Deployment?           | Custom Pod template under `spec.template` defines containers, volumes, probes, etc.                          | `spec.template` defines pod spec |
 
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
  labels:
    app: example
spec:
  replicas: 3
  selector:
    matchLabels:
      app: example
  template:
    metadata:
      labels:
        app: example
    spec:
      containers:
        - name: example-container
          image: nginx:latest
          ports:
            - containerPort: 80
          resources:
            requests:
              memory: "128Mi"
              cpu: "100m"
            limits:
              memory: "256Mi"
              cpu: "200m"
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 10
            periodSeconds: 20
          readinessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 10
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
```  

******************************

# Networking
Kubernetes assigns IP addresses to pods from a predefined range called the pod CIDR (Classless Inter-Domain Routing). Kubernetes networking is achieved via various solutions, including Cisco's offerings as well as other third-party networking providers. Kubernetes itself does not provide a built-in networking implementation. Instead, it relies on external Container Network Interface (CNI) plugins to handle pod-to-pod networking within a cluster. Some popular CNI plugins include: Calico (open-source, used by Cisco Intersight Kubernetes Service) Flannel Weave Net Cilium. Other vendors like VMware (NSX-T), Juniper (Contrail), and cloud providers like AWS (VPC CNI), Azure (Azure CNI), and GCP (GCP CNI) also offer their own CNI plugins for Kubernetes networking
