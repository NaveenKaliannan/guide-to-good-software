# [Docker]()

##  Docker, Virtual Machine and host machine.
******************************
1. **Host computer or local machine** controls all the program and file.  It has an Operating System (OS), which has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc.  The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.
2. **Virtual Machine** virtualize OS kernel and application layer. The VM is built on hypervisor, which controls the hardware.
3. **Docker** virualizae application layer and borrows the OS kernel from host machine. Docker occupys less space compared to VM becuase it doesnt virtualize OS kernel. The other advantages are: Faster boot time, Easy to scale up, Reproduciability, compatability/dependenceies, no need to set up environment, Developer and tester can run the same code and get the same results even thought the machines are different. The application that we build we will always have same dependencies and easy to ship the application. With docker, each component or application can be run with specific dependecies/librarie with seperate container. The goal of the docker is to package an application, containerize the application and ship them  and run anytime/anywhere. Docker is to run a specific tasks, once the tasks is completed, the container exists but always lives until removed **docker rm container-id**. 
******************************

## Docker Installation 
******************************
* Docker Community Edition (public) and Enterprise Edition (industries and images are verfified).
* **Linux installation** : https://docs.docker.com/engine/install/ubuntu/
* **Debian installation** : https://docs.docker.com/engine/install/debian/
* The command **sudo systemctl enable docker** enables the Docker service to start automatically when the system boots up
* **Necessary permissions to access the Docker daemon socket file (/var/run/docker.sock). By default, the Docker socket file is owned by the "root" user and the "docker" group. when Docker is installed, it typically creates a group called "docker" if it doesn't already exist. This group is used to manage access control to the Docker daemon and related resources, such as the Docker socket file (/var/run/docker.sock). It is a Unix domain socket (UDS) fule used for inter-process communication (IPC) between the Docker client and Docker daemon. Mounting this socket inside containers grants them privileged access to the host's Docker daemon**
  1. **sudo groupadd docker** Create the "docker" group if it doesn't exist
  2. **sudo usermod -aG docker $USER** Add your user account to the "docker" group. Log out and log back in for the group changes to take effect.
  3. **sudo systemctl restart docker**
  4. Check the ownership and permissions of the Docker socket file **sudo ls -l /var/run/docker.sock**. The socket file should be owned by the "root" user and the "docker" group. If not, you can change the ownership: **sudo chown root:docker /var/run/docker.sock**
- Verify that the Docker daemon is running: **sudo systemctl status docker**

* **docker-compose installation**
   1. sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
   2. sudo chmod +x /usr/local/bin/docker-compose
   3. docker-compose --version

* **docker info** displays all the information about docker installation, configuration and networking.
* **docker system prune** prune the entire Docker system and remove all unused containers, images, networks, and volumes.  **-fa** are force and all flag.
* The number of containers that can be run depends on the available resources (CPU, memory, etc.) on the host machine.
The main factors that determine the maximum number of containers on a host are: Available memory on the host, CPU resources of the host, Kernel resources like cgroups, namespaces, etc. As you run more containers, they consume more of the host's memory, CPU cycles, and kernel resources. Once these resources are exhausted, you won't be able to run additional containers.
* **To configure Docker to use IPv6 networking**, you need to follow these steps:Enable IPv6 Support in Docker, Create or edit the Docker daemon configuration file **/etc/docker/daemon.json**. Add the following configuration options:
```json
{
  "ipv6": true,
  "fixed-cidr-v6": "2001:db8:1::/64"
}
```
The ipv6 option enables IPv6 support, and fixed-cidr-v6 specifies the IPv6 subnet to be used for the default bridge network. Replace 2001:db8:1::/64 with your desired IPv6 subnet.\
Save the file and restart the Docker daemon for the changes to take effect. Create an IPv6 Network. After enabling IPv6 support, you can create an IPv6 network using the docker network create command with the --ipv6 flag: **docker network create --ipv6 --subnet=<ipv6-subnet> <network-name>**  Replace <ipv6-subnet> with your desired IPv6 subnet (e.g., 2001:db8:2::/64) and <network-name> with the name of your new network. Run Containers with IPv6 Addressing When running containers, you can specify the --ip6 flag to assign an IPv6 address from the configured subnet, or use the --network flag to attach the container to the IPv6-enabled network you created: **docker run --ip6=2001:db8:2::10 --name my-ipv6-container my-image** or **docker run --network=my-ipv6-network --name my-ipv6-container my-image**. This will allow the container to communicate using IPv6 addresses. Enable IPv6 Forwarding (Optional) If you want containers to communicate with the outside world using IPv6, you need to enable IPv6 forwarding on the Docker host: **sysctl net.ipv6.conf.all.forwarding=1**. You may also need to configure iptables rules to allow forwarding.  By following these steps, you can enable IPv6 support in Docker and create IPv6-enabled networks for your containers to use IPv6 addressing and communication
* Docker daemon logs using the following command: **sudo journalctl -u docker** or **grep -i docker /var/syslog** offers the issue in daemon's operation, whereas logs for a specific Docker container **docker logs <container_name_or_id>** for contaiener level logs
* **hostname -I** specifically displays the IP address(es) of our system. **netstat -r** or **route -n** show the "Gateway" IP address, which is the router's IP address. **ip route** find the router's IP address. Note that the 192.168.0.1 IP address is commonly used as the default gateway or router IP address within this 192.168.0.0/24 subnet. The 192.168.0.0 address is the network address, and 192.168.0.255 is the broadcast address. 192.168.0.1 and 192.168.0.255 are reserved. **broadcast address** is primarily used to send data, messages, and requests to all devices connected to a local network or subnet, enabling communication and discovery without needing to know individual IP addresses.  **default gateway or router IP** is for intercommunication that communicating to outside world.
* **docker system info** command provides a comprehensive overview of your Docker environment. You can also format the output using a custom template: **docker info --format '{{json .}}'** This will print the information in JSON format.
******************************

