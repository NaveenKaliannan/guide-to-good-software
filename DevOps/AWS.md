# AWS

# ☁️ Cloud Computing Overview

Cloud computing on AWS means renting IT resources—such as servers, storage, and databases—over the internet instead of buying and maintaining physical hardware. It provides on‑demand access, rapid scalability, and a pay‑as‑you‑go pricing model.

---

## 🔧 Main AWS Building Blocks

### **Compute**
Run applications and code using:
- **EC2** – Virtual servers
- **Lambda** – Serverless functions

### **Storage**
Store files, backups, and application data:
- **S3** – Object storage
- **EBS** – Block storage for EC2

### **Databases**
Use fully managed database services:
- **Amazon RDS**
- **DynamoDB**

### **Networking**
Connect and secure cloud resources:
- **VPC**
- **Load Balancers**
- **Content Delivery**

---

# 🏛️ The Three Types of Cloud Computing

## 1. 🏗️ Infrastructure as a Service (IaaS)
IaaS provides virtualized computing resources over the internet.

### **What You Get**
- Virtual machines (VMs)  
- Storage (block, file, object)  
- Networking (VPCs, load balancers, firewalls)  
- Full control over OS, runtime, and applications  

### **Best For**
- High‑customization environments  
- Migrating from on‑premises data centers  
- Developers needing full control  

### **Examples**
- AWS EC2  
- Microsoft Azure Virtual Machines  
- Google Compute Engine  

---

## 2. 🧩 Platform as a Service (PaaS)
PaaS offers a managed platform for building, testing, and deploying applications.

### **What You Get**
- Runtime environments  
- Databases  
- Middleware  
- DevOps tools  

### **Best For**
- Developers focused on coding  
- Rapid application development  
- Teams avoiding infrastructure management  

### **Examples**
- Google App Engine  
- Azure App Service  
- AWS Elastic Beanstalk  

# 📊 On‑Premises vs IaaS vs PaaS vs SaaS

| Feature / Responsibility | **On‑Premises** | **IaaS** | **PaaS** | **SaaS** |
|--------------------------|-----------------|----------|----------|----------|
| **Physical Hardware** | You manage | Provider manages | Provider manages | Provider manages |
| **Virtualization** | You manage | Provider manages | Provider manages | Provider manages |
| **Servers & Storage** | You manage | You manage (virtually) | Provider manages | Provider manages |
| **Networking** | You manage | Provider manages core network; you configure VPC | Provider manages | Provider manages |
| **Operating System** | You manage | You manage | Provider manages | Provider manages |
| **Runtime / Middleware** | You manage | You manage | Provider manages | Provider manages |
| **Application Code** | You manage | You manage | You manage | Provider manages |
| **Data** | You manage | You manage | You manage | You manage (within app limits) |
| **Scalability** | Manual, slow | Fast, on‑demand | Automatic | Automatic |
| **Cost Model** | High upfront CAPEX | Pay‑as‑you‑go | Pay‑as‑you‑go | Subscription |
| **Best For** | Full control, legacy systems | Customizable environments | Rapid development | End‑users needing ready apps |
| **Examples** | Traditional data centers | AWS EC2, Azure VMs | AWS Elastic Beanstalk, Google App Engine | Microsoft 365, Salesforce |

## 3. 🧑‍💻 Software as a Service (SaaS)
SaaS delivers ready‑to‑use applications over the internet.

### **What You Get**
- Fully managed software  
- No installation or maintenance  
- Accessible via browser or mobile app  

### **Best For**
- Quick deployment  
- Subscription‑based usage  
- Non‑technical end users  

### **Examples**
- Microsoft 365  
- Google Workspace  
- Salesforce  

# 💰 AWS Pricing Fundamentals

AWS pricing is built around three core cost drivers that apply across most services:

## 1. ⚙️ Compute
You pay for the processing power you use.  
Examples: EC2 instance hours, Lambda execution time, Fargate tasks.

## 2. 🗄️ Storage
You pay for how much data you store and how long you keep it.  
Examples: S3 objects, EBS volumes, RDS storage.

## 3. 🌐 Data Transfer Out
AWS charges for data leaving AWS (to the internet or other regions).  
Data transfer **into** AWS is free.

These three pillars—**Compute, Storage, and Data Transfer Out**—form the foundation of AWS’s pricing model and influence the cost of nearly every AWS service.

# AWS Services: Regional vs Global

