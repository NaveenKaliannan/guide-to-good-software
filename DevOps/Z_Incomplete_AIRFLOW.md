# [APACHE AirFlow]()


Apache AirFlow is an workflow management platform that allows one to schedule, and monitor pipelines as code.

AirFlow DAG is a collection of tasks with directional dependencies, making workflows simple to schedule and track. Basically, it consists of a list of tasks/executions. Each tasks depends on tasks that are closer to it and has an executable. Dependencies in this context essentially refer to which task will execute first and which tasks are interdependent. DAG has the benefit of being simple to manage, collaborate with, automate and test. Python language is used to write the AirFlow DAGs. The best applications of AirFlow DAGS are in ETL, backups, data pipelines, and ML pipelines.

### Advantages of AirFLow
******************************
1. It provides a variety of operators and executors to assist with job executions.
2. Run tasks in parallel.
3. You can also construct your own operator or executor.
4. User-friendly by offering a GUI with information on duration, fail/success/current state, number of runs, retrying jobs, etc.
5. Highly configuratble
6. By adjusting the variables and connections, it can be made dynamic.
7. Improved scaling
8. Large community, significant growth.
9. Dynamic and Flexible in nature. The number and types of tasks can be dynamically created based on data from a database query or external API. Airflow supports dynamic task parameterization using Jinja templating, allowing task properties like command arguments or file paths to be dynamically set based on variables or external data sources, enhancing flexibility.
******************************