### Docker Terminology 
******************************
1. **Docker Client** is the primary way users interact with Docker. It accepts commands and configuration data from the user and communicates with the Docker daemon to execute those commands.
2. **Docker Daemon** (dockerd) is a long-running program that manages Docker objects like images, containers, networks, and storage volumes. It listens for Docker API requests and processes them accordingly.
3. **Docker Engine** is a software that creates and runs containers, as well as interacts with the host OS. When installing Docker on Linux, you are essentially installing:
Docker CLI (command line interface, user interface)
Docker API (for communication between the Docker client and the Docker daemon)
Docker Daemon (a background process that processes commands from the Docker client, and manages images, containers, volumes, and networks)
The Docker CLI can be installed on a different machine or host and can be connected to a remote Docker Engine using the -H or --host flag, like docker -H=remote-docker-engine:port command. This allows you to manage a remote Docker Engine from a different machine.\
* The differece among them:\
  **Docker Client**
The Docker client is the primary way users interact with Docker. It is a command-line interface (CLI) tool that sends commands and configuration data to the Docker daemon. The Docker client communicates with the Docker daemon through a REST API, either over a UNIX socket or a network interface.\
  **Docker Daemon**
The Docker daemon (dockerd) is a long-running process that manages Docker objects such as images, containers, networks, and volumes. It listens for Docker API requests from the Docker client and processes them accordingly. The Docker daemon is responsible for the heavy lifting of building, running, and distributing Docker containers.\
  **Docker Engine**
Docker Engine is the core technology that enables containerization. It consists of both the Docker daemon and the Docker client, along with other components like the Docker API, Docker Compose, and Docker Hub.\
  **In summary**\
The Docker client is the CLI tool that users interact with to issue commands to Docker.\
The Docker daemon is the server-side process that manages and executes Docker operations.\
The Docker Engine is the overall containerization technology that includes the Docker daemon, Docker client, and other components.\
So, while the Docker client and Docker daemon are separate components, they are both part of the broader Docker Engine platform. The Docker client communicates with the Docker daemon, which in turn manages and orchestrates the Docker containers and other resources
4. **Docker image** is read only templates and contains all dependencies and information to build and run a docker container. In simpler words, it is just a package and is made up of different layers (a parent layer and many chid derived layers).
5. **Docker container** is a runtime instance of a Docker image and an isolated environment, has own processes, interfaces, mounts. It can be realized via **docker run docker-image-name**. Docker container doesnt have the OS within it. It borrows the OS from the host machine and share the host kernel with other containers. In the case of VM, each VM has its own OS. Containers are portable. Docker uses Linux containers (LXC). Note that the windows based docker container cannot be run on linux OS.
6. **Docker registry** is cloud where all the docker images are stored. The docker reistry is quite similar to the github where the website/useraccount/reposityname is used to pull repository. For private docker registry, **docker login registry.io** needs to be performed, and then run  **docker run registry.io/useraccount/dockercontainername** . Note that the docker registry is an another application and it is a docker image, exposes API on port 5000. docker access structure dockerregistry/username/imagereposityname. Dockerhub (docker.io) is default registry and it is public
7. However, new **Docker image** can also be created from a running container. It can be created via **docker run -it <image_name> /bin/bash**, **docker commit <container_id> <new_image_name>**
8. **Docker host** is a server or machine in which docker runs.
9. **namespace** the namespace PID of a process inside a Docker container can be determined by looking at the /proc/<pid>/status file on the host, where <pid> is the global PID of the container process. This mapping between namespace and global PIDs is an important concept for understanding how Docker containers isolate their processes. Processes running inside a Docker container have their PIDs isolated within the container's namespace. This means the PID of a process inside the container may be different from its PID on the host.
To find the mapping between the namespace PID and the global PID on the host, you can look at the /proc/<pid>/status file on the host. The NSpid line will show the namespace PID. 
For example, if you have a sleep 900 process running in a Docker container, you can find its namespace PID by looking at the NSpid line in the /proc/<pid>/status file on the host, where <pid> is the global PID of the Docker container process. 
This allows you to debug processes inside the container using tools only available on the host, like strace, by mapping the namespace PID to the global PID. 
The docker inspect --format '{{.State.Pid}}' container command can also be used to get the global PID of the container process on the host. 
Linux namespaces, including the PID namespace, are a key feature that allows Docker containers to isolate their processes from the host and each other.
**Mount (mnt) namespace: Provides the container with an isolated view of the filesystem, ensuring processes don't interfere with files belonging to other processes on the host. The container's root filesystem is typically mounted from the /var/lib/docker/ directory on the host. Network (net) namespace: Provides the container with an isolated view of the network stack, including network interfaces, routing tables, and iptables rules. Containers can share the network namespace of other containers, allowing them to communicate with each other.  Process ID (pid) namespace: How process ID is assigned. PID in linux and PID in containers are different and has own IDs.** 
11. **Docker client** mainly allows user to interact with Docker. Any Docker command that is run on the terminal, is sent to the Docker daemon via Docker API.
12. **Accessing the application** via port numbers and IP address. Each container has unique internal IP address and host number by default. Docker host contains an ip address and various port numbers. Via browser, use the docker host ip address and specific port number, one can access the application. Before this, one has to map the free port of docker host to the container port via **-p dockerhostportnumner:containerportnumber**
13. **Storing the data in docker host rather than docker container** can be achieved using the **-v */opt/datadir:/var/lib/mysql*, meaningfully **-v dockerhostvolume:dockercontainervolume**
14. **docker port mapping** Accessing Container Services: By mapping a host port to a container port, you can access services running inside the container from the host machine. For example, if you have a web server running on port 80 in the container, you can access it by connecting to localhost:80 on the host
15. Docker uses control group to manage the resources. **Cgroups (Control Groups)** in Linux are a kernel feature that allows you to allocate, limit, and prioritize system resources like CPU, memory, disk I/O, and network bandwidth among process groups. Cgroups provide a way to organize processes into hierarchical groups and manage the resources allocated to each group. Cgroups are typically accessed through the cgroup virtual filesystem (/sys/fs/cgroup). Tools like systemd, Docker, and Kubernetes leverage cgroups to manage resource allocation for services, containers, and pods One can leverage cgroups to set CPU and memory constraints for Docker containers directly in the Dockerfile itself. The limits help ensure the container doesn't monopolize resources on the host. `cat /proc/self/cgroup` list the cgroups for the current process. `ls /sys/fs/cgroup/` view the cgroup hierarchy on the cgroup filesystem. `sudo mkdir /sys/fs/cgroup/cpu/my_cgroup` create a new cgroup under the cpu subsystem
```dockerfile
FROM ubuntu:20.04

# Set CPU limits
# --cpus - Number of CPUs (fractional values are permitted, e.g. 0.5)
# --cpuset-cpus - CPUs to use (0-3, 0,1)
CMD ["--cpus=0.5", "--cpuset-cpus=0,1"]

# Set memory limits 
# -m - Memory limit (format: <number>[<unit>])
CMD ["--memory=512m"]

# Start a CPU stress process to test limits
CMD ["stress", "--cpu", "2", "--vm-bytes", "256M", "--vm-hang", "0"]
```  
16. **detached container** in Docker refers to a container that is running in the background, without being attached to the terminal or console from which it was started.
17. **.dockerignore**  file that excludes the files and folder.
18. **Dangling Images**: The old image doesn't get deleted immediately. Instead, it becomes a dangling image because it no longer has a tag associated with it. Docker keeps these dangling images in case they are still in use by other containers  
******************************