| Service Category | AWS Service | Scope |
|------------------|-------------|--------|
| **Compute** | EC2 | Regional |
| | Lambda | Regional |
| | ECS | Regional |
| | EKS | Regional |
| | Elastic Beanstalk | Regional |
| | Lightsail | Regional |
| | Batch | Regional |
| **Storage** | S3 | Regional (global namespace) |
| | EBS | Regional |
| | EFS | Regional |
| | FSx | Regional |
| | Glacier | Regional |
| **Database** | RDS | Regional |
| | DynamoDB | Regional (Global Tables optional) |
| | Aurora | Regional |
| | ElastiCache | Regional |
| | Neptune | Regional |
| | DocumentDB | Regional |
| **Networking** | VPC | Regional |
| | API Gateway | Regional |
| | ELB (ALB/NLB/CLB) | Regional |
| | Direct Connect | Regional |
| | Transit Gateway | Regional |
| **Security & Identity** | IAM | Global |
| | KMS | Regional |
| | Secrets Manager | Regional |
| | Cognito | Regional |
| | ACM | Regional (CloudFront certs are Global) |
| | GuardDuty | Regional |
| | Inspector | Regional |
| **Management & Monitoring** | CloudWatch | Regional |
| | CloudTrail | Regional (can aggregate globally) |
| | Config | Regional |
| | Systems Manager (SSM) | Regional |
| | Trusted Advisor | Global |
| **Analytics** | Athena | Regional |
| | Glue | Regional |
| | EMR | Regional |
| | Kinesis | Regional |
| | Redshift | Regional |
| **AI/ML** | SageMaker | Regional |
| | Rekognition | Regional |
| | Comprehend | Regional |
| | Lex | Regional |
| | Polly | Regional |
| | Transcribe | Regional |
| **Global Edge & DNS** | Route 53 | Global |
| | CloudFront | Global |
| | AWS Global Accelerator | Global |
| | WAF | Global |
| | Shield | Global |
| **Account & Governance** | AWS Organizations | Global |
| | Control Tower | Global |
| | Service Quotas | Global (quotas themselves are regional) |
| | Artifact | Global |
| **Developer Tools** | CodeCommit | Regional |
| | CodeBuild | Regional |
| | CodeDeploy | Regional |
| | CodePipeline | Regional |
| **Marketplace** | AWS Marketplace | Global |

# AWS Shared Responsibility Model

The AWS Shared Responsibility Model defines how security duties are divided between **AWS** and the **customer**.

## 🔐 Security *OF* the Cloud (AWS Responsibility)
AWS is responsible for protecting the infrastructure that runs all AWS services:
- Physical data centers
- Hardware, networking, and facilities
- Global infrastructure (Regions, AZs, Edge locations)
- Virtualization layer
- Managed service infrastructure

## 🧑‍💻 Security *IN* the Cloud (Customer Responsibility)
Customers are responsible for securing everything they build or configure on AWS:
- IAM users, roles, and permissions
- Data protection and encryption choices
- Network configuration (VPC, subnets, SGs, NACLs)
- OS patching and maintenance (for EC2)
- Application code and dependencies
- S3 bucket policies and access controls
- Logging, monitoring, and alerting setup

## 📌 Summary
- **AWS secures the cloud.**
- **You secure what you put in the cloud.**

# AWS Security, Compliance, and Data Protection

AWS provides a secure cloud platform with built‑in controls for data protection, compliance, and governance. Security is based on the **Shared Responsibility Model**, where AWS secures the cloud infrastructure and customers secure their workloads.

# Examples of What the Customer Must Secure in AWS

Under the AWS Shared Responsibility Model, AWS secures the cloud infrastructure, while customers must secure everything they build *in* the cloud. Below are practical examples of what customers are responsible for.

## 🔐 Identity & Access Management (IAM)
- Creating and managing IAM users, roles, and groups  
- Enforcing MFA  
- Managing access keys and credentials  
- Applying least‑privilege permissions  

## 🗄️ Data Security
- Encrypting data at rest (S3, EBS, RDS, DynamoDB)  
- Encrypting data in transit (TLS/HTTPS)  
- Managing KMS customer-managed keys (CMKs)  
- Setting S3 bucket policies and access controls  

## 🌐 Network Security
- Designing VPC architecture  
- Configuring Security Groups and NACLs  
- Managing routing tables and subnets  
- Controlling inbound/outbound traffic  
- Setting up firewalls and WAF rules (if used)  

## 🖥️ Compute & OS Security
For EC2 and self-managed workloads:
- Patching the operating system  
- Updating applications and libraries  
- Managing antivirus/endpoint protection  
- Hardening the OS and SSH access  

