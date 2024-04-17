# [Docker]()

##  Docker, Virtual Machine and host machine.
******************************
1. **Host computer or local machine** controls all the program and file.  It has an Operating System (OS), which has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc.  The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.
2. **Virtual Machine** virtualize OS kernel and application layer. The VM is built on hypervisor, which controls the hardware.
3. **Docker** virualizae application layer and borrows the OS kernel from host machine. Docker occupys less space compared to VM becuase it doesnt virtualize OS kernel. The other advantages are: Faster boot time, Easy to scale up, Reproduciability, compatability/dependenceies, no need to set up environment, Developer and tester can run the same code and get the same results even thought the machines are different. The application that we build we will always have same dependencies and easy to ship the application. With docker, each component or application can be run with specific dependecies/librarie with seperate container. The goal of the docker is to package an application, containerize the application and ship them  and run anytime/anywhere. Docker is to run a specific tasks, once the tasks is completed, the container exists but always lives until removed **docker rm container-id**. 
******************************

### Docker Installation 
******************************
https://docs.docker.com/engine/install/ubuntu/
******************************

### Docker Terminology 
******************************
1. **Docker image** is read only templates and contains all dependencies and information to build and run a docker container. In simpler words, it is just a package.
3. **Docker container** is a runtime instance of a Docker image and an isolated environment, has own processes, interfaces, mounts. It can be realized via **docker run docker-image-name**. Docker container doesnt have the OS within it. It borrows the OS from the host machine and share the host kernel with other containers. In the case of VM, each VM has its own OS. Containers are portable. Docker uses Linux containers (LXC). Note that the windows based docker container cannot be run on linux OS.
4. **Docker compose**
5. **Docker registry** is cloud where all the docker images are stored. The docker reistry is quite similar to the github where the website/useraccount/reposityname is used to pull repository. For private docker registry, **docker login registry.io** needs to be performed, and then run  **docker run registry.io/useraccount/dockercontainername** . Note that the docker registry is an another application and it is a docker image, exposes API on port 5000. docker access structure dockerregistry/username/imagereposityname. Dockerhub (docker.io) is default registry and it is public
6. However, new **Docker image** can also be created from a running container. It can be created via **docker commit container-info**
7. **Docker engine** is a software that creates and runs containers, as well as interact with the host OS. It consists of docker CLI (user interface),  API (for communication), Daemon (for processing the commands from docker client)
8. **Docker host** is a server or machine in which docker runs.
9. **Docker client** mainly allows user to interact with Docker. Any Docker command that is run on the terminal, is sent to the Docker daemon via Docker API.
10. **Accessing the application** via port numbers and IP address. Each container has unique internal IP address and host number by default. Docker host contains an ip address (192.186.1.5) and various port numbers. Via browser, use the docker host ip address and specific port number, one can access the application. Before this, one has to map the free port of docker host to the container port via **-p dockerhostportnumner:containerportnumber**
11. **Storing the data in docker host rather than docker container** can be achieved using the **-v */opt/datadir:/var/lib/mysql*, meaningfully **-v dockerhostvolume:dockercontainervolume**
12. **docker port mapping** Accessing Container Services: By mapping a host port to a container port, you can access services running inside the container from the host machine. For example, if you have a web server running on port 80 in the container, you can access it by connecting to localhost:80 on the host
******************************