## Docker commands 

### Docker Image house keeping and running
******************************
* **docker search <image-name>** searches for image.
* **docker image ls** lists all the docker images in local machine
* **docker pull software-name:version** pulls the docker image of the software for the given version Example python:latest
* **docker rmi -f hello-world** removes the docker images forcefully (**-f**). **docker images | sed '1d' | awk '{print $3}' | xargs docker rmi** deletes all the images. 
* **docker image rm -f IMAGEID** remove the docker images forcefully (**-f**)
* **docker images | sed '1d' | awk '{print {$1}} | xargs docker rmi -f'** removes all the images.
* **docker build . -t dockerimagename**
* **docker build -f dockerfile.prod**
* **docker inspect imagename** returns all the information about docker runs including volume, state information, network information, metadata.
* **doceker push** to push the image to docker cloud or local registry.
* **docker run -d -p 5000:5000 -name my-registry --restart=always registry:2** Runs a registry server with name equals to my-registry using registry:2 image with host port set to 5000, and restart policy set to always. The --restart=always option in Docker instructs the container to automatically restart whenever it stops, including when the host system is rebooted or restarted. **no (default)**: Do not automatically restart the container. **on-failure**: Restart the container if it exits due to an error. **unless-stopped**: Restart the container unless it was explicitly stopped. **always**: Always restart the container regardless of the exit status.
* **docker image tag nginx:latest localhost:5000/nginx:latest** tags the image with a target name. **docker push localhost:5000/nginx:latest** pushes the target image to registry.
* **docker image history imagename** provides the information of image
* **docker export imageid  > export.tar** exports the docker container. **cat export.tar | docker import - layer:1** imports the imageid.
* **Reducing the image size** can be done by replacing the **apk install** with **apk add**. In addition, reducing instructions, optimized libraries, and etc.
* **Multi stage image build** several images are build on single dockerfile. Each images depend on one another. To create a multi-stage build in Docker, you need to follow these steps:
1. Define multiple FROM statements in your Dockerfile, each representing a different stage of the build process.\
2. Give each stage a name using the AS <stage-name> syntax after the FROM statement.\
3. Use the COPY --from=<stage-name> instruction to copy files or artifacts from one stage to another.\
4. In the final stage, copy only the necessary files or binaries needed to run the application, leaving behind the build dependencies.\
The key benefit of using multi-stage builds is that it helps reduce the final Docker image size. By copying only the necessary artifacts to the final stage, you can significantly reduce the size of the image, making it more efficient to distribute and deploy.
This technique also improves the security of the final image, as it contains only the required dependencies, reducing the attack surface and potential vulnerabilities.
Overall, multi-stage builds in Docker provide a way to optimize the build process and create smaller, more secure Docker images.
* **tags** are used for versioning, testing purposes
* There are a few ways to force a rebuild of a Docker image when the Dockerfile has been updated: Use the docker build command with the --no-cache option: **docker build --no-cache -t my-image .**, **docker-compose build --no-cache my-service**,
* **docker save <IMAGE_NAME>:<TAG> | gzip > <FILE_NAME>.tar.gz** or **docker save <IMAGE_NAME>:<TAG> > <FILE_NAME>.tar** you can combine the docker save and compression steps into a single command using a pipe (|).

 ******************************

