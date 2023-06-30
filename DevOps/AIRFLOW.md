# [APACHE AirFlow](https://www.udemy.com/course/apache-airflow/)

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
******************************

### Terminology 
******************************
1. DAGS - The graph is composed of a series of linked nodes. Every node is an activity that relies on other tasks to run. Everything has been carefully arranged. Which operations should be carried out in parallel and in series is a decision that programmers must make. Significant time will be saved.
2. Operator - It assists with the execution of tasks. PythonOperator can be used to execute Python scripts. For each operation, responsive operators can be selected and used.
******************************

### Core Compoenents of AirFLow
******************************
1. [MetaData](https://selectfrom.dev/airflow-metadata-how-to-gather-key-runtime-statistics-in-real-time-5575d8740621) (a relational database) - holds the records of DAG runs, task status, schedule interval, previous and subsequent runs, start and end times, duration, task state, and historical DAG runs.
2. Scheduler - triggers the tasks at the appropriate time and in the planned manner. It determines which tasks must be completed, when they must be completed, and their priority for completion. It is managed by master node. The scheduler is continuously running and checks to see if any DAGS need to be run before beginning the DAG run.
3. Webserver/UI/HTTP interface, which allows for full workflow monitoring. can be viewed completely. Webserver runs and communicates with the metadata. It is managed by master node.
4. Executor -  execute tasks at the bottom. Executors receive information from the scheduler when to execute tasks. Once the task fails/success/all status, the information is sent to metadata. Different types of executor: sequential, Kubernetes, local, single-node, multi-node runners. If you use a single node, it is managed by the master node, otherwise by multiple nodes. Always choose one or more nodes depending on the size of the problem
6. Queuing system (only distributed system/many executors) - tasks from scheduler
******************************

### Important AIRFLOW Files You Should Know About
******************************
1. **docker-compose** is used to get Airflow up and running online or in local machine. A simple file is given below. The version : '3.7' in the first line is the dockor Compose file format specification. 
```
version: '3.7'
services:
    python:
        image: python
```
******************************

### How to install Apache AirFlow
******************************
1. Via Docker: [docker pull apache/airflow](https://hub.docker.com/r/apache/airflow)
2. Via PIP installation: [pip3 install apache-airflow[all]](https://airflow.readthedocs.io/en/1.9.0/installation.html)
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
