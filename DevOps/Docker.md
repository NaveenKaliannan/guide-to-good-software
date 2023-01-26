# [Docker]

docker handles single containers

docker-compose handles multiple container applications

docker file


How to pull and remove images into local machine.
```
docker pull software-name:version Example python:latest
docker image ls
docker image rm image-ID
docker ps
```
How to run Docker or create a container
```
docker run software-name:version - takes an image and creates a new container
docker run -d software-name:version
docker run -p6000:6379  software-name:version
docker stop container-ID
docker start container-ID - working with containers not with images
docker ps -a
docker logs container-ID
docker exec -it container-ID /bin/bash - virutal file system inside a container
docker network ls
env - to see all the environmental variables
```

Docker containers - software package that contain all the dependencies and configurations to run an application. The package is portable. Containers stored in contained repository. [public reopsitory for docker container](https://hub.docker.com/).

without Docker- Every body has to install or compile all dependencies to run a source code in local environment. Artifacts with requirements.txt file
with Docker, No need for any installation. Has its own operating layer. No environemnt configuraion

Container is made up of images. The base is Linux Base image (Alpine or linux distributions). The top is application image.

Docker container (running, container environment is created) and Docker image (actual package, artifact that move around, not running). Container is the running environment of image.  Docker image can be pulled or pused.

## Difference between docker, VM and host machine.
Operating system has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc. The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.

VM virtualize OS kernel and application layer. Docker virualizae application layer. 
Host machnie is local machine. 

Docker occupys less space compared to VM. 
Faster boot time
Containers have a better performance and consistent
Easy to scale up
High efficieny
Reproduciability
Developer and tester can run the same code and get the same results even thought the machines are different

[Docker port binding](https://betterprogramming.pub/how-does-docker-port-binding-work-b089f23ca4c8) - Docker port and Host port


Docker file - copy the contents of application into dockerfile. The docker file is from image. 

## How to build a Docker image (template) and run Docker containers (running instance)

Create a docker file with name "Dockerfile"
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
```