### Container house keeping and running commands
******************************
* **docker ps** or **docker ps -a** lists the running containers or **-a** the records of running containers and previous runs. It displays container IDs, status, ports and etc.
* **docker run software-name** takes a default (latest tag or version) docker image and creates a new container, run the container. 
* **docker run software-name:version** takes a docker image and creates a new container, run the container. Version is also called as tag.
* **docker run -it software-name:version** runs the container in both interactive and terminal modes. **-it** allows one to login to the container.
* **docker run -p dockerhostportnumber:dockercotainerportnumber software-name:version** runs the container in specified ports.
* **docker run -d software-name** runs the container in background. To bring it to the front end, **docker attach ContainerID**
* **docker run -d -v hostvolume:dockervolume --name containername -e enviornmentalvariable=value -p hostportnumber:containerportnumber  imagename**
* **docker run --link source_container:alias runningcontainer** links the "example" container to the running container, and the running container would be able to access the "example" container using the alias "examplealias. Link is depreceed. But network allows one container to access another.
* **docker run imagename cat /etc/*release*** gives the base image.
* **docker run -e ENVIRONMENTAL_VARIABLE=input imagename** passes the environmental variable. The variable name can be **docker inspect containerID | grep "environmental variable"**
* **docker run --name containername -e enviornmentalvariable=value -p hostportnumber:containerportnumber  imagename** 
* **docker start container-ID** 
* **docker stop containerName** stops the running containers
* **docker rm containerID** removes the docker container.
* **docker ps | sed '1d' | awk '{print {$1}}' | xargs docker rm** removes all the running containers. 
* **docker logs container-ID**
* **docker exec** executes a command on the running container, whereas **docker run** just creates a container, runs it and stop when done.
* **docker exec container-ID cat /etc/hosts** shows the contents of /etc/hosts file.
* **docker exec -it container-ID /bin/bash** shows the virutal file system inside a container
* **docker exec containerID ps -eaf** to see the PIDs in container. **top** or **ps -eaf | grep "containername"** to see the PIDs in the linux. With namespace, multuple processes IDs are given to same process IDs.
* **docker run -d --name mycontainer --memory="512m" --cpus=1 myimage** limits both memory and CPU usage
* **docker kill** command sends the SIGKILL signal to a running container, forcibly terminating it without any chance for cleanup.
* **docker run** creates a new container, starts it, and attaches the console to the container's main process. **docker create** creates a new container but does not start it. The container remains in a "created" state until you start it manually using **docker start**.
* The best way to find a Docker container with the exact name "containername" is to use the **docker ps --filter "name=containername**
* Debugging a container to use **docker exec** command.
* Enter and conencting to containers
  1. **docker run -it --name containername imagename /bin/bash** bash shell prompt of container
  2. **docker run -it containerid /bin/bash** shell prompt of container for already pulled image and created container. 
  3. **docker exec -it containerid /bin/bash** inside the container
* **docker stats <CONTAINER_ID_OR_NAME> [<CONTAINER_ID_OR_NAME>...]** Output Explained
```textfile
 CONTAINER ID and NAME: The ID and name of the container.
CPU %: The percentage of the host's CPU resources utilized by the container.
MEM USAGE / LIMIT: The total memory the container is using, and the total amount it's allowed to use.
MEM %: The percentage of the host's memory utilized by the container.
NET I/O: The amount of data the container has received and sent over its network interface.
BLOCK I/O: The amount of data the container has written to and read from block devices on the host.
PIDS: The number of processes or threads the container has created.
```
* **docker rename <CURRENT_NAME> <NEW_NAME>** rename a container
******************************

### Docker storage and File systems
******************************
when docker is installed the directory **/var/lib/docker** gets created. It contains **aufs, image, container, volumes, plugins and etc**. The cache data available in docker staorage is used to create all the layers in docker build. aufs folder stores the information about the docker image and container layers.

Image layer is always read only. Contaienr only is read and write. 

* **docker volume create mydata** creates a folder in data. mydata folder is inside  /var/lib/docker/volumes. all the data generated from docker run will stored in this folder rather than the default folder created by docker contaienr name. The data will be available even when the container is deleted. Docker volumes are the recommended option for persisting data in Docker containers, as they are managed by Docker and provide better performance. **docker volume create testvolume** **docker volume ls**, **docker volume inspect** shows the mountpoint, **docker volume rm testvolume**
* Bind mounts  **docker run -v /home/naveenk/mydata:/var/lib/mysql mysql** or **docker run --mount type==bind,source=/home/naveenk/mydata,target=/var/lib/mysql mysql**  offer more flexibility by allowing you to directly access the host's filesystem. Mount option by creating **docker volume create testvolume**,  **docker run --mount type==bind,source=testvolume,target=/var/lib/mysql mysql**
* **docker run -v mydata:/var/lib/mysql mysql** stores all the data in mydata folder.
* **docker system df** or **docker system df -v** to see the memory used by images inside docker
* Docker provides three main types of mounts for managing data in containers: volumes, bind mounts, and tmpfs mounts. 
  1. Volumes are the recommended way to persist data in Docker. They are managed by Docker and are stored in a part of the host filesystem (/var/lib/docker/volumes/ on Linux) that is designed to be managed by Docker.
