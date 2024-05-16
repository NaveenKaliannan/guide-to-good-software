# Jenkins
****************************************
Jenkins is an open-source continuous integration and continuous delivery (CI/CD) automation server that helps automate various stages in the software development process. The Jenkins architecture is designed for distributed build environments
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

### Important terminology
*****************************************
* The **built-in node** comes when Jenkins is installed. It is a node that exists within the Jenkins controller process itself. The built-in node is a node that is automatically created and configured when you install Jenkins. It allows you to run jobs and tasks directly on the Jenkins controller machine without needing to set up any additional nodes or agents. However, running jobs on the built-in node is generally discouraged for security, performance, and scalability reasons. It is recommended to use separate agent nodes for executing jobs, while the Jenkins controller acts as the central management and coordination point. The built-in node has a configurable number of executors, which determines how many concurrent jobs or tasks can run on it. By default, the number of executors is set to the number of CPU cores on the Jenkins controller machine. You can set the number of executors to 0 to disable running tasks on the built-in node entirely
* A **Jenkins slave/agent node** is a remote machine or container that is connected to the Jenkins master server to execute build jobs and tasks. Java must be installed on the slave node machine.
 Here are the key points about Jenkins slave/agent nodes:  The **remoting.jar** file and related **caches/directories** are created by Jenkins for efficient communication and file transfer between the Jenkins controller and agent nodes. The **remoting.jar** is a core component of the Jenkins Remoting library. It is responsible for establishing and managing the communication channel between the Jenkins controller and agent nodes. **When launching an agent node, Jenkins copies the remoting.jar to the agent machine and executes it to initiate the connection back to the controller**. The **JAR cache** is a local cache on the agent machine that stores JAR files sent by the Jenkins controller. This caching mechanism improves performance by avoiding redundant file transfers for the same JAR files across different builds or agents. Each JAR file is identified by its MD5 checksum, allowing the cache to be reused across different channel sessions. The workspace directory is a dedicated location on the agent machine where Jenkins stores temporary files, logs, and other metadata related to the build process. This directory is specified using the -workDir option when launching the agent process.


## Jenkins architecture
Overview of the key components in the Jenkins architecture: 

### Master Node
The Jenkins master is the central, controlling node that handles and monitors the execution of jobs/pipelines. It consists of the following main components:
* **Web Server**: Provides a user interface to configure Jenkins, create/manage jobs, view reports, etc. It runs on a Java servlet container like Jetty or Tomcat.
* **Controller**: Orchestrates and schedules jobs, dispatches work to executors on master or slave nodes, monitors their execution, and handles results.
* **Job/Project Definitions**: Defines the jobs/pipelines with their configurations, such as source code repository, build triggers, build steps, etc.
* **Workspaces**: Temporary directories on the master's filesystem where jobs are checked out and executed.
* **Plugins**: Jenkins has a vast plugin ecosystem that extends its capabilities for various tasks like source control integration, notifications, deployments, etc.

### Slave/Agent Nodes
Jenkins slave nodes are remote machines that communicate with the master and execute jobs/pipelines. They can be physical or virtual machines, containers, or cloud instances. Slave nodes have the following components:
* **Executors**: Carry out the actual work by running the job's build steps within separate workspaces.
* **Workspaces**: Like the master, slaves have temporary workspaces to check out code and run build steps.
* **Launchers**: Handle the communication between the master and slave, transferring input/output data, files, and executing processes on the slave.

The master schedules jobs and assigns executors on slaves based on their availability and labels (e.g., operating system, hardware). Slaves regularly communicate their status back to the master.
Key Architectural Aspects
* **Distributed Builds**: By utilizing multiple slave nodes, Jenkins can run parallel builds, tests, and deployments, improving overall throughput and efficiency.
* **Plugins Architecture**: Jenkins' modular architecture allows extending its functionality through plugins developed by the community or third-parties.
* **Job/Pipeline Organization**: Jobs/pipelines encapsulate the entire build process, from source code checkout to testing, building, and deployment.
* **Master-Slave Communication**: The master and slaves communicate over TCP/IP using remoting-based or agent-based protocols like JNLP, WebSocket, or CLI.
* **Security**: Jenkins supports various authentication and authorization mechanisms, including its user database, LDAP, OAuth, and role-based access control.


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
* **Pipeline** script always starts with the pipeline block.

