# [Docker](https://www.youtube.com/watch?v=3c-iBn73dDE)

How to pull and remove images into local machine.
```
docker pull software-name:version Example python:latest
docker image ls
docker image rm image-ID
docker ps
```
How to run Docker
```
docker run software-name:version
```

Docker containers - software package that contain all the dependencies and configurations to run an application. The package is portable. Containers stored in contained repository. [public reopsitory for docker container](https://hub.docker.com/) .

without Docker- Every body has to install or compile all dependencies to run a source code in local environment. Artifacts with requirements.txt file
with Docker, No need for any installation. Has its own operating layer. No environemnt configuraion

Container is made up of images. The base is Linux Base image (Alpine or linux distributions). The top is application image.

Docker container (running, container environment is created) and Docker image (actual package, artifact that move around, not running)

## Difference between docker and VM
Operating system has two layer OS kernel (layer 1) and application layer (layer 2 and top layer). The kernel communicates with hardware such as cpu, mouse and etc. The applications run on the kernel layer. All linux OS looks different becuase they use different application layer  but on same OS kernal.

VM virtualize OS kernel and application layer. Docker virualizae application layer. 

Docker occupys less space compared to VM. 
Faster boot time
Containers have a better performance and consistent
Easy to scale up
High efficieny
Reproduciability
Developer and tester can run the same code and get the same results even thought the machines are different


## How to build a Docker image (template) and run Docker containers (running instance)

Create a docker file with name "Dockerfile"
```
touch Dockerfile
touch requirement.txt
pip install -r requirements. txt
```