## 🧱 Application Security
- Securing application code  
- Validating inputs and preventing vulnerabilities  
- Managing API keys, secrets, and tokens  
- Implementing authentication and authorization  

## 📊 Monitoring & Logging
- Enabling CloudTrail, CloudWatch Logs, and Config  
- Setting log retention policies  
- Creating alarms and alerts  
- Reviewing audit logs  

## 🧹 Resource Management
- Deleting unused EBS volumes, snapshots, and IPs  
- Managing backups and disaster recovery plans  
- Ensuring proper tagging and cost controls  

## 📌 Summary
Customers must secure:
- **Identity, access, data, network, OS, applications, and logging**  
AWS secures:
- **Data centers, hardware, networking, and managed service infrastructure**


## 🔐 Security in AWS
AWS offers multiple layers of security to protect workloads:

- **Identity & Access Management (IAM)** for fine‑grained access control  
- **Network security** using VPC, Security Groups, NACLs, and firewalls  
- **Monitoring & logging** via CloudTrail, CloudWatch, and Config  
- **Threat detection** with GuardDuty, Inspector, and Security Hub  
- **DDoS protection** through AWS Shield and WAF  

AWS ensures physical, network, and infrastructure security across all regions and data centers.

---

## 🛡️ Compliance in AWS
AWS provides compliance programs and certifications to help customers meet regulatory requirements.

**Examples of supported compliance frameworks:**
- ISO 27001, 27017, 27018  
- SOC 1, SOC 2, SOC 3  
- GDPR  
- HIPAA  
- PCI DSS  
- FedRAMP  
- IRAP, ENS, and more  

Customers can access compliance reports through **AWS Artifact**.

---

## 🔒 Data Protection at Rest
AWS provides multiple options to secure data stored in the cloud:

- **Encryption at rest** using AWS KMS, CloudHSM, or customer‑managed keys  
- **Service‑level encryption** (S3, EBS, RDS, DynamoDB, Redshift, etc.)  
- **Automatic key rotation** and fine‑grained key policies  
- **Backup and snapshot

# Cloud Deployment Models

## 🌐 Public Cloud
A public cloud is owned and operated by a cloud provider (e.g., AWS, Azure, GCP).  
Resources are shared across multiple customers, but isolated logically.

**Characteristics**
- Pay-as-you-go
- Highly scalable
- No hardware ownership
- Multi-tenant environment

**Examples:** AWS, Azure, Google Cloud

---

## 🏢 Private Cloud
A private cloud is dedicated to a single organization.  
It can be hosted on‑premises or by a third-party provider.

**Characteristics**
- Full control over hardware and security
- Single-tenant environment
- Customizable infrastructure
- Higher cost and maintenance responsibility

**Examples:** On‑prem VMware, OpenStack, AWS Outposts

---

## 🔗 Hybrid Cloud
A hybrid cloud combines **public** and **private** cloud environments, allowing data and applications to move between them.

**Characteristics**
- Mix of on‑prem and cloud resources
- Flexible workload placement
- Supports gradual cloud migration
- Useful for compliance or legacy systems

**Examples:** On‑prem + AWS, Azure Arc, Google Anthos


# AWS IAM Roles, Access Types, and Permission Boundaries

## AWS IAM Role

An **AWS IAM role** is an identity with permissions that can be assumed by a user, application, or AWS service.  
Example: An EC2 instance assumes a role that allows it to read objects from an S3 bucket without storing long-term access keys on the instance.

**Use an IAM role when:**
- You run code on AWS services (EC2, Lambda, ECS) that must call other AWS APIs.
- You need temporary credentials instead of long-term keys.
- You need cross-account access via `AssumeRole`.

---

# Hidden Costs in AWS to Be Aware Of

AWS pricing is usage‑based, but several costs are easy to overlook. Below are common hidden charges that can unexpectedly increase your bill.

## 📤 Data Transfer Costs
- Data transfer **out** to the internet is charged.
- Cross‑AZ traffic (e.g., between subnets in different AZs) is billed.
- VPC endpoints and NAT Gateway traffic incur per‑GB charges.

## 🧱 NAT Gateway Charges
- Charged per hour **plus** per‑GB processed.
- Often one of the biggest unexpected costs in VPC setups.

## 🗄️ S3 Hidden Costs
- S3 **PUT/GET requests** cost money (especially with high‑volume logs).
- S3 **cross‑region replication** doubles storage and adds transfer fees.
- S3 Glacier retrieval fees can be significant.