* The **agent block** specifies which Jenkins node/agent the Pipeline will run on. There are two types of agent nodes: master and slave nodes. The master node (also called the Jenkins controller) is created by default when Jenkins is installed. Any number of slave nodes can be created manually in Manage Jenkins -> Manage Nodes. Slave node can be a container, or a phyical machine or a remote machine. 

```groovy
// Run the entire pipeline on any available agent
pipeline {
    agent any
    // pipeline stages...
}

// Run the entire pipeline on an agent with the 'my-label' label 
pipeline {
    agent { label 'my-label' }
    // pipeline stages...
}

// Run a specific stage on a Docker container
pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker { image 'maven:3.8.1' }
            }
            steps {
                // build steps
            }
        }
        // other stages
    }
}
```
* The **stages** block organizes and structures the different phases of a Pipeline job like building, testing, etc. Inside each **stage** block, the **steps** block contains the actual commands/instructions to be executed in that stage.
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // Build steps go here
            }
        }
        stage('Test') {
            steps {
                // Test steps go here 
            }
        }
        stage('Deploy') {
            steps {
                // Deploy steps go here
            }
        }
    }
}
```
Running stages in parallel.
```groovy
pipeline {
    agent any
    stages {
        stage('Parallel Tests') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        // Unit test steps
                    }
                }
                stage('Integration Tests') {
                    steps {
                        // Integration test steps
                    }
                }
            }
        }
    }
}
```
Dynamic stage execution
```groovy
def stageNames = ['Stage 1', 'Stage 2', 'Stage 3']

pipeline {
    agent any
    
    stages {
        stage('Generate Stages') {
            steps {
                script {
                    stageNames.each { stageName ->
                        stage(stageName) {
                            steps {
                                echo "This is ${stageName}"
                            }
                        }
                    }
                }
            }
        }
    }
}
```
* Inside the **steps** section of a Jenkinsfile, you can execute various commands and scripts. **the steps block is used to execute simple steps like running a shell command (sh) and calling a method from a shared library. Inside the script block is used to incorporate Groovy scripting.** Here are some common commands that can be executed:
```groovy
steps {
    sh '''
        echo "Running shell script"
        ls -l
        ./build.sh
    '''
    bat '''
        echo "Running batch script"
        dir
        build.bat
    '''
    script {
        def output = sh(script: 'ls -l', returnStdout: true).trim()[1]
        echo "Output: ${output}"
    }
    echo 'Hello World'
    sh 'echo "Running shell command"'
    stash includes: 'target/**/*', name: 'app'
    unstash 'app'
    archiveArtifacts artifacts: 'target/**/*'
    sh 'scripts/build.sh'
    bat 'scripts/deploy.bat'
    load 'scripts/utils.groovy'
    sh '''
        echo "Executing multi-line command"
        mkdir build
        cd build
        cmake ..
        make
    '''
    // Shell script
    sh '''
        echo "Running shell script"
        mkdir output
        ls -l > output/files.txt
    '''

    // Groovy script
    script {
        def files = sh(script: 'ls -1', returnStdout: true).trim().split('\n')
        echo "Files in directory: ${files.join(', ')}"[1]
    }

    // Jenkins pipeline step
    echo 'Hello World'

    // Invoking external script
    sh 'scripts/build.sh'

    // Multi-line command
    sh '''
        echo "Compiling code"
        gcc -o app main.c
        ./app
    '''
}
```
* **Retry** First bug code will be retried 3 time, while the latter (correct code) will be executed only once.
```groovy
pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                retry(3) {
                    sh 'eco "Hello, World!"'
                }
            }
        }
    }
}

pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                retry(3) {
                    sh 'echo "Hello, World!"'
                }
            }
        }
    }
}
``` 
* **timeout** The commands inside the time out after the given time period.  
```groovy
pipeline {
    agent any
    stages {
        stage('Timeout Example') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    sh '''
                        echo "Starting long-running task..."
                        sleep 120 # Simulating a task that takes 2 minutes #+ sleep 120 Cancelling nested steps due to timeout
                        echo "Long-running task completed successfully."
                    '''
                }
            }
        }
        stage('Success') {
            steps {
                echo "Pipeline executed successfully!"
            }
        }
    }
}
```
* **Enviornment and Credentials**  How to set credentials?.  Manage Jenkins -> Credentials -> System -> Global Credentials -> Add credentials -> Secrect text. **printenv** prints all the environmental variables. 
```groovy
pipeline {
    agent any
    
    environment {
        MY_VAR = 'Hello, World!'
        BUILD_USER = credentials('jenkins-user')
    }
    
    stages {
        stage('Print Environment Variables') {
            steps {
                sh 'echo "MY_VAR value: ${MY_VAR}"'
                sh 'echo "BUILD_USER value: ${BUILD_USER}"'
                sh 'printenv' # prints the all the enviornmental variable
            }
        }
    }
}
```
* **when** is like a if condition and allows you to control the execution flow of your pipeline based on certain conditions
```groovy
pipeline {
    agent any
    
    stages {
        stage('Example') {
            steps {
                script {
                    def isProduction = env.BRANCH_NAME == 'main'
                    
                    if (isProduction) {
                        echo 'Deploying to production environment'
                    } else {
                        echo 'Deploying to non-production environment'
                    }
                }
            }
        }
    }
}
``` 
```groovy
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Running steps'
            }
        }
    }
    post {
        always {
            script {
                when {
                    environment name: 'DEPLOY_ENV', value: 'production'
                    echo 'Sending notification to team'
                }
            }
        }
    }
}
```
```groovy
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                script {
                    when {
                        branch 'main'
                        echo 'Running on main branch'
                    }
                    when {
                        not { branch 'main' }
                        echo 'Running on a non-main branch'
                    }
                }
            }
        }
    }
}
```
* **Post actions** in Jenkins are steps that can be executed after the main build or stage execution, based on the outcome of the build or stage
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                // Simulate a successful build
            }
        }
        stage('Test') {
            steps {
                echo 'Testing the application...'
                // Simulate a failed test
                error 'Test failed'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if the build succeeds'
        }
        failure {
            echo 'This will run only if the build fails'
        }
        unstable {
            echo 'This will run only if the build is unstable'
        }
        changed {
            echo 'This will run only if the build status changes'
        }
        aborted {
            echo 'This will run only if the build is aborted'
        }
    }
}
``` 
* **tools** Global Tool Configuration in Jenkins allows you to centrally manage and configure different versions of tools and technologies that your Jenkins jobs or pipelines may require.\
 Manage Jenkins" > "Global Tool Configuration -> install automatically or set the path directions of installed version
```groovy
pipeline {
    agent any
    tools {
        maven 'maven3_9_6'
    }
    stages {
        stage('Build') {
            steps {
                sh '''
                mvn --version
                '''
            }
        }
    }
}
```
* **timstamps** prints the time info for all the outputs
```groovy
pipeline {
    agent any
    
    options {
        timestamps()
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'echo "Building the application..."'
            }
        }
        
        stage('Test') {
            steps {
                sh 'echo "Running tests..."'
            }
        }
    }
}
```
* **skipDefaultCheckout**  allows one to skip the automatic checkout of the source code repository at the start of the pipeline execution
```
pipeline {
    agent any
    options {
        skipDefaultCheckout true  // Skip automatic source checkout
    }
    stages {
        stage('Build') {
            steps {
                // Explicitly check out source code if needed
                checkout scm
                
                // Build steps...
            }
        }
        stage('Test') {
            steps {
                // No need to check out source code for this stage
                
                // Test steps...
            }
        }
    }
}
```
```groovy
pipeline {
    agent any
    options {
        skipDefaultCheckout true
    }
    stages {
        stage('Build') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        checkout scm
                        // Build steps for main branch...
                    } else {
                        // Build steps for other branches without source code...
                    }
                }
            }
        }
    }
}
```
Scripted Pipeline : This uses the tool step to get the home directories of Maven and JDK, adds them to the PATH environment variable, and then executes the Maven command.
```groovy
node {
    def mvnHome = tool 'Maven 3.6.3'
    def jdkHome = tool 'JDK 11'
    
    env.PATH = "${mvnHome}/bin:${jdkHome}/bin:${env.PATH}"
    
    stage('Build') {
        sh 'mvn clean install'
    }
}
```
Using withEnv : The withEnv step allows you to set environment variables for a specific block of code. Here, it prepends the Maven and JDK tool paths to the existing PATH.
```groovy
node {
    stage('Build') {
        withEnv(["PATH+MAVEN=${tool 'Maven 3.6.3'}/bin", "PATH+JDK=${tool 'JDK 11'}/bin"]) {
            sh 'mvn clean install'
        }
    }
}
```
Dynamic Tool Configuration : This dynamically configures the Maven and JDK tools using their respective types, allowing for more flexible tool configuration.
```groovy
def mvnHome = tool name: 'Maven 3.6.3', type: 'hudson.tasks.Maven$MavenInstallation'
def jdkHome = tool name: 'JDK 11', type: 'hudson.model.JDK'
```

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
