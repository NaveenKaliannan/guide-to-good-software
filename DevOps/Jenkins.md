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

### Installation of Jenkins via Docker and important links
****************************************
* **https://www.jenkins.io/doc/book/installing/docker/**
* **docker run -p 8080:8080 -p 50000:50000 -v /home/naveenk/learning/devops/jenkins/:/var/jenkins_home  jenkins/jenkins:latest**
*  **docker-compose.yml** for Jenkins installation
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
* https://www.jenkins.io/doc/pipeline/steps/workflow-cps/
* https://www.groovy-lang.org/syntax.html
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
* **Pipeline** is a more modern way of defining build processes in Jenkins using a domain-specific language (DSL) based on Groovy. Build trigger is used to run when the pipeline jobs is triggered. \
when Poll SCM is ticker, it triggers the job when new changes are merged into the github code. 
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

### Pipeline instructions from jenkins.io
****************************************
The **Pipeline** script always starts with the pipeline block.
The **agent** block specifies which Jenkins node/agent the Pipeline will run on.
The **stages** block contains one or more stage blocks, each representing a stage in the Pipeline like building, testing, etc.
Inside each **stage** block, the **steps** block contains the actual commands/instructions to be executed in that stage.
The **deleteDir** step deletes the specified directory.
The **dir** step is used to change the current working directory, similar to the cd command in bash/shell scripts
* **Jenkinsfile** from github (source code management) can be used in the pipeline via SCM option. Note that the file should ends with Jenkinsfile, prod.Jenkinsfile, test.Jenkinsfile, Multiple Jenkins can also be included.
* **Poll SCM** whenever the code is merged, the jenkins triggers the pipeline.
```
pipeline {
  agent any
  stages {
    stage("Clean old git repos") {
      steps {
        script {
          dir('StructureFactor') {
            deleteDir()
          }          
        }
      }
    }      
    stage("clone") {
      steps {
        sh "git clone https://github.com/NaveenKaliannan/StructureFactor.git"
      }
    }
    stage("build") {
      steps {
        dir("StructureFactor") {
          sh "ls -ltr ; echo 'Building'"
        }
      }
    }
    stage("clean") {
      steps {
        script {
          dir('SimulationData') {
            deleteDir()
          }          
        }
      }
    }    
    stage("test") {
      steps {
        dir("rdf-sourcecode") {
          sh "ls -ltr ../ ; ls -ltr ; echo 'Testing'"
        }
      }
    }
  }
}
```
****************************************

### MultiBranch Pipeline
It is quite similar to the above github pipeline but for all the branches. The pipeline is created for each branches. Whenever new commit is merged, then the scan referesh the pipeline.

### Parameters in Jenkins
By using parameters in your Jenkins pipelines, you can make your builds more flexible and adaptable to different scenarios and environments
This block defines a parameter named myBoolean of type booleanParam. It is a boolean parameter that allows the user to choose between true or false when running the pipeline. The defaultvalue is set to false, which means that if the user doesn't provide a value, it will default to false. The description is a human-readable string that explains the purpose of the parameter.
we can build with parameters set to prod, stage, test and etc.
****************************************
```
parameters {
   booleanParam(defaultvalue: false, description "Enable service?", name: "myBoolean")
}

parameters {
   String(defaultvalue: "Test", description "which environment?", name: "mystring")
}

parameters {
   choice(defaultvalue: ["Test","Stage","Prod"], description "which environment?", name: "mychoice")
}

echo ${params.myBoolean}

echo ${params.mystring}

echo ${params.mychoice}
```
****************************************

### Variables in Jenkins
****************************************
```
environment {
def mystring = "Hello! World"
def mynumber = 10
def myboolean = true
USER_ID = credentials()
PASSWD = credentials()
}

env {
def mynumnber = 2
}

echo "${mystring}"
echo "${mynumber}"
echo "${myboolean}"
```
****************************************

### Statements
Variable scoping in Jenkins Groovy refers to the accessibility and lifetime of variables within different parts of the pipeline script
****************************************
echo "${env.BUILD_NUMBER}"

script{
if(params.myboolean == false){
currentBuild.result="SUCESS"
return 
}
else{
echo "${params.myboolean}"
}
}

steps{
  myfunc("fdfd",2)
}

def myfunc(string text, int num){

echo "${text} ${num}"
}


steps {
    build job: 'pipelinename', parameters: [
        [$class: 'BooleanParameterValue', name: 'myvariable', value: true]
    ]
}
steps {
    build job: 'pipelinename', parameters: [
        [$class: 'BooleanParameterValue', name: 'myvariable', value: true],
        [$class: 'StringParameterValue', name: 'mystring', value: 'hello']
    ]
}
****************************************

## Plugins
*******************************
* **SSH plugin** To install and configure the SSH plugin in Jenkins, follow these steps: Go to "Manage Jenkins" > "Manage Plugins" . Click on the "Available" tab and search for "SSH" . Find the "SSH" plugin in the list and check the box next to it . Click the "Install without restart" button to install the plugin. Once the plugin is installed, you can configure it by going to "Manage Jenkins" > "Configure System" and finding the "SSH" section . Here you can set up the default SSH key to be used by all SSH configurations. To configure a specific SSH server: Click the "Add" button next to "SSH Servers". Fill in the Name, Hostname, Username, and Remote Directory for the SSH server. Click "Test Configuration" to verify the connection works. Add more server configurations if required. Save the changes. After configuring the SSH plugin, you can use it in your Jenkins jobs to execute commands on remote servers over SSH. 


The Jenkins Build Health Weather Plugin offers a visual representation of the health of recent builds within your pipeline or branch. The plugin assigns weather icons based on the success rate of the last few builds, allowing for quick identification of potentially unstable pipelines or branches.

## Weather Icons

- 🌤 **Sunny (Health over 80%)**: Indicates that over 80% of recent builds have passed successfully, representing very stable builds.
- ⛅ **Partially Sunny (Health 61-80%)**: Shows that between 61-80% of recent builds have passed.
- ⛅ **Partially Cloudy (Health 41-60%)**: Indicates that 41-60% of recent builds have been successful.
- ☁️ **Cloudy (Health 21-40%)**: Suggests that only 21-40% of recent builds have passed, indicating some instability.
- 🌧 **Rainy (Health 0-20%)**: Represents poor health, with less than 20% of recent builds succeeding, indicating frequent failures that require investigation and fixing.
