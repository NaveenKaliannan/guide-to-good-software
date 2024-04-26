# [Docker]()

##  Docker, Virtual Machine and host machine.
******************************
1. **Host computer or local machine** controls all the program and file.  It has an Operating System (OS), which has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc.  The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.
2. **Virtual Machine** virtualize OS kernel and application layer. The VM is built on hypervisor, which controls the hardware.
3. **Docker** virualizae application layer and borrows the OS kernel from host machine. Docker occupys less space compared to VM becuase it doesnt virtualize OS kernel. The other advantages are: Faster boot time, Easy to scale up, Reproduciability, compatability/dependenceies, no need to set up environment, Developer and tester can run the same code and get the same results even thought the machines are different. The application that we build we will always have same dependencies and easy to ship the application. With docker, each component or application can be run with specific dependecies/librarie with seperate container. The goal of the docker is to package an application, containerize the application and ship them  and run anytime/anywhere. Docker is to run a specific tasks, once the tasks is completed, the container exists but always lives until removed **docker rm container-id**. 
******************************

## Docker Installation 
******************************
* **Linux installation** : https://docs.docker.com/engine/install/ubuntu/
* **Debian installation** : https://docs.docker.com/engine/install/debian/
* The command **sudo systemctl enable docker** enables the Docker service to start automatically when the system boots up
* **Necessary permissions to access the Docker daemon socket file (/var/run/docker.sock). By default, the Docker socket file is owned by the "root" user and the "docker" group. when Docker is installed, it typically creates a group called "docker" if it doesn't already exist. This group is used to manage access control to the Docker daemon and related resources, such as the Docker socket file (/var/run/docker.sock).**
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
******************************

## Docker commands 

### Docker Image house keeping and running
******************************
* **docker image ls** lists all the docker images in local machine
* **docker pull software-name:version** pulls the docker image of the software for the given version Example python:latest
* **docker rmi -f hello-world** removes the docker images forcefully (**-f**). **docker images | sed '1d' | awk '{print $3}' | xargs docker rmi** deletes all the images. 
* **docker image rm -f IMAGEID** remove the docker images forcefully (**-f**)
* **docker images | sed '1d' | awk '{print {$1}} | xargs docker rmi -f'** removes all the images.
* **docker build . -t dockerimagename**
* **docker build -f dockerfile.prod**
* **docker inspect imagename** returns all the information about docker runs including volume, state information, network information, metadata.
* **doceker push** to push the image to docker cloud or local registry.
* **docker run -d -p 5000:5000 -name my-registry --restart=always registry:2** Runs a registry server with name equals to my-registry using registry:2 image with host port set to 5000, and restart policy set to always.
* **docker image tag nginx:latest localhost:5000/nginx:latest** tags the image with a target name. **docker push localhost:5000/nginx:latest** pushes the target image to registry.
* **docker image history imagename** provides the information of image
* **docker export imageid  > export.tar** exports the docker container. **cat export.tar | docker import - layer:1** imports the imageid.
* **Reducing the image size** can be done by replacing the **apk install** with **apk add**. In addition, reducing instructions, optimized libraries, and etc.
* **Multi stage image build** several images are build on single dockerfile. Each images depend on one another. 
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
* **docker run --link source_container:alias runningcontainer** links the "example" container to the running container, and the running container would be able to access the "example" container using the alias "examplealias
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
******************************