## 📊 CloudWatch Costs
- Log ingestion and retention can grow quickly.
- Custom metrics and dashboards add charges.
- Log Insights queries cost per GB scanned.

## 🧩 Load Balancers
- ALB/NLB charge per hour **and** per LCU/NU usage.
- Idle load balancers still cost money.

## 🧠 Lambda Hidden Costs
- High invocation frequency increases cost.
- VPC‑enabled Lambdas add **ENI creation** overhead and can slow cold starts.

## 🗃️ RDS & DynamoDB
- Automated backups and snapshots consume storage.
- Multi‑AZ deployments double storage and compute costs.
- DynamoDB on‑demand mode can spike during traffic bursts.

## 🔐 KMS Usage
- Every encryption/decryption call costs money.
- Services like S3, EBS, Lambda, and RDS may call KMS frequently.

## 🧪 API Gateway
- Charged per million requests.
- Large payloads increase cost.

## 🧭 Elastic IPs
- Charged when **not** attached to a running instance.

## 🧹 Orphaned Resources
- Unused EBS volumes
- Old snapshots
- Idle load balancers
- Detached but allocated IPs
- Unused NAT gateways

These often accumulate silently.

## 🧪 Free Tier Pitfalls
- Free tier expires after 12 months.
- Some services (e.g., CloudWatch, NAT Gateway) are **not** included.

# How AWS Pay‑As‑You‑Go Saves Money vs Physical Hardware

AWS uses a **Pay‑As‑You‑Go (PAYG)** pricing model, meaning you only pay for the resources you actually use. This is fundamentally different from traditional on‑premises hardware, where you must buy, maintain, and over‑provision infrastructure upfront.

## 💸 1. No Upfront Hardware Costs
With physical servers, you must purchase:
- Servers
- Storage arrays
- Networking equipment
- Racks, cooling, and power

AWS removes all capital expenditure (CapEx). You start instantly with zero upfront cost.

## 📉 2. No Over‑Provisioning
On‑prem hardware requires buying enough capacity for **peak load**, even if it’s rarely used.

AWS lets you scale up and down:
- Pay only for CPU, memory, storage, and bandwidth you consume
- Automatically scale during peak times
- Scale down to zero when idle (e.g., Lambda, ECS Fargate)

This eliminates wasted capacity.

## 🛠️ 3. No Maintenance or Upgrade Costs
Physical hardware requires:
- Patching
- Replacing failed disks
- Hardware refresh cycles
- Warranty extensions
- Data center staff

AWS handles all infrastructure maintenance, reducing operational costs.

## ⚡ 4. Energy, Cooling, and Space Savings
On‑premises servers require:
- Electricity
- Cooling systems
- Physical space

AWS absorbs these costs in its data centers, lowering your total cost of ownership.

## 🧑‍💼 5. Reduced IT Staffing Costs
Managing physical hardware requires specialized staff.

AWS reduces the need for:
- Hardware technicians
- Network engineers
- Data center operators

Teams can focus on innovation instead of maintenance.

## 🔄 6. Pay Only for What You Use
Examples:
- EC2 billed per second
- Lambda billed per millisecond
- S3 billed per GB stored
- CloudWatch billed per metric/log volume

No idle resources = no wasted money.

## 🧪 7. Faster Experimentation Without Risk
With physical hardware:
- Testing requires buying equipment
- Failed experiments waste money

With AWS:
- Spin up resources in minutes
- Shut them down when done
- Pay only for the test duration

This encourages innovation at low cost.

## 📌 Summary
- **No upfront investment**
- **No over‑provisioning**
- **No maintenance or upgrade costs**
- **Lower staffing and energy expenses**
- **Pay only for actual usage**

AWS turns infrastructure from a **capital expense (CapEx)** into a **flexible operating expense (OpEx)**, saving money and reducing risk.



## AWS Access Types

### Management console access
Human, browser-based access using username/password or SSO (often with MFA) to the AWS Management Console.

**Use when:**
- Administrators or operators need to configure services manually.
- Occasional, interactive tasks (troubleshooting, reviewing logs, editing configs).

---

### Programmatic access (access keys)
Access key ID and secret access key (or temporary STS credentials) used by AWS CLI, SDKs, and automation tools.

**Use when:**
- Scripts, CI/CD pipelines, or external systems call AWS APIs.
- You cannot easily use role-based credentials (for example, legacy systems outside AWS).
- Prefer temporary credentials via roles/STS over long-lived access keys whenever possible.

---

