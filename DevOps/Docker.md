# [Docker]()

##  Docker, Virtual Machine and host machine.
******************************
1. **Host computer or local machine** controls all the program and file.  It has an Operating System (OS), which has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc.  The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.
2. **Virtual Machine** virtualize OS kernel and application layer.
3. **Docker** virualizae application layer and borrows the OS kernel from host machine. Docker occupys less space compared to VM becuase it doesnt virtualize OS kernel. The other advantages are: Faster boot time, Easy to scale up, Reproduciability, Developer and tester can run the same code and get the same results even thought the machines are different.
******************************

### Terminology 
******************************
1. **Docker image** is read only templates and contains all dependencies and information to build and run a docker container. 
2. **Docker container** is a runtime instance of a Docker image. It can be realized via **docker run docker-image-name**. Docker container doesnt have the OS within it. It borrows the OS from the host machine and share the host kernel with other containers. In the case of VM, each VM has its own OS. Containers are portable.
3. However, new **Docker image** can also be created from a running container. It can be created via **docker commit container-info**
4. **Docker engine** is a software that creates and runs containers, as well as interact with the host OS. It consists of docker CLI (user interface),  API (for communication), Daemon (for processing the commands from docker client)
5. **Docker host** is a server or machine in which docker runs
6. **Docker client** mainly allows user to interact with Docker. Any Docker command that is run on the terminal, is sent to the Docker daemon via Docker API.
******************************

### Docker commands 
******************************
* **docker info** displays all the information about docker installation, configuration and networking.
* **docker pull software-name:version** pulls the docker image of the software for the given version Example python:latest
* **docker image ls** lists all the docker images in local machine
* **docker rmi -f hello-world** removes the docker images forcefully (**-f**)
* **docker image rm -f IMAGEID** remove the docker images forcefully (**-f**)
* **docker ps** or **docker ps -a** shows the running containers or the records of running containers. It displays container IDs, status, ports and etc.
* **docker stop Name** stops the running containers
* **docker run software-name** takes a default (latest tag or version) docker image and creates a new container, run the container. 
* **docker run software-name:version** takes a docker image and creates a new container, run the container. Version is also called as tag.
* **docker run -it software-name:version** runs the container in both interactive and terminal modes.
* **docker run -p number:number software-name:version** runs the container in specified ports.
* **docker run -d software-name** runs the container in background. To bring it to the front end, **docker attach ContainerID**
* **docker exec** executes a command on the running container, whereas **docker run** just creates a container, runs it and stop when done.
* **docker exec -it container-ID /bin/bash** shows the virutal file system inside a container
* **docker-compose -f docker-compose-LocalExecutor.yml up -d** is for running multiple container applications.  YAML file is used for configuration purposes.
* **docker inspect image-name** returns all the information about docker runs including volume, state information, network information, metadata.
* **docker logs container-ID**
* **docker start container-ID**
* **docker network ls**
******************************

### Important Docker Files You Should Know About
******************************
1. **docker** file handles single containers, while the **docker-compose** file handles multiple container applications
2. **Dockerfile** is a text file that contains instruction to build the docker image.
```
``` 
******************************

without Docker- Every body has to install or compile all dependencies to run a source code in local environment. Artifacts with requirements.txt file
with Docker, No need for any installation. Has its own operating layer. No environemnt configuraion

Container is made up of images. The base is Linux Base image (Alpine or linux distributions). The top is application image.


## How to build a Docker image (template) and run Docker containers (running instance)

Create a docker file with name "Dockerfile"
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
```
