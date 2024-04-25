# YAML file

YAML (Yet Another Markup Language) is a human-readable text-based format used extensively in Kubernetes for defining and configuring various Kubernetes resources. 
* It is the primary way to define and manage Kubernetes resources, such as Pods, Deployments, Services, ConfigMaps, and etc.
* YAML files are structured using a hierarchical key-value format, making them more readable and easier to understand compared to JSON
* Common Kubernetes YAML file components include apiVersion, kind, metadata, spec, and status. The spec section defines the desired state of the resource
* YAML files allow you to define complex Kubernetes objects, such as Deployments, which include settings like the number of replicas, container images, and labels
* **Key Value**
```
yaml
name: John Doe
age: 30
address:
  street: 123 Main St
  city: Anytown
  state: CA
```
```
json
{
  "name": "John Doe",
  "age": 30,
  "address": {
    "street": "123 Main St",
    "city": "Anytown",
    "state": "CA"
  }
}
```
* **Key-List**
```
yaml
yaml
fruits:
  - apple
  - banana
  - orange
```
```
json
"fruits": ["apple", "banana", "orange"]
```
* **Key-List of Dictionaries**
```
yaml
employees:
- name: Martin D'vloper
  job: Developer
  skill: Elite
- name: John D'vloper
  job: PM
  skill: Elite
```
```
json
{
  "employees": [
    {
      "name": "Martin D'vloper",
      "job": "Developer",
      "skill": "Elite"
    },
    {
      "name": "John D'vloper",
      "job": "PM",
      "skill": "Elite"
    }
  ]
}
```
* **The key points are**:
Key-value pairs are represented with a colon : separating the key and value, with the value indented on the next line.
Lists are represented with a dash - followed by the list item, with each item indented at the same level.
Dictionaries within lists are represented by indenting the key-value pairs under the list item.
These examples demonstrate the flexibility of YAML in representing structured data, from simple key-value pairs to more complex nested data structures. The consistent use of indentation and special characters like - makes YAML files easy for both humans and machines to read and write.

* **when to use them**
Use **key-value** pairs for simple scalar values Example: telephone directory. \
Use **lists** for ordered collections of values, Example, alpbhabetical order, series and etc. \
Use **lists of dictionaries** for collections of structured data, Example: databases 
******************************
