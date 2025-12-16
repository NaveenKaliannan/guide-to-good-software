# AWS

# AWS IAM Roles, Access Types, and Permission Boundaries

## AWS IAM Role

An **AWS IAM role** is an identity with permissions that can be assumed by a user, application, or AWS service.  
Example: An EC2 instance assumes a role that allows it to read objects from an S3 bucket without storing long-term access keys on the instance.

**Use an IAM role when:**
- You run code on AWS services (EC2, Lambda, ECS) that must call other AWS APIs.
- You need temporary credentials instead of long-term keys.
- You need cross-account access via `AssumeRole`.

---

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


