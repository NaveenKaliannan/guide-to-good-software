# SeedFarmer

SeedFarmer is a Python-based CLI “orchestration” tool that reads declarative manifests and coordinates deploying, updating, and destroying modular IaC workloads

- Reads deployment manifests that describe modules, their inputs, and their dependency graph, and then plans which modules need to be deployed or updated.
- Calls into CodeSeeder and other tooling to deploy those modules, handling change detection, ordering, and partial updates so only changed modules are redeployed.
- Provides CLI commands (like apply, destroy, status) to manage a complete deployment lifecycle via CI/CD or manually from a developer machine.

## Starting point on AWS

1. CREATE AWS ACCOUNT (e.g., Account ID: 111122223333)
   ↓ (no "nested accounts" - just regular AWS accounts)

2. INSIDE THIS ACCOUNT: Launch EC2 instance 
   - Attach IAM role with Admin permissions (for bootstrap)
   - Name doesn't matter (any name works)

3. SSH to EC2 → Install SeedFarmer:
   ```bash
   pip install seedfarmer
   ```
4.  RUN BOOTSTRAP (creates everything automatically):

```bash
seedfarmer bootstrap toolchain \
  --account 111122223333 \
  --region us-east-1 \
  --project myproj \
  --trusted-principal arn:aws:iam::111122223333:role/EC2-Admin-Role \
  --as-target  # Single account mode
```
5. What Bootstrap Creates in Account 111122223333
- Resource	Location	Purpose
- myproj-toolchain-role	IAM → Roles	SeedFarmer assumes this
- myproj-deployment-role	IAM → Roles	CodeBuild assumes this
- seedfarmer-artifacts-myproj-...	S3 Buckets	Module ZIP storage
- seedfarmer-toolchain-bootstrap-...	CloudFormation/CDK Stacks	All the above
- SSM Parameters	Systems Manager	Deployment state

6. THEN Deploy Your Modules

bash
seedfarmer apply manifests/deployment.yaml

Result: Your S3 buckets, Lambda functions get created in the same account (111122223333).