### How to install Apache AirFlow
******************************
1. Via Docker: [docker pull apache/airflow](https://hub.docker.com/r/apache/airflow)
2. Via PIP installation: [pip3 install apache-airflow[all]](https://airflow.readthedocs.io/en/1.9.0/installation.html)
3. When Apache Airflow is installed, several files and directories are created in the Airflow home directory (typically `/usr/local/airflow`). Here are some of the key files and directories that are created:
* **airflow.cfg**: The main configuration file for Airflow. It contains various settings like the executor type, database connection, logging settings, and more.
* **airflow.db**: The SQLite database file used by Airflow to store metadata, if SQLite is configured as the backend.
* **dags**: The directory where DAG (Directed Acyclic Graph) files are stored. DAG files define the workflows and tasks in Airflow.
* **logs**: The directory where Airflow logs are stored, including task logs and scheduler logs.
* **plugins**: The directory for custom plugins, which can extend Airflow's functionality.
* **unittests.cfg**: A configuration file used for unit tests.
* **webserver_config.py**: The configuration file for the Airflow webserver.
* **airflow-webserver.pid**: A file containing the process ID of the running Airflow webserver.
* **airflow-scheduler.pid**: A file containing the process ID of the running Airflow scheduler.
* **airflow-worker.pid**: A file containing the process ID of a running Airflow worker process (if applicable).
4. Docker Directories
* **Dockerfile**: This file contains instructions for building a custom Docker image for Airflow. It allows you to add dependencies, install additional packages, or make other modifications to the base Airflow image.
* **docker-compose.yaml**: This file defines the services, networks, and volumes for running Airflow in a multi-container environment. It can be configured for different executors:
* **For LocalExecutor**: Runs tasks on the same machine as the Airflow scheduler and web server, making it ideal for local development and testing. The local folder ./dags should be mounted to /usr/local/airflow/dags in docker volume mount, because the latter path will be used AirFlow Apache. By default, modern Airflow Docker images expect the DAGs to be located in **/opt/airflow/dags**
* **For CeleryExecutor**: Distributes tasks across multiple worker nodes, suitable for production environments with higher scalability requirements.
* **./dags**: This directory is mounted to /opt/airflow/dags in the Docker container. It's where you place your DAG (Directed Acyclic Graph) definition files, which define your Airflow workflows.
* **./logs**: This mounted directory contains logs from task execution and the Airflow scheduler, allowing you to monitor and troubleshoot your workflows.
* **./config**: This directory can contain custom configurations, including: **airflow.cfg**: The main Airflow configuration file, where you can set default parameters such as the executor type, timezone, concurrency limits, and DAG folder location.
* **airflow_local_settings.py**: Used for configuring cluster policies or custom log parsers.
* **./plugins**: This mounted directory is where you can place custom Airflow plugins to extend its functionality.
* **entrypoint.sh**: This script is typically called when the Docker container starts. It runs prerequisites, initializes the Airflow database if necessary, and starts the Airflow services (webserver, scheduler, etc.).
When using Docker Compose, these directories and files work together to create a fully functional Airflow environment. The docker-compose.yaml file orchestrates the services, while the mounted directories allow for easy management of DAGs, logs, and configurations from the host machine
Verify DAGs Loading: After starting the Airflow services, you can verify that your DAGs are being loaded by running:
```bash
airflow dags list
```
******************************

### Terminology 
******************************
1. DAGS - A DAG (Directed Acyclic Graph) is a core concept in Apache Airflow that represents a workflow or data pipeline. The graph is composed of a series of linked nodes. Every node is an activity that relies on other tasks to run. Everything has been carefully arranged. Which operations should be carried out in parallel and in series is a decision that programmers must make. Significant time will be saved. 

What to keep in mind to create DAGS:
* The tasks **without dependencies** (also called `root tasks` or `upstream tasks`) are executed first, and then the tasks **with dependencies** (also called `downstream tasks`) are connected and executed based on their upstream dependencies.
2. Operator - It assists with the execution of tasks. PythonOperator can be used to execute Python scripts. For each operation, responsive operators can be selected and used.
******************************

### Core Compoenents of AirFLow
******************************
1. **MetaData** holds the records of DAG runs, task status, schedule interval, previous and subsequent runs, start and end times, duration, task instance record, task state (e.g., running, success, failed), connection details (e.g., hostnames, credentials), store and retrieve key-value pairs (variables), XCom values, audit logs and historical DAG runs. Airflow metadata database is typically a separate service from the Airflow components like the scheduler, webserver, and workers. They are not part of master node. 

**Few examples of metadata databases used in Apache Airflow** : `SQLite` (comes with default, no paralleization, development and testing purposes, not for production), `PostgreSQL` (better performance, concurrency, and reliability), `MySQL` (good performance and is widely adopted), Amazon RDS (provisioning, backups, and scaling), `Google Cloud SQL` (automatic backups, high availability, and easy scaling). Both Amazon RDS, Google Cloud SQL support PostgreSQL and MySQL as database engines. 

2. **Scheduler** triggers the tasks at the appropriate time and in the planned manner. It determines which tasks must be completed, when they must be completed, and their priority for completion. It is managed by master node. The scheduler is continuously running and checks to see if any DAGS need to be run before beginning the DAG run. Life cycle of Scheduler:
- DAG Parsing: The scheduler periodically scans the DAG_FOLDER directory for Python files containing DAG definitions. It parses these files and creates in-memory DAG objects.
- DAG Scheduling: The scheduler determines when a DAG needs to be run based on its schedule or external triggers. It creates a DAG run, which represents a specific execution of the DAG for a given logical date (execution_date).
- Task Scheduling: For each DAG run, the scheduler creates task instances based on the tasks defined in the DAG and their dependencies. Task instances are scheduled to run when their dependencies are met.
- Task Queuing: Scheduled task instances are enqueued for execution by the executor component.
- Task State Updates: The scheduler monitors the state of task instances and updates their status in the metadata database based on feedback from the executors and workers.

**Interactions with Other Components**

- DAG Files: The scheduler parses Python files containing DAG definitions from the DAG_FOLDER directory.
- Metadata Database: The scheduler reads and writes to this database to manage the lifecycle of DAGs and tasks.
- Executor: The scheduler enqueues (add a task to a queue) tasks for the executor to pick up and assign to workers.
- Workers:  Workers report task status back to the scheduler through the executor.
- Web Server: The web server reads metadata from the database, which is updated by the scheduler.

4. **Webserver/UI/HTTP interface**, which allows for full workflow monitoring. can be viewed completely. Webserver runs and communicates with the metadata. It is managed by master node. It is built using Flask. 
5. **Executor** -  execute tasks at the bottom. Executors receive information from the scheduler when to execute tasks. Once the task fails/success/all status, the information is sent to metadata. Different types of executor: sequential, Kubernetes, Celery, local (completes tasks in parallel that run on a single machine), single-node, multi-node runners. If you use a single node, then the single executor is managed by the master node and the master node will be in local machine. Multi nodes are good for scalability and this means more executor. For multi nodes, we need to set up slave nodes, which should be another machine, like Jenkins. Master node should be local machine. If the Executors are remote machine, then the Scheduler and WebServer will belong to master node in local machine.

- LocalExecutor: Runs tasks in parallel on the same machine as the Airflow scheduler and webserver, using multiprocessing. Suitable for small to medium-sized workflows on a single machine.
- SequentialExecutor: Runs tasks sequentially, one at a time, on the same machine as the scheduler. Mainly used for development and testing purposes.
- CeleryExecutor: Distributes tasks across multiple worker nodes using a message queue (e.g., RabbitMQ). Allows for horizontal scaling across a cluster of machines.
- KubernetesExecutor: Runs tasks as Kubernetes pods on a Kubernetes cluster, providing excellent scalability and resource isolation.

Workers are the processes or nodes that actually execute the tasks assigned by the executor. The nature of workers depends on the type of executor used:
- For the LocalExecutor, workers are separate processes running on the same machine as the scheduler.
- For the CeleryExecutor, workers are separate processes running on different machines in a cluster, waiting for task execution commands from the message queue.
- For the KubernetesExecutor, each worker is a pod running in the Kubernetes cluster.
 
6. **Queuing system** (only distributed system/many executors) - tasks from scheduler. Example, Redis, RabbitmQ
******************************

### Important AIRFLOW Files You Should Know About
******************************
1. **docker-compose** gets the Airflow up and running. It contain various information such as services, networks, environment variables, volumes, software name, software verson and etc. A simple file is given below. 
```
version: '3.7'
services:
    python:
        image: python
```
The version : '3.7' in the first line is the dockor Compose file format specification. 
******************************



### Task/Operator
**Operator**: A template class for doing some work. The (PythonOperator, BashOperator, KubernetesPodOperator) operators execute (Python functions, bash commands, Docker image in a Kubernetes Pod). Note that the abstract BaseOperator class is what all operators inherited from.

**Task**: Defines a work by instantiating an operator.

**Task Instance**: An instance of a task.

## Operator - instantes the tasks
It has dependencies on other tasks (Upstream). Other tasks depend on it (Downstream). **Task dependencies** are defined as follows:
```
A >> B or B.set_downstream(A) -----> A->B
A << B or B.set_upstream(A) ----> A<-B
```

XComs (cross-communications) allows tasks talk to each other. It is used for passing small amount of data.
```
xcom_push and xcom_pull
task_instance.xcom_pull(task_ids='task_name')
task_instance.xcom_push(task_ids='task_name')
```
## Plugins
Note that to create a plugin, a creation of derived class using the airflow.plugins_manager.AirflowPlugin as an base class is mandatory, and refer the object that we want to plug into airflow. A simple example is shown below:
```
from airflow.models.baseoperator import BaseOperator, BaseOperatorLink
from airflow.plugins_manager import AirflowPlugin


class MyDashboardLink(BaseOperatorLink):
    name = "Google"

    def get_link(self, operator: BaseOperator, *, ti_key: TaskInstanceKey):
        return "https://www.google.com"

class MyDashboardLink2(BaseOperatorLink):
    name = "Google"

    def get_link(self, operator: BaseOperator, *, ti_key: TaskInstanceKey):
        return "https://www.fb.com"

class MyFirstOperator(BaseOperator):

    operator_extra_links = (GoogleLink(),)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def execute(self, context):
        self.log.info("Hello World!")

def test_function():
    operator = MyFirstOperator()
    operator.operator_extra_links = MyDashboardLink2()

# Defining the plugin class
class MyDashboardExtraLinkPlugin(AirflowPlugin):
    name = "extra_link_plugin"
    operator_extra_links = [
        MyDashboardLink(),
    ]

class MyDashboard2ExtraLinkPlugin(AirflowPlugin):
    name = "extra_link_plugin"
    operator_extra_links = [
        MyDashboardLink2(),
    ]
```
