# K8 Prototype

Here’s a complete example of how to create a Dockerized Python application that squares a given input, deploy it to Kubernetes, and scale it up to process different inputs. This includes the Dockerfile, Python script, Kubernetes YAML files, and all necessary commands.
* **Step 1: Create the Python Script (app.py)** This script will read an input number from an environment variable, calculate its square, and print the result.
```python
# app.py
import os

def main():
    # Get the input number from the environment variable
    input_number = os.getenv("INPUT_NUMBER", "0")
    try:
        number = int(input_number)
        print(f"The square of {number} is {number**2}")
    except ValueError:
        print("Invalid input! Please provide a valid integer.")

if __name__ == "__main__":
    main()
```
* **Step 2: Create the Dockerfile (Dockerfile)** This file defines how to build the Docker image for the Python application.
```text
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY app.py /app/

# Set the command to run the Python script
CMD ["python", "app.py"]
```
* **Step 3: Build and Push the Docker Image** Build and push your Docker image to a container registry (e.g., Docker Hub).
```bash
# Build the Docker image
docker build -t <your-dockerhub-username>/square-app:latest .

# Push the image to Docker Hub (or any registry)
docker push <your-dockerhub-username>/square-app:latest
```
* **Step 4: Create Kubernetes Deployment YAML (deployment.yaml)** This file defines a Deployment for running multiple pods of your application.
```text
apiVersion: apps/v1
kind: Deployment
metadata:
  name: square-app-deployment
spec:
  replicas: 1  # Start with 1 replica; we'll scale later.
  selector:
    matchLabels:
      app: square-app
  template:
    metadata:
      labels:
        app: square-app
    spec:
      containers:
      - name: square-app-container
        image: <your-dockerhub-username>/square-app:latest # Replace with your image name.
        env:
        - name: INPUT_NUMBER           # Pass input as an environment variable.
          value: "5"                  # Default value; can be overridden.
```
* **Step 5: Apply the Deployment in Kubernetes**
```bash
# Apply the deployment YAML file to create pods in Kubernetes.
kubectl apply -f deployment.yaml

# Check if pods are running.
kubectl get pods

# View logs of a pod to see its output.
kubectl logs <pod-name>
```
* **Step 6: Scale Up Pods Manually** To scale up and run multiple pods (with different inputs), you can override environment variables using Kubernetes commands or modify your deployment. Option A: Manual Scaling with Different Inputs. You can create separate pods with different inputs by overriding INPUT_NUMBER:
```bash
# Scale up to 3 replicas.
kubectl scale deployment square-app-deployment --replicas=3

# Edit each pod's environment variable manually (not ideal for many pods).
kubectl set env deployment/square-app-deployment INPUT_NUMBER=10 --record
```
Option B: Use Jobs for Different Inputs
If you want each pod to process a unique input, use Kubernetes Job objects instead of scaling replicas. Here’s an example: Job YAML File (job.yaml):
```text
apiVersion: batch/v1
kind: Job
metadata:
  name: square-job-10
spec:
  template:
    spec:
      containers:
      - name: square-job-container
        image: <your-dockerhub-username>/square-app:latest
        env:
        - name: INPUT_NUMBER       # Pass a unique input for this job.
          value: "10"
      restartPolicy: Never
```
Commands for Jobs:
```bash
# Run multiple jobs with different inputs.
kubectl apply -f job.yaml

# To pass another input, modify `INPUT_NUMBER` in `job.yaml` or use this command directly:
kubectl create job square-job-20 --image=<your-dockerhub-username>/square-app:latest --env="INPUT_NUMBER=20"

# Check job status.
kubectl get jobs

# View logs of a completed job.
kubectl logs <pod-name>
```
* **Step 7: Automate Scaling Based on Input Load (Optional)** You can use a Horizontal Pod Autoscaler (HPA) to automatically scale pods based on CPU/memory usage or custom metrics. For example:
HPA YAML File (hpa.yaml):
```text
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler
metadata:
  name: square-app-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: square-app-deployment
  minReplicas: 1       # Minimum number of pods.
  maxReplicas: 10      # Maximum number of pods.
  metrics:
  - type: Resource     # Scale based on CPU usage.
    resource:
      name: cpu
      targetAverageUtilization: 50   # Target CPU utilization percentage.
```
Commands for HPA:
```bash
# Apply HPA configuration.
kubectl apply -f hpa.yaml

# Check HPA status.
kubectl get hpa

# Simulate load and watch scaling happen automatically!
```
Summary of Commands:
Build Docker Image
```bash
docker build -t <your-dockerhub-username>/square-app .
docker push <your-dockerhub-username>/square-app .
```
Deploy to Kubernetes
```bash
kubectl apply -f deployment.yaml  
kubectl get pods  
kubectl logs <pod-name>
```
Scale Up Pods
```bash
kubectl scale deployment square-app-deployment --replicas=5
```
Run Jobs with Different Inputs
```bash
kubectl apply -f job.yaml  
kubectl create job square-job-20 --image=<image-name> --env="INPUT_NUMBER=20"
```
Set Up Autoscaling
```bash
kubectl apply -f hpa.yaml
```
This setup ensures that you can dynamically scale up your application and process different inputs efficiently using Kubernetes!

* **Automation Script**
```bash
#!/bin/bash

# Company standard header
# Script Name: scale_square_app.sh
# Description: Scales up square application from 1 to 100 inputs
# Author: [Your Name]
# Date: January 27, 2025
# Version: 1.0

# Set variables
DEPLOYMENT_NAME="square-app-deployment"
IMAGE_NAME="your-dockerhub-username/square-app:latest"
MAX_REPLICAS=100

# Function to create a job for a specific input
create_job() {
    local input=$1
    cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: square-job-${input}
spec:
  template:
    spec:
      containers:
      - name: square-job-container
        image: ${IMAGE_NAME}
        env:
        - name: INPUT_NUMBER
          value: "${input}"
      restartPolicy: Never
EOF
}

# Scale up the deployment
kubectl scale deployment ${DEPLOYMENT_NAME} --replicas=${MAX_REPLICAS}

# Create jobs for inputs 1 to 100
for i in {1..100}
do
    create_job $i
    echo "Created job for input: $i"
done

# Wait for jobs to complete
echo "Waiting for jobs to complete..."
kubectl wait --for=condition=complete job -l job-name=square-job --timeout=300s

# Display results
echo "Results:"
kubectl get jobs -o custom-columns=NAME:.metadata.name,STATUS:.status.succeeded

# Clean up
echo "Cleaning up jobs..."
kubectl delete jobs -l job-name=square-job

# Scale down the deployment
kubectl scale deployment ${DEPLOYMENT_NAME} --replicas=1

echo "Script completed."

```