### Docker Terminology 
******************************
1. **Docker image** is read only templates and contains all dependencies and information to build and run a docker container. In simpler words, it is just a package.
3. **Docker container** is a runtime instance of a Docker image and an isolated environment, has own processes, interfaces, mounts. It can be realized via **docker run docker-image-name**. Docker container doesnt have the OS within it. It borrows the OS from the host machine and share the host kernel with other containers. In the case of VM, each VM has its own OS. Containers are portable. Docker uses Linux containers (LXC). Note that the windows based docker container cannot be run on linux OS.
4. **Docker compose**
5. **Docker registry** is cloud where all the docker images are stored. The docker reistry is quite similar to the github where the website/useraccount/reposityname is used to pull repository. For private docker registry, **docker login registry.io** needs to be performed, and then run  **docker run registry.io/useraccount/dockercontainername** . Note that the docker registry is an another application and it is a docker image, exposes API on port 5000. docker access structure dockerregistry/username/imagereposityname. Dockerhub (docker.io) is default registry and it is public
6. However, new **Docker image** can also be created from a running container. It can be created via **docker commit container-info**
7. **Docker host** is a server or machine in which docker runs.
8. **Docker Engine** is a software that creates and runs containers, as well as interacts with the host OS. When installing Docker on Linux, you are essentially installing:
Docker CLI (command line interface, user interface)
Docker API (for communication between the Docker client and the Docker daemon)
Docker Daemon (a background process that processes commands from the Docker client, and manages images, containers, volumes, and networks)
The Docker CLI can be installed on a different machine or host and can be connected to a remote Docker Engine using the -H or --host flag, like docker -H=remote-docker-engine:port command. This allows you to manage a remote Docker Engine from a different machine.
9. **namespace** the namespace PID of a process inside a Docker container can be determined by looking at the /proc/<pid>/status file on the host, where <pid> is the global PID of the container process. This mapping between namespace and global PIDs is an important concept for understanding how Docker containers isolate their processes. Processes running inside a Docker container have their PIDs isolated within the container's namespace. This means the PID of a process inside the container may be different from its PID on the host.
To find the mapping between the namespace PID and the global PID on the host, you can look at the /proc/<pid>/status file on the host. The NSpid line will show the namespace PID. 
For example, if you have a sleep 900 process running in a Docker container, you can find its namespace PID by looking at the NSpid line in the /proc/<pid>/status file on the host, where <pid> is the global PID of the Docker container process. 
This allows you to debug processes inside the container using tools only available on the host, like strace, by mapping the namespace PID to the global PID. 
The docker inspect --format '{{.State.Pid}}' container command can also be used to get the global PID of the container process on the host. 
Linux namespaces, including the PID namespace, are a key feature that allows Docker containers to isolate their processes from the host and each other.
10. How process ID is assigned. PID in linux and PID in containers are different and has own IDs.  
11. **Docker client** mainly allows user to interact with Docker. Any Docker command that is run on the terminal, is sent to the Docker daemon via Docker API.
12. **Accessing the application** via port numbers and IP address. Each container has unique internal IP address and host number by default. Docker host contains an ip address (192.186.1.5) and various port numbers. Via browser, use the docker host ip address and specific port number, one can access the application. Before this, one has to map the free port of docker host to the container port via **-p dockerhostportnumner:containerportnumber**
13. **Storing the data in docker host rather than docker container** can be achieved using the **-v */opt/datadir:/var/lib/mysql*, meaningfully **-v dockerhostvolume:dockercontainervolume**
14. **docker port mapping** Accessing Container Services: By mapping a host port to a container port, you can access services running inside the container from the host machine. For example, if you have a web server running on port 80 in the container, you can access it by connecting to localhost:80 on the host
15. Docker uses control group to manage the resources.
******************************

### Docker storage and File systems
******************************
when docker is installed the directory **/var/lib/docker** gets created. It contains **aufs, image, container, volumes, plugins and etc**. The cache data available in docker staorage is used to create all the layers in docker build. aufs folder stores the information about the docker image and container layers.

Image layer is always read only. Contaienr only is read and write. 

* **docker volume create mydata** creates a folder in data. mydata folder is inside  /var/lib/docker/volumes. all the data generated from docker run will stored in this folder rather than the default folder created by docker contaienr name. The data will be available even when the container is deleted. Docker volumes are the recommended option for persisting data in Docker containers, as they are managed by Docker and provide better performance.
* Bind mounts  **docker run -v /home/naveenk/mydata:/var/lib/mysql mysql** or **docker run --mount type==bind,source=/home/naveenk/mydata,target=/var/lib/mysql mysql**  offer more flexibility by allowing you to directly access the host's filesystem 
* **docker run -v mydata:/var/lib/mysql mysql** stores all the data in mydata folder.
* **docker system df** or **docker system df -v** to see the memory used by images inside docker
******************************

