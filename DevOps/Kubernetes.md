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
* **API server** The API server is the front-end for the Kubernetes control plane. It exposes the Kubernetes API, which allows users, management devices, and the cluster's internal components to interact with the cluster.
* **etcd** is a distributed key-value store used by Kubernetes to store all cluster data. It is responsible for reliably storing the configuration data required to define the desired state of the cluster.
* **controller**  is a daemon that embeds the core control loops shipped with Kubernetes. It watches the shared state of the cluster through the API server and makes changes to move the current state towards the desired state.
* **scheduler** is responsible for distributing work or containers across the nodes in the cluster. It watches for newly created Pods with no assigned node, and selects a node for them to run on.
* **container runtime** is the software that is responsible for running containers. Kubernetes supports several container runtimes, such as Docker, containerd, and CRI-O.
* **kubelet** is the primary "node agent" that runs on each node. It watches for Pods that have been assigned to its node, and ensures that the containers in those Pods are healthy and running.
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
* **kubectl run <name> --image=<image> [options]** create and run a particular Docker image in a Kubernetes pod. `<name>` is the name you want to assign to the pod.
* **kubectl get pods** list of all pods in the current namespace.   or **kubectl get pods -o wide**   To get more detailed information about the pods
******************************

# YAML files for POD
* Exmample YAML file. Note that container is a list since many containers can be run on single pod. 
******************************
apiVersion: apps/v1
kind: Deployment
metadata:
  name: example-deployment
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
        image: example-image
        ports:
        - containerPort: 8080
******************************


