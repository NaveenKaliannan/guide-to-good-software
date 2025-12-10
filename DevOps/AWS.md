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