```bash
# Create a volume
docker volume create my-vol

# Start a container with a volume mounted
docker run -d --name devtest -v my-vol:/app nginx:latest
```
 2. Bind Mounts allow you to mount a directory or file from the host machine into the container's filesystem. They rely on the host machine's filesystem structure.
```bash 
# Start a container with a bind mount or "$(pwd)"/data
docker run -d --name devtest -v /path/on/host:/app nginx:latest
```
  3. tmpfs Mounts are stored in the host system's memory only, inside the container and are never written to the host system's filesystem. They are used for storing non-persistent, temporary data or sensitive information.
```bash 
# Start a container with a tmpfs mount
docker run -d --name devtest --tmpfs /app nginx:latest
```
* Docker container can be connected to multiple volumes at the same time. Here are a few examples
```bash
bash
docker run -d --name mycontainer \
  -v volume1:/path/in/container \
  -v volume2:/another/path \
  -v /host/path:/third/path \
  nginx
```
```yaml
version: '3'
services:
  myservice:
    image: nginx
    volumes:
      - volume1:/path/in/container
      - volume2:/another/path
      - /host/path:/third/path
volumes:
  volume1:
  volume2:
```
* Note that A **Docker secret mount** is a way to securely pass sensitive data like passwords, API keys, or SSH keys to a Docker container during the build process, without exposing them in the final Docker image. Note : Secrets mounted using --mount=type=secret in a Dockerfile are only available during the build process and are not persisted in the final image. This is especially important when building images that may contain private repositories, API keys, or other sensitive data.
  
1. Case 1 : Mounting Secrets During the Build Process in a Dockerfile
**With secret mount**   `docker build --secret id=privatekey,src=key/withoutpassphrase/id_rsa -t my-app -f Dockerfile_netrc .` and `docker run -it my-app /bin/bash`
```dockerfile
# Specify the base image for your project
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Install required packages
RUN apt-get update && \
    apt-get install -y git openssh-client

# Add the remote server's host key to the known_hosts file
RUN mkdir -p /root/.ssh
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Mount the private SSH key as a secret
#COPY key/withoutpassphrase/id_rsa /root/.ssh/id_rsa
RUN --mount=type=secret,id=privatekey,dst=/root/.ssh/id_rsa true

# Clone the repository
RUN --mount=type=secret,id=privatekey,dst=/root/.ssh/id_rsa true && \
    git clone git@github.com:gitusername/practice-purpose.git /app/ && \
    echo '# Your code changes go here' >> README.md && \
    git config --global user.email 'emailaddress' && \
    git config --global user.name 'gitusername' && \
    git add . && \
    git commit -m 'Updated code via Docker container' && \
    git push origin master

# Command to keep the container running
CMD ["sh", "-c", "sleep 100s"]
```
**Without secret mount** `docker build --secret id=privatekey,src=key/withoutpassphrase/id_rsa -t my-app -f Dockerfile_netrc .` and `docker run -it my-app /bin/bash`
```dockerfile
# Specify the base image for your project
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Install required packages
RUN apt-get update && \
    apt-get install -y git openssh-client

# Add the remote server's host key to the known_hosts file
RUN mkdir -p /root/.ssh
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Mount the private SSH key as a secret
COPY key/withoutpassphrase/id_rsa /root/.ssh/id_rsa
#RUN --mount=type=secret,id=privatekey,dst=/root/.ssh/id_rsa true

# Clone the repository
RUN --mount=type=secret,id=privatekey,dst=/root/.ssh/id_rsa true && \
    git clone git@github.com:gitusername/practice-purpose.git /app/ && \
    echo '# Your code changes go here' >> README.md && \
    git config --global user.email 'emailaddress' && \
    git config --global user.name 'gitusername' && \
    git add . && \
    git commit -m 'Updated code via Docker container' && \
    git push origin master

# Command to keep the container running
CMD ["sh", "-c", "sleep 100s"]
```
2. Case 2: Mounting Secrets with Docker Compose
```Dockerfile
version: '3.7'

networks:
  net:

secrets:
  key:
    file: key/withoutpassphrase/id_rsa

services:
  jenkins:
    container_name: jenkins
    image: jenkins/jenkins:lts
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - $PWD/jenkins:/var/jenkins_home
    networks:
      - net
    restart: unless-stopped

  remote_host:
    container_name: remote-host
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "2222:22"
    networks:
      - net
    restart: unless-stopped

  key_test:
    container_name: key_test
    build:
      context: .
      dockerfile: Dockerfile_key
      secrets: ## This secret is mounted only during the build process and will never be seen in docker container
        - source: key
          target: /root/.ssh/id_rsa
    secrets: ## This secret is mounted only during the docker run and it can be seen via docker exec command
      - source: key
        target: /root/.ssh/id_rsa
    networks:
      - net
    ports:
      - "3000:3000"
    restart: unless-stopped
```
**ssh mount type**  `RUN --mount=type=ssh,id=git-ssh \ git clone git@github.com:user/private-repo.git /app`, `docker build --ssh default=/path/to/ssh/socket -t myapp .` The --ssh default=/path/to/ssh/socket flag mounts the SSH socket located at /path/to/ssh/socket into the build container, allowing the Git clone operation to authenticate using the SSH keys loaded into the Docker engine. The SSH agent manages the keys on the host, not within Docker itself. The SSH socket provides a secure communication channel for Docker on the host to access the agent. Containers can leverage the host's SSH agent for authentication during the build process, but don't store the keys themselves.
* **Add SSH Key to Docker Engine:** `docker-credential-helper-ssh add ~/.ssh/id_rsa  # Replace with your private key path`
* **Find SSH Socket Path:** `docker info`
```Dockerfile
FROM python:3.9

RUN apt-get update && apt-get install -y git

# Mount SSH agent for authentication
RUN --mount=type=ssh,id=ssh-agent \
    git clone git@github.com:user/private-repo.git /app

WORKDIR /app
``` 
* **Build the Image:** `docker build --ssh default=/path/to/docker/ssh.sock -t my-python-app .  # Replace path with actual socket path`
**Cache Mounts**  Installs the packages example git here from the host machine (cache). not downloading from the cloud.  If Git is not installed on the host machine, the Dockerfile instructions that attempt to install Git within the Docker container will fail.

