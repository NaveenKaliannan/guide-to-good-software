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


SeedFarmer: The AWS IaC Orchestration Masterpiece
The Vision: Ending Terraform Chaos

SeedFarmer was born from AWS Labs to solve the nightmare of enterprise infrastructure deployments. Picture this: teams scattered across accounts, manually running terraform apply, fighting state file conflicts, fumbling credentials, and sequencing 50+ modules across dev/staging/prod. SeedFarmer transforms this chaos into a GitOps symphony—one manifest, automatic ordering, credential-less deployments, cross-account isolation.
Architecture: The Dual-Role Dance

SeedFarmer's genius lies in its two-role separation—like a conductor (toolchain-role) directing builders (deployment-role):

text
TOOLCHAIN ACCOUNT (Control Plane)        TARGET ACCOUNTS (Workspaces)
├── myproj-toolchain-role     ← GitHub/EC2 assumes
│   └── Permissions: Coordination only
│       • Triggers CodeBuild jobs
│       • Reads SSM deployment state  
│       • Assumes deployment-roles cross-account
│
├── S3 Artifact Buckets       ← Module ZIP storage
├── CodeBuild Packagers       ← Creates deployment ZIPs
└── SSM Parameters            ← Tracks what modules deployed where

Target accounts contain identical myproj-deployment-role + their own CodeBuild projects that actually run Terraform.
Act I: Bootstrap - Building the Factory

Single command creates everything:

bash
seedfarmer bootstrap toolchain \
  --account 111122223333 \
  --project myproj \
  --trusted-principal arn:aws:iam::111122223333:role/EC2-Admin-Role

CDK magic deploys:

text
✅ myproj-toolchain-role → Trust policy allows YOUR EC2/GitHub
✅ myproj-deployment-role → Trust policy allows CodeBuild service  
✅ S3: seedfarmer-artifacts-myproj-xyz (module staging)
✅ CodeBuild: seedfarmer-toolchain-packager (ZIP creator)
✅ SSM: /seedfarmer/myproj/config (deployment registry)
✅ CloudFormation stacks tracking everything

--as-target creates both roles in same account (dev). Multi-account? Bootstrap targets separately.
Act II: The Manifest - Infrastructure Lego

text
configuration:
  target: { env: "prod" }
deployment_groups:
- name: core
  targets:
    prod:
      modules:
      - name: vpc          # modules/vpc/main.tf
        depends_on: []
      - name: s3-storage   # modules/s3/main.tf  
        depends_on: [vpc]
      - name: lambda-api   # modules/lambda/main.tf
        depends_on: [vpc, s3-storage]

Each module = self-contained Terraform directory (main.tf, deployspec.yaml).
Act III: Apply - The Invisible Automation

seedfarmer apply manifest.yaml executes this choreography:

text
1. PARSE → Builds dependency graph: vpc → s3 → lambda
2. PACKAGE → ZIP modules/vpc/ → vpc-module.zip → S3 artifacts  
3. ORCHESTRATE → toolchain-role triggers target CodeBuild
4. EXECUTE → CodeBuild downloads ZIP → terraform init/plan/apply
5. RECORD → SSM state: "vpc=deployed@2026-01-05T12:00Z"

The Role Journey: Who Does What

text
GitHub Actions/EC2 ─┬→ configure-aws-credentials → myproj-toolchain-role
                    │
                    └──→ (1hr temp credentials via OIDC/instance metadata)
                          ↓
toolchain-role ──────┬→ codebuild:StartBuild(project=seedfarmer-target-deployer)
                     │
                     └──→ sts:AssumeRole(myproj-deployment-role) → service role
                          ↓
CodeBuild Container ─→ terraform apply (runs AS deployment-role)
                          ↓
AWS Services ────────→ ✅ VPC + S3 + Lambda created

Multi-Account Mastery

text
MANAGEMENT (111122223333)
└── TOOLCHAIN orchestrates → 

PROD (444455556666)     DEV (777788889999)
├── deployment-role    ├── deployment-role
├── CodeBuild          ├── CodeBuild
└── YOUR S3/Lambda     └── YOUR S3/Lambda

Manifest targets map modules → accounts. toolchain-role assumes deployment-role cross-account.
GitHub Actions Integration (Credential-Less)

text
- uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::111122223333:role/myproj-toolchain-role
# OIDC token → sts:AssumeRoleWithWebIdentity → toolchain-role → seedfarmer apply

Zero AWS keys stored. GitHub's OIDC provider in IAM trusts your repo.
The Security Model: Least Privilege Perfected

text
toolchain-role (narrow):
✅ codebuild:StartBuild
✅ ssm:GetParametersByPath
✅ sts:AssumeRole(deployment-*)
❌ s3:CreateBucket ✗
❌ lambda:CreateFunction ✗

deployment-role (broad):
✅ s3:* lambda:* ec2:* iam:* (Terraform needs everything)
✅ Runs ONLY in isolated CodeBuild container

Blast radius contained: Compromised GitHub runner gets coordination powers only.
Change Detection Intelligence

text
❌ Changed: modules/lambda/main.tf → redeploy lambda ONLY
✅ Unchanged: modules/vpc/main.tf → skip (state verified)
✅ Dependencies honored: s3-storage → lambda-api

