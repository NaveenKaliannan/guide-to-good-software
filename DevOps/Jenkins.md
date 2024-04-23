# Jenkins
****************************************
Jenkins is an open-source continuous integration and continuous delivery (CI/CD) automation server that helps automate various stages in the software development process.
It can clean up data, and to do lot of jobs. 
****************************************

### CI/CD
****************************************
* **CI** is the practice of regularly integrating code changes into a shared code repository and automatically building, testing, and validating the changes.\
When a new commit is created in the codebase, Jenkins will automatically trigger a build process. \
Jenkins will fetch the latest code changes, compile the application, and run the automated tests to ensure the new code doesn't break existing functionality.\
This allows developers to catch issues early in the development cycle, before the code is merged into the main branch.\
Jenkins can be configured to run various types of tests, such as unit tests, integration tests, and end-to-end tests, to thoroughly validate the application.
* **CD** Once the new application build has passed all the tests in the CI stage, Jenkins can then automate the deployment process.\
**Jenkins can be configured to:** \
Build a Docker image of the application \
Push the Docker image to a container registry \
Create or update the necessary Kubernetes objects (e.g. Deployments, Services, Ingress) \
Deploy the new application to the production environment running on Kubernetes worker nodes \
This allows for a fully automated deployment process, where new features and bug fixes can be delivered to users quickly and reliably.\
Jenkins integrates with a wide range of tools and technologies to enable this end-to-end CI/CD pipeline, such as version control systems, build tools, container registries, and Kubernetes clusters
****************************************

### Installation of Jenkins via Docker
****************************************
* **https://www.jenkins.io/doc/book/installing/docker/**
* **docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:jenkins-data:/var/jenkins_home  jenkins/jenkins:latest**
****************************************

### Jenkins Job
****************************************
* **FreeStyle Project** is a traditional type of project in Jenkins that allows you to define a series of steps or build instructions
```
# FreeStyle Project for a simple Python script
1. Check out the source code from a Git repository
2. Install Python dependencies
   pip install -r requirements.txt
3. Run the Python script
   python main.py
```
* **Pipeline** is a more modern way of defining build processes in Jenkins using a domain-specific language (DSL) based on Groovy
```
groovy
// Declarative Pipeline for a simple Node.js application
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
    }
}
```  
* **Multi Configuration Project** allows you to define multiple configurations or axes for a single project. This is useful when you need to build and test your project against different combinations of environments, platforms, or parameters.
```
# Multi Configuration Project for a simple Java project
Axes:
  - JDK Version: 8, 11

# Build steps for each JDK version
1. Check out the source code
2. Set up the JDK environment
3. Compile the Java code
4. Run tests
```
* **Folder** in Jenkins is a way to organize and group related projects or items together. It provides a hierarchical structure and can contain other folders, projects, or pipelines.
```
- Organization
  - Team A
    - Project 1
    - Project 2
  - Team B
    - Project 3
    - Project 4
```
* **Multibranch Pipeline** is a type of Pipeline project that automatically discovers and scans branches or pull requests in a version control system (e.g., Git, Subversion). It creates and manages separate Pipeline instances for each branch or pull request
```
groovy
// Multibranch Pipeline for a Git repository
multibranchPipelineJob('my-repo') {
    branchSources {
        git {
            remote('https://github.com/myorg/my-repo.git')
            includes('*')
        }
    }
}
```
* **Organization Folder** is a type of Folder in Jenkins that provides additional features and capabilities for managing projects and pipelines at an organizational level. It allows you to define and enforce policies, access control, and shared libraries across multiple projects or teams.
```
# Organization Folder structure
- MyOrg
  - Shared Libraries
    - utils.groovy
  - Team A
    - Project 1
    - Project 2
  - Team B
    - Project 3
    - Project 4
```
****************************************