### Docker networking
******************************
when docker is installed, bridge, none and host networks are created. Bridge is the default network a container attached.
* **bridge** network is achieved by default when **docker run containername** is executed. It is a private network, and series is around in the series 172.17.. Containers can access all the ips of container inside the docker host.
* **none** network is achieved when specifing **docker run containername --network==none** is executed. Not attached to any network and not accessible to outside world. 
* **host** network is achieved when specifing **docker run containername --network==host** is executed. The containers can accessed externally via host network, without port mapping. Hence, the ports are common to all the containers.
* **docker network create --driver bridge --subnet ipaddress custom-isolated-network** creates own bridge network.
*  **docker network ls** lists all the network 
*  **docker inspect containername or imagename**
*  **docker network inspect bridge**
*  The Docker subnet and gateway are used for internal container networking within the Docker environment. When a Docker network is created, the Docker daemon automatically assigns an IP subnet and gateway for that network. The default subnet used by Docker is typically 172.17.0.0/16, which provides 65,534 usable IP addresses for containers. The gateway IP address is also automatically assigned by Docker, usually 172.17.0.1, and serves as the default gateway for containers on that network. This subnet and gateway are used for communication between containers on the same Docker network. Containers can communicate with each other using their assigned IP addresses or container names. The subnet and gateway are part of the internal Docker networking setup and are not directly accessible from the host machine or external networks. They are used solely for container-to-container communication within the Docker environment. The subnet is a range of IP addresses that Docker assigns to the containers on a network, while the gateway is the IP address of the virtual router that provides connectivity between the containers and the external network. The subnet is specified using CIDR notation, such as 172.28.0.0/16, which represents the range of IP addresses from 172.28.0.0 to 172.28.255.255. The gateway is a single IP address within that subnet, typically the first address (e.g., 172.28.0.1).
*  **docker network create --driver bridge --subnet 182.18.0.1/24 --gateway 182.18.0.1 wp-mysql-network** creates a new isolated network named wp-mysql-network using the bridge driver, with a subnet of 182.18.0.1/24 and a gateway of 182.18.0.1.
*  **docker inspect containerid | grep "NetworkMode"** displays the type of network used in the container.
*  **docker inspect networkid | grep "Subnet"** displays the subnet info. networkid can be obtained from **docker network ls**.
*  **docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=db_pass123 --network wp-mysql-network  mysql:5.6** creates a new container named mysql-db using the mysql:5.6 image, sets the MYSQL_ROOT_PASSWORD environment variable to db_pass123, and attaches the container to the wp-mysql-network network
*  **docker run --network=wp-mysql-network -e DB_Host=mysql-db -e DB_Password=db_pass123 -p 38080:8080 --name webapp --link mysql-db:mysql-db -d kodekloud/simple-webapp-mysql** The docker run command creates a new container named webapp using the kodekloud/simple-webapp-mysql image, sets the DB_Host environment variable to mysql-db and the DB_Password environment variable to db_pass123, maps port 38080 on the host to port 8080 in the container, links the webapp container to the mysql-db container, and runs the container in detached mode (-d). The container is attached to the wp-mysql-network network, allowing it to communicate with the mysql-db container.
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
* **CMD** Defines the default command and/or parameters that will be used if no command is specified when starting the container. The **CMD** command can be completely overridden by providing arguments to the Docker run command. The **CMD** command is used as the default command when none is specified, but it can be overridden.
2. **Dockerfile** is a text file that contains instruction to build the docker image.
```
FROM python:3.6-slim
COPY . /opt/
WORKDIR /opt
RUN pip install flask
EXPOSE 8080
ENTRYPOINT ["python", "pythonfile.py"]
```
3. **docker compose yaml file format**
Docker Compose will first read the configuration file, then build the images (if necessary), and finally run the containers based on the specified configuration.
In the Compose file, the key is the service name, and the value is the configuration for that service, which includes the image name, build instructions, ports, links, and other settings.
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
******************************
* **docker-compose up** command runs the docker compose yaml file. **-d** option to run it in brackground.
* **docker-compose -f docker-compose-LocalExecutor.yml up -d** is for running multiple container applications.  YAML file is used for configuration purposes.
* **docker-compose start, restart stop, down containerid** to stop and start, delete services.


### orchestration
* kubernetes, docker swarm, container orchestration for running multiple containers and monitoring them.
