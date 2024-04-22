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
****************************************
