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
4. **Docker engine** is a software that creates and runs containers
******************************

### Docker commands 
******************************
* **docker info** displays all the information about docker installation, configuration and networking.
* **docker pull software-name:version** pulls the docker image of the software for the given version Example python:latest
* **docker image ls** lists all the docker images in local machine
* **docker rmi -f hello-world** removes the docker images forcefully (**-f**)
* **docker image rm -f IMAGEID** remove the docker images forcefully (**-f**)
* **docker ps** shows the running containers
* **docker run software-name:version** takes a docker image and creates a new container, run the container
* **docker-compose -f docker-compose-LocalExecutor.yml up -d** is for running multiple container applications.  YAML file is used for configuration purposes.
******************************

### Important Docker Files You Should Know About
******************************
1. **Dockerfile** is a text file that contains instruction to build the docker image. 
******************************

[Docker port binding](https://betterprogramming.pub/how-does-docker-port-binding-work-b089f23ca4c8) - Docker port and Host port


docker handles single containers
docker-compose handles multiple container applications
docker file

```
How to run Docker or create a container
```
docker run -p6000:6379  software-name:version
docker stop container-ID
docker start container-ID - working with containers not with images
docker ps -a
docker logs container-ID
docker exec -it container-ID /bin/bash - virutal file system inside a container
docker network ls
env - to see all the environmental variables
```

without Docker- Every body has to install or compile all dependencies to run a source code in local environment. Artifacts with requirements.txt file
with Docker, No need for any installation. Has its own operating layer. No environemnt configuraion

Container is made up of images. The base is Linux Base image (Alpine or linux distributions). The top is application image.

Docker container (running, container environment is created) and Docker image (actual package, artifact that move around, not running). Container is the running environment of image.  Docker image can be pulled or pused.



Docker file - copy the contents of application into dockerfile. The docker file is from image. 

## How to build a Docker image (template) and run Docker containers (running instance)

Create a docker file with name "Dockerfile"
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
```
