# Big Data
Big Data is a large data that are difficult to process with standard programs or tools. Data is called big data only if one of the three criteria—Volume, Velocity, or Variety—becomes impossible to manage with traditional tools.


Data is basically divided into three categories: 
***********
1. Structured (column field: **known**, column field data type: **known**) Example: Excel files or SQL databases
2. Semi-structured (column field: **known**, column field data type: **unknown**) Example: CSV, JSON documents
3. Unstructured (column field: **unknown**, column field data type: **unknown**) that doesnt exist like relational database table Example: weather data, plain text files, server logs
***********
The process of transforming unstructured to structured is called ETL (Extract-Transform-Load). To achieve ETL quickly for a big data, one must go for large super computes, which has a distributed (own memory and own CPU) or shared (shared memory and own CPU) systems.

## Framework to handle big data

Apache Hadoop (storage platform for data) and Spark (data processing). Hadopp is written in Java. Characteristics - Scalable, distributed and reliable.

### Zookeeper

Race condition - two processes try to access the same resources and causes problems in the system. It occurs in multithreading when statements are incorrect. For example, command to read and write performed at same time. Two process can a file at the same time. This can be avoided by somekind of locking mechanism. Example library mutex  protects shared data from being simultaneously accessed by multiple processes.

A deadlock - a processes is blocked because it is waiting for some resources from another processes which require some resources.