```Dockerfile
# Use the official Ubuntu image as the base
FROM ubuntu:latest

# Install Git
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . .

# Run the application (replace with your command)
CMD ["bash"]
```
**Configuration Mounts** Mounts a configuration file or directory from the host into the container to customize runtime configuration
******************************

### Docker networking
******************************
when docker is installed, bridge, none and host networks are created. Bridge is the default network a container attached.
* **bridge** network is achieved by default when **docker run containername** is executed. It is a private network, and series is around in the series 172.17.. Containers can access all the ips of container inside the docker host.
* **none** network is achieved when specifing **docker run containername --network==none** is executed. Not attached to any network and not accessible to outside world. 
* **host** network is achieved when specifing **docker run containername --network==host** is executed. The containers can accessed externally via host network, without port mapping. Hence, the ports are common to all the containers.
* **Macvlan Network**  A macvlan network assigns a unique MAC address to each container, making them appear as physical devices on the host's network. This allows containers to bypass the host's routing and directly communicate with the physical network. Useful when you need your containers to look like physical hosts on the network. Requires support from the underlying host's networking configuration. Create a macvlan network `docker network create -d macvlan --subnet 192.168.1.0/24 --gateway 192.168.1.1 -o parent=eth0 pub_net`. Run a container in the macvlan network `docker run --rm --net pub_net alpine`
```dockerfile
# Use the latest Alpine image
FROM alpine:latest

# Install iproute2 package
RUN apk add --no-cache iproute2

# Run a command to inspect network interfaces
CMD ["ip", "addr"]
```
* An **overlay network** is a software-defined network that allows containers to communicate across different Docker hosts as if they were on the same network. This network spans multiple Docker daemons (hosts) and is managed by Docker Swarm, enabling seamless communication between containers. Create an overlay network `docker network create --driver overlay nginx-net` Deploy a replicated Nginx service across Swarm nodes `docker service create --name nginx --network nginx-net --replicas 2 nginx`
```dockerfile
# Use the official Nginx image
FROM nginx:latest

# Copy custom HTML
COPY index.html /usr/share/nginx/html/index.html
```
* **docker network create --driver bridge --subnet ipaddress custom-isolated-network** creates own bridge network.
*  **docker network ls** lists all the network 
*  **docker inspect containername or imagename**
*  **docker network inspect bridge**
*  The Docker subnet and gateway are used for internal container networking within the Docker environment. When a Docker network is created, the Docker daemon automatically assigns an IP subnet and gateway for that network. The default subnet used by Docker is typically 172.17.0.0/16, which provides 65,534 usable IP addresses for containers. The gateway IP address is also automatically assigned by Docker, usually 172.17.0.1, and serves as the default gateway for containers on that network. This subnet and gateway are used for communication between containers on the same Docker network. Containers can communicate with each other using their assigned IP addresses or container names. The subnet and gateway are part of the internal Docker networking setup and are not directly accessible from the host machine or external networks. They are used solely for container-to-container communication within the Docker environment. The subnet is a range of IP addresses that Docker assigns to the containers on a network, while the gateway is the IP address of the virtual router that provides connectivity between the containers and the external network. The subnet is specified using CIDR notation, such as 172.28.0.0/16, which represents the range of IP addresses from 172.28.0.0 to 172.28.255.255. The gateway is a single IP address within that subnet, typically the first address (e.g., 172.28.0.1).
*  **docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network** creates a new isolated network named wp-mysql-network using the bridge driver, with a subnet of 182.18.0.1/24 and a gateway of 182.18.0.1.
*  **docker inspect containerid | grep "NetworkMode"** displays the type of network used in the container.
*  **docker inspect networkid | grep "Subnet"** displays the subnet info. networkid can be obtained from **docker network ls**.
*  **docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 --network wp-mysql-network  mysql:5.6** creates a new container named mysql-db using the mysql:5.6 image, sets the MYSQL_ROOT_PASSWORD environment variable to db_pass123, and attaches the container to the wp-mysql-network network
*  **docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql** The docker run command creates a new container named webapp using the kodekloud/simple-webapp-mysql image, sets the DB_Host environment variable to mysql-db and the DB_Password environment variable to db_pass123, maps port 38080 on the host to port 8080 in the container, links the webapp container to the mysql-db container, and runs the container in detached mode (-d). The container is attached to the wp-mysql-network network, allowing it to communicate with the mysql-db container. **Note that the link option is depreceted and network is recommened to connect containers** : `docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp -d kodekloud/simple-webapp-mysql` and `docker run --network=wp-mysql-network --name mysql-db -d mysql-db:mysql-db` will fix the problem. 
* Connecting to multiple user-defined networks
```bash
# Create two user-defined networks
docker network create frontend
docker network create backend

# Run a container and connect it to both networks
docker run -d --name app --network frontend --network backend nginx
```
```yaml
version: '3'
services:
  web:
    networks:
      - frontend
      - backend
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
```
```yaml
yaml
version: '3'
services:
  web:
    networks:
      - frontend
      - bridge
networks:
  frontend:
    driver: bridge
```

