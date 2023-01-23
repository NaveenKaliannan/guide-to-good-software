# APACHE AirFlow 

AirFlow DAG is a series of tasks with directional dependencies, hence easily to schedule and monitor workflows. It basically contains series of tasks. Each task has an executable and depends on nearest tasks. The dependencies here basically means which task will run first and which tasks are dependent. The flow is written in DAGS. The advantage of DAG is that it is easy to manage, colloborate and test. The DAGs are written in python. The best places where it can be used are ETL, backups, data pipelines, ML pipelines

### Advantages
******************************
1. It offers number of opertaors and executors to support task executions. 
2. Parallelize tasks. 
3. Own opertaor or executor can also created. 
4. User friendly by providing GUI (duration, fail/success/current status, number of runs, retry to execute tasks, and .. etc)
5. Highly configuratble
6. It can be made dynamic by setting the variables and connections. 
7. Better scaling
8. Big community, strong development.
******************************

### Terminology 
******************************
1. DAGS - directed acyclic graph. The graph contain series of nodes and they are connected. Each node is a task, and depends on other tasks. Everthing is organized in a perfect way. As a programmer, one needs to think which tasks should be running in parallel and in series. It will save lot of time.
2. Operator - It helps to carry out tasks/execution. PythonOperator can employed to run python script. For each operation, one can employ respetive operators.
******************************



### Task/Operator 
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