Partial deployments = fast CI/CD.
The Complete Transformation

text
BEFORE SeedFarmer:
👨‍💻 terraform init/plan/apply × 50 modules
👨‍💻 Credential hell across accounts  
👨‍💻 Manual dependency ordering
👨‍💻 State file conflicts

AFTER SeedFarmer:
git push → seedfarmer apply → ✅ Done

SeedFarmer = Terraform's missing enterprise layer. It doesn't run Terraform—it orchestrates it across accounts with perfect role separation, GitOps triggers, and zero credential management. Your infrastructure becomes someone else's problem. 

odeBuild Distribution: Toolchain vs Target

text
SEEDFARNER BOOTSTRAP creates:
├── TOOLCHAIN ACCOUNT CodeBuild:
│   └── seedfarmer-toolchain-packager  
│       Purpose: ZIP creation + module packaging
│
└── TARGET ACCOUNT CodeBuild:
    └── seedfarmer-target-deployer  
        Purpose: terraform init/plan/apply execution

The Two-Phase Execution Pipeline

text
GitHub Runner (toolchain-role) → seedfarmer apply
         ↓ PHASE 1: TOOLCHAIN CODEBUILD
toolchain-role → triggers: seedfarmer-toolchain-packager
    📦 ZIP modules/s3/ → s3-module.zip
    📤 Upload → s3://seedfarmer-artifacts-myproj-xyz/
         ↓ PHASE 2: TARGET CODEBUILD  
toolchain-role → cross-account → seedfarmer-target-deployer
    📥 Download s3-module.zip
    🏗️  terraform init/plan/apply (AS deployment-role)
    ✅ Creates S3 bucket

Visual Workflow

text
1. TOOLCHAIN PACKAGING (toolchain account)

bash
# Runs in seedfarmer-toolchain-packager CodeBuild (toolchain-role)
cd modules/s3/
zip -r s3-module.zip main.tf variables.tf deployspec.yaml
aws s3 cp s3-module.zip s3://seedfarmer-artifacts-myproj-xyz/

text
2. TARGET EXECUTION (target account)  

bash
# Runs in seedfarmer-target-deployer CodeBuild (deployment-role)
aws s3 cp s3://seedfarmer-artifacts-myproj-xyz/s3-module.zip .
unzip s3-module.zip && cd s3/
terraform init
terraform plan
terraform apply -auto-approve
# ✅ S3 bucket created in TARGET account

Perfect Role + Location Separation

text
TOOLCHAIN ACCOUNT (111122223333):
├── toolchain-role     → Runs packaging CodeBuild
└── seedfarmer-toolchain-packager → Creates ZIPs

TARGET ACCOUNT (444455556666):
├── deployment-role   → Runs execution CodeBuild  
└── seedfarmer-target-deployer → Runs terraform apply

Your understanding is spot-on: Toolchain CodeBuild = packaging/shipping. Target CodeBuild = actual Terraform execution + infrastructure creation. Beautiful separation of concerns!


- uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::111122223333:role/myproj-toolchain-role

The action sets temporary AWS credentials as ENVIRONMENT VARIABLES only—no files are created or modified:

text
Fresh Ubuntu runner starts (no .aws/ folder)
    ↓ aws-actions/configure-aws-credentials@v4
GitHub OIDC token → sts:AssumeRoleWithWebIdentity → myproj-toolchain-role
    ↓ Sets these environment variables (1hr lifetime):
export AWS_ACCESS_KEY_ID=ASIAXABC123...
export AWS_SECRET_ACCESS_KEY=wJalrXU...
export AWS_SESSION_TOKEN=IQoJb3JpZ2lu...
export AWS_DEFAULT_REGION=us-east-1
    ↓ seedfarmer CLI reads env vars → works perfectly

Verify on the Runner

bash
# During GitHub Actions (after configure-aws-credentials)
ls -la ~/.aws/           # Empty - no credentials folder
aws sts get-caller-identity  # Shows toolchain-role
env | grep AWS_          # Shows 4 environment variables

Clean Ephemeral Nature

text
GitHub Job starts → Fresh Ubuntu → No .aws/ folder
↓ configure-aws-credentials → Environment variables set
↓ seedfarmer apply → Uses env vars
↓ Job ends → Environment variables destroyed
↓ Fresh runner for next job → Clean slate

Why Environment Variables (Not Files)?

text
✅ Environment vars = Inherited by all child processes (pip, seedfarmer)
✅ No disk writes = Ephemeral GitHub runners stay clean  
✅ No cleanup needed = Automatically destroyed when job ends
✅ AWS SDK auto-detects = AWS_ACCESS_KEY_ID > ~/.aws/credentials

File vs Environment Precedence (AWS SDK)

text
1. Environment variables (AWS_ACCESS_KEY_ID) ← Used here
2. ~/.aws/credentials  
3. Instance metadata service
4. IAM roles

Result: GitHub runner gets toolchain-role temporary credentials via environment variables (no files created). seedfarmer apply reads these env vars and orchestrates deployment. Perfectly clean, ephemeral, secure.

text
No ~/.aws/credentials → No secrets on disk → Zero cleanup → GitOps perfection