******************************

### Working with private docker registry
The structure of docker reposity is as follows: **dockerregistry/username/imagereposityname**. Dockerhub (docker.io) is the default registry and it public. google registry is gcr.io
* **How to start a registry?** It can be achieved via the following command **docker run -d -p 5000:5000 --restart=always --name registry registry:2** Start a local Docker registry on port 5000
******************************
* **docker run -d -p 5000:5000 --restart=always --name registry registry:2** Start a local Docker registry on port 5000. 
* **docker pull ubuntu:latest** Pull the latest Ubuntu image from the default Docker Hub registry. 
* **docker image tag ubuntu:latest localhost:5000/gfg-image** Tag the Ubuntu image for the local registry.
* **docker image tag ubuntu:latest dockerregistry/username/imagereposityname** Tag the Ubuntu image for the cloud registry.  Example:  docker tag local-image gcr.io/my-project/my-image:v1
* **docker push localhost:5000/gfg-image** Push the tagged image to the local registry.
* **docker push dockerregistry/username/imagereposityname** Push the tagged image to the cloud registry. Example:  docker push gcr.io/my-project/my-image:v1
* **docker pull localhost:5000/gfg-image** Pull the image from the local registry. 
* **docker container stop registry** Stop the local Docker registry. 
******************************

### Important Docker Files You Should Know About
******************************
1. **Dockerfile** file handles single containers, while the **docker-compose.yaml** file handles multiple container applications
* Create a docker file with name **Dockerfile** and add all the necessary commands
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
copy the source code
```
* **docker build . -t dockerimagename** builds the image with given name. Note that the Dockerfile with commands should be available in the same folder where this commands get executed. 
* Difference between **ENTRYPOINT** and **CMD** in a Dockerfile is how they interact with the Docker run command.
* **EXPOSE** expose the port.
* **COPY** simply copies files or directories from the host machine to the Docker image. **ADD** has additional functionality beyond just copying - it can also download files from remote URLs and automatically extract compressed archives
* **RUN** executes when building the image. ENTRYPOINT and CMD gets executed when the container runs. Each RUN instruction creates a new layer. Connect all the RUN instructions via &&.
* **ENTRYPOINT** Defines the executable that will be run when the container starts. The **ENTRYPOINT** command cannot be overridden by the Docker run command. Any arguments passed to the Docker run command will be appended to the **ENTRYPOINT** command. The **ENTRYPOINT** command is the primary entry point for executing the container.
* **CMD** Defines the default command and/or parameters that will be used if no command is specified when starting the container. The **CMD** command can be completely overridden by providing arguments to the Docker run command. The **CMD** command is used as the default command when none is specified, but it can be overridden. If the Dockerfile contains multiple CMD instructions, **only the last one is used**. The CMD instruction can be overridden by providing a command and arguments when running the container.
2. **Dockerfile** is a text file that contains instruction to build the docker image.
```
FROM python:3.6-slim
COPY . /opt/
WORKDIR /opt
RUN pip install flask
EXPOSE 8080
ENTRYPOINT ["python", "pythonfile.py"]
```
* **Differences between CMD and ENTRYPOINT in Docker**
Example 1: Simple CMD
```Dockerfile
FROM ubuntu
CMD ["echo", "Hello, World!"]
```
Running the container:
```bash
docker run ubuntu-with-cmd
# Output: Hello, World!
```
* In this example, the CMD instruction sets the default command to be executed when the container runs. The docker run command doesn't need to specify any additional arguments.
```Dockerfile
FROM ubuntu
CMD ["echo", "Hello, World!"]
```
Running the container with a custom command:
```bash
docker run ubuntu-with-cmd /bin/bash
# Output: /bin/bash
```
In this case, the CMD instruction is overridden by the command provided in the docker run command.
```Dockerfile
FROM ubuntu
ENTRYPOINT ["echo"]
CMD ["Hello, World!"]
```
Running the container
```bash
docker run ubuntu-with-entrypoint
# Output: Hello, World!
```
* In this example, the ENTRYPOINT sets the default executable to be "echo", and the CMD provides the default arguments passed to the ENTRYPOINT.
```Dockerfile
FROM ubuntu
ENTRYPOINT ["echo"]
CMD ["Hello, World!"]
```
Running the container with a custom ENTRYPOINT:
```bash
docker run --entrypoint /bin/bash ubuntu-with-entrypoint
# Output: /bin/bash
```
In this case, the ENTRYPOINT is overridden by the --entrypoint flag in the docker run command.
* ENTRYPOINT and multiple CMD instructions
```Dockerfile
Dockerfile:
FROM ubuntu

ENTRYPOINT ["echo", "Hello"]
CMD ["World"]
CMD ["Abhinav"]
```
The ENTRYPOINT instruction sets the default executable command to be echo "Hello".\
The first CMD instruction sets the default argument to be "World".\
The second CMD instruction sets another default argument to be "Abhinav".\
When you build an image from this Dockerfile and run a container, the behavior will be as follows:\
```bash
 docker build -t entrypoint-cmd .
 docker run entrypoint-cmd