### Docker commands 
******************************
* **docker info** displays all the information about docker installation, configuration and networking.
* **docker pull software-name:version** pulls the docker image of the software for the given version Example python:latest
* **docker image ls** lists all the docker images in local machine
* **docker rm containerID** removes the docker container.
* **docker rmi -f hello-world** removes the docker images forcefully (**-f**). **docker images | sed '1d' | awk '{print $3}' | xargs docker rmi** deletes all the images. 
* **docker image rm -f IMAGEID** remove the docker images forcefully (**-f**)
* **docker ps** or **docker ps -a** lists the running containers or **-a** the records of running containers and previous runs. It displays container IDs, status, ports and etc.
* **docker stop Name** stops the running containers
* **docker run software-name** takes a default (latest tag or version) docker image and creates a new container, run the container. 
* **docker run software-name:version** takes a docker image and creates a new container, run the container. Version is also called as tag.
* **docker run -it software-name:version** runs the container in both interactive and terminal modes. **-it** allows one to login to the container.
* **docker run -p dockerhostportnumber:dockercotainerportnumber software-name:version** runs the container in specified ports.
* **docker run -d software-name** runs the container in background. To bring it to the front end, **docker attach ContainerID**
* **docker exec** executes a command on the running container, whereas **docker run** just creates a container, runs it and stop when done.
* **docker exec container-ID cat /etc/hosts** shows the contents of /etc/hosts file.
* **docker exec -it container-ID /bin/bash** shows the virutal file system inside a container
* **docker-compose -f docker-compose-LocalExecutor.yml up -d** is for running multiple container applications.  YAML file is used for configuration purposes.
* **docker inspect image-name** returns all the information about docker runs including volume, state information, network information, metadata.
* **docker logs container-ID**
* **docker start container-ID**
* **docker network ls**
* **doceker push** to push the image to docker cloud.
* **docker run --link source_container:alias runningcontainer** links the "example" container to the running container, and the running container would be able to access the "example" container using the alias "examplealias
******************************

### Working with private docker registry
The structure of docker reposity is as follows: **dockerregistry/username/imagereposityname**. Dockerhub (docker.io) is the default registry and it public. google registry is gcr.io
* **How to start a registry?** It can be achieved via the following command **docker run -d -p 5000:5000 --restart=always --name registry registry:2** Start a local Docker registry on port 5000
******************************
* **docker run -d -p 5000:5000 --restart=always --name registry registry:2* Start a local Docker registry on port 5000. 
* **docker pull ubuntu:latest* Pull the latest Ubuntu image from the default Docker Hub registry. 
* **docker image tag ubuntu:latest localhost:5000/gfg-image* Tag the Ubuntu image for the local registry.
* **docker image tag ubuntu:latest dockerregistry/username/imagereposityname* Tag the Ubuntu image for the cloud registry.  Example:  docker tag local-image gcr.io/my-project/my-image:v1
* **docker push localhost:5000/gfg-image* Push the tagged image to the local registry.
* **docker push dockerregistry/username/imagereposityname* Push the tagged image to the cloud registry. Example:  docker push gcr.io/my-project/my-image:v1
* **docker pull localhost:5000/gfg-image* Pull the image from the local registry. 
* **docker container stop registry* Stop the local Docker registry. 
******************************


### Important Docker Files You Should Know About
******************************
1. **Dockerfile** file handles single containers, while the **docker-compose.yaml** file handles multiple container applications
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
```
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
******************************
* **docker-compose up** command runs the docker compose yaml file


### How to build a Docker image (template) and run Docker containers (running instance)

* Create a docker file with name "Dockerfile" and add all the necessary commands
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
```
* **docker build . -t dockerimagename** builds the image with given name. Note that the Dockerfile with commands should be available in the same folder where this commands get executed. 
* **docker run imagename cat /etc/*release*** gives the base image.
* **docker run -e ENVIRONMENTAL_VARIABLE=input imagename** passes the environmental variable. The variable name can be **docker inspect containerID | grep "environmental variable"**
* **docker run --name containername -e enviornmentalvariable=value -p hostportnumber:containerportnumber  imagename**
* **docker image history imagename** provides the information of image
* Difference between **ENTRYPOINT** and **CMD** in a Dockerfile is how they interact with the Docker run command.
* **ENTRYPOINT** Defines the executable that will be run when the container starts. The **ENTRYPOINT** command cannot be overridden by the Docker run command. Any arguments passed to the Docker run command will be appended to the **ENTRYPOINT** command. The **ENTRYPOINT** command is the primary entry point for executing the container.
* **CMD** Defines the default command and/or parameters that will be used if no command is specified when starting the container. The **CMD** command can be completely overridden by providing arguments to the Docker run command. The **CMD** command is used as the default command when none is specified, but it can be overridden.
* **docker run -d -p 5000:5000 -name my-registry --restart=always registry:2** Runs a registry server with name equals to my-registry using registry:2 image with host port set to 5000, and restart policy set to always.
* **docker image tag nginx:latest localhost:5000/nginx:latest** tags the image with a target name. **docker push localhost:5000/nginx:latest** pushes the target image to registry.