### Federated/SSO access
Users authenticate via an external identity provider (SAML/OIDC) or IAM Identity Center and then assume IAM roles with temporary credentials.

**Use when:**
- You want centralized identity (e.g., corporate AD, Okta, Azure AD).
- You want to avoid managing IAM users and passwords in AWS.
- You need role-based, time-limited access for employees/partners.

---

### Cross-account role access
An identity in one AWS account assumes a role in another account using STS `AssumeRole`.

**Use when:**
- You have multi-account setups (landing zone, dev/test/prod accounts).
- You want central security/operations accounts accessing member accounts.
- You need tightly controlled, auditable cross-account access.

---

## Permission Boundaries in AWS

**What they are**  
Permission boundaries are special IAM policies you attach to a user or role to define the **maximum** permissions that identity can ever have.  
They do not grant permissions by themselves; they only limit what identity-based policies can allow.

**How they work**  
Effective permissions = (identity-based policy allows) **AND** (permission boundary allows).  
Any explicit Deny in any applicable policy still overrides both.

**When to use permission boundaries:**
- You let teams create or manage their own IAM roles/users but must prevent them from granting themselves excessive permissions.
- You want “guardrails” per identity (user/role) in addition to organization-wide controls.
- You delegate IAM management in large organizations while keeping a security ceiling in place.

# S3 Bucket ID vs ARN

This document explains the difference between an **S3 Bucket ID (Name)** and an **S3 Bucket ARN**, when to use each, and how they commonly appear in AWS CLI, IAM policies, and Terraform.

---

## Bucket ID (Bucket Name)

**Example**

```
my-app-bucket-dev
```

### What it is

* The **actual bucket name**
* Globally unique across all AWS accounts
* Used for day‑to‑day operations

### Where it’s used

* AWS CLI commands
* SDKs and application code
* Terraform resource references

### Examples

```bash
aws s3 ls s3://my-app-bucket-dev/
aws s3 cp file.txt s3://my-app-bucket-dev/file.txt
```

```hcl
resource "aws_s3_bucket" "this" {
  bucket = "my-app-bucket-dev"
}
```

```hcl
output "bucket_id" {
  value = aws_s3_bucket.this.id
}
```

> **Note:** In Terraform, `id` for `aws_s3_bucket` is the bucket name itself.

---

## Bucket ARN

**Examples**

```
arn:aws:s3:::my-app-bucket-dev
arn:aws:s3:::my-app-bucket-dev/*
```

### What it is

* An **Amazon Resource Name (ARN)**
* A globally unique identifier used by AWS internally
* Required for **permissions, policies, and cross‑service access**

### Where it’s used

* IAM policies
* S3 bucket policies
* Cross‑service integrations (Lambda, EventBridge, etc.)

### Examples

**IAM policy snippet**

```json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "arn:aws:s3:::my-app-bucket-dev/*"
}
```

**Terraform output**

```hcl
output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
```

---

## When to Use Each

| Use Case                         | Bucket ID (Name) | Bucket ARN |
| -------------------------------- | ---------------- | ---------- |
| AWS CLI (`aws s3 cp`, `ls`)      | ✅                | ❌          |
| Terraform resource config        | ✅                | ❌          |
| Terraform outputs                | ✅                | ✅          |
| IAM policies                     | ❌                | ✅          |
| Bucket policies                  | ❌                | ✅          |
| Lambda / EventBridge permissions | ❌                | ✅          |
| Cross‑account access             | ❌                | ✅          |

---

## Common Pitfalls

❌ **Using bucket name in IAM policies**
IAM requires ARNs — bucket names alone will fail.

❌ **Using ARN in AWS CLI commands**
CLI commands expect `s3://bucket-name`, not ARNs.

❌ **Forgetting object ARNs**
Most object‑level permissions require:

```
arn:aws:s3:::bucket-name/*
```

---

## Quick Mental Model

* **Bucket ID / Name** → *How humans and tools access the bucket*
* **Bucket ARN** → *How AWS controls permissions to the bucket*

> **Rule of thumb:**
> **Operations = Name**
> **Security = ARN**

---

## Terraform Best Practice

Always expose **both** values as outputs:

```hcl
output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}
```

This makes your module easy to consume for both **operational** and **security** use cases.

---

## Summary

* **Bucket Name (ID)** is used for CLI, SDKs, and Terraform resources
* **Bucket ARN** is required for IAM, policies, and cross‑service permissions
* They represent the same bucket, but serve **different purposes**

Both are essential — and both should be clearly documented and exposed in infrastructure code.