```
The second CMD instruction ["Abhinav"] is not executed because the CMD instructions are used to provide default arguments, and the first CMD argument was already used.
* Example
```dockerfile
FROM image
CMD ["command1", "command2"]
CMD ["command3", "command4"]
```
When you build an image from this Dockerfile and run a container using docker run image, only ["command3", "command4"] will be executed. To run multiple commands in a container, you can use one of the following approaches: Use the sh -c or bash -c command in the CMD instruction:
```dockerfile
FROM image
CMD ["sh", "-c", "command1; command2"]
```
3. **docker compose yaml file format**
Docker Compose will first read the configuration file, then build the images (if necessary), and finally run the containers based on the specified configuration.
In the Compose file, the key is the service name, and the value is the configuration for that service, which includes the image name, build instructions, ports, links (depreceted), and other settings.
The version field is a top-level element in the Compose file that specifies the version of the Compose file format being used.
The services field defines the different services (containers) that make up the application.
```yaml
version: '2'

services:

  containernameexample:
    image: imagename

  containername:
    build: ./exe
    image: imagename
    environment:
      USER:blau
      PASSWORD:blau
      VARIABLE:blau
    ports:
      - hostportnumber:containerportnumber
    depends_on:
      - containernameexample
```
without Docker- Every body has to install or compile all dependencies to run a source code in local environment. Artifacts with requirements.txt file
with Docker, No need for any installation. Has its own operating layer. No environemnt configuraion
Container is made up of images. The base is Linux Base image (Alpine or linux distributions). The top is application image.
4. **docker-compose.yml** for Jenkins installation
```yaml
version: '3'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - "/home/naveenk/learning/devops/jenkins/:/var/jenkins_home"
```
5. Limit cpu and memory
```yaml
version: '3'
services:
  myservice:
    image: myimage
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
```
6. Docker labels are key-value pairs that allow you to add metadata to Docker objects like images, containers, volumes, and networks. Labels are useful for organizing, identifying, and providing additional information about these objects. Here's how you can use Docker labels: Adding Labels to Docker Images You can add labels to your Docker images by using the LABEL instruction in your Dockerfile. For example:
```dockerfile
LABEL maintainer="john@example.com"
LABEL version="1.0"
LABEL description="This is my custom app"
```   
Viewing Labels
To view the labels of a Docker image, you can use the docker inspect command: **docker inspect <image_id> --format='{{json .ContainerConfig.Labels}}'**
Using Labels for Filtering : Labels can be used to filter Docker objects. For example, to list all containers with a specific label: **docker ps --filter="label=mylabel=myvalue"** and You can also filter based on the existence of a label key, regardless of its value: **docker ps --filter="label=mylabel"**
******************************
* **docker-compose up** command runs the docker compose yaml file. **-d** option to run it in brackground.
* **docker-compose -f docker-compose-LocalExecutor.yml up -d** is for running multiple container applications.  YAML file is used for configuration purposes.
* **docker-compose start, restart stop, down containerid** to stop and start, delete services.
* **create user, run them** `docker build -t my_ssh_container .` , `docker run -d -p 2222:22 --name ssh_container my_ssh_container`, `ssh naveen@localhost -p 2222 -i private-key` for host machine and `ssh naveen@containername` from a container
```Dockerfile
FROM ubuntu:latest

# Install SSH server and sudo
RUN apt-get update && apt-get install -y openssh-server sudo && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USER_NAME=naveen
ARG USER_PASSWORD="1234"
RUN useradd -m -s /bin/bash ${USER_NAME} && \
    echo "${USER_NAME}:${USER_PASSWORD}" | chpasswd && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up SSH
RUN mkdir /run/sshd && \
    mkdir /home/${USER_NAME}/.ssh && \
    chmod 700 /home/${USER_NAME}/.ssh
COPY key/remote-key.pub /home/${USER_NAME}/.ssh/authorized_keys
RUN chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.ssh && chmod 600 /home/${USER_NAME}/.ssh/authorized_keys

# Expose SSH port and start SSH server
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```
* **Multi container** Sets up a Jenkins controller and a remote host container. The Jenkins controller is configured to persist data using a volume and automatically restart if needed. The remote host is built using a Dockerfile and also automatically restarts if needed. Both containers are connected to the same network for communication. The Jenkins application provides the core functionality for automation and the Jenkins controller is the central "brain" that orchestrates the entire distributed build environment, including scheduling jobs, assigning agents, monitoring their state, and collecting results. 
```
version: '3'

networks:
  net:

services:
  jenkins:
    container_name: jenkins
    image: jenkins/jenkins:lts  # Use the latest LTS (Long-Term Support) version
    ports:
      - "8080:8080"
      - "50000:50000"  # Add this line to expose the Jenkins JNLP port
    volumes:
      - $PWD/jenkins:/var/jenkins_home
    networks:
      - net
    restart: unless-stopped  # Automatically restart the container if it stops
    depends_on:
      - remote_host    

  remote_host:
    container_name: remote-host
    build:
      context: ./  # Specify the correct path to the Dockerfile context
      dockerfile: Dockerfile  # Specify the name of the Dockerfile (if it's not 'Dockerfile')
    ports:
      - "2222:22"
    networks:
      - net
    restart: unless-stopped  # Automatically restart the container if it stops
```
* **Triangle like multi containers using multi networks**
```yaml
version: '3'

networks:
  network1:
    driver: bridge
  network2:
    driver: bridge

services:
  container1:
    image: nginx
    networks:
      - network1

  container2:
    image: nginx
    networks:
      - network1

  container3:
    image: nginx
    networks:
      - network1
      - network2
``` 

### orchestration
* kubernetes, docker swarm, container orchestration for running multiple containers and monitoring them.
