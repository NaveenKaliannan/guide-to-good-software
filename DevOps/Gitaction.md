# GitAction

- GitHub Actions (what you called “gitaction”) is a feature of GitHub that automatically runs tasks for your repository, like building, testing, and deploying your code when certain events happen.​
- Watches for events in your repo, such as a push, pull request, or a manual trigger, and starts a workflow when they occur.
- Runs your workflows on virtual machines (Ubuntu, Windows, macOS) where it can execute scripts, tools, and commands (for example: run tests with pytest, build Docker images, deploy to AWS).
- Enables full CI/CD pipelines so every change can be automatically built, tested, and deployed without you doing it manually each time

## Important Files one should be aware of 
- Workflow: A YAML file in .github/workflows/ that describes when to run and what steps to execute
- A group of steps that run on a single runner (VM). Jobs can run in sequence or in parallel
- A single action or shell command (like pip install -r requirements.txt or pytest)
- A reusable piece of logic (like actions/checkout or actions/setup-python) that you can plug into your steps instead of writing everything yourself.​

#### Same deploy job - each runs in a different environment:
- .github/workflows/deploy-github-cloud.yaml
```
deploy:
  runs-on: ubuntu-latest                    # GitHub's cloud Ubuntu VM
  steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 1
        fetch-tags: false
        lfs: false

```
- .github/workflows/deploy-local.yaml (same checkout step)
```
deploy:
  runs-on: ubuntu-latest                    # Simulated locally by act
  steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 1
        fetch-tags: false
        lfs: false
    - name: Test local
      run: echo "Running on YOUR local Linux machine!"
```
- .github/workflows/deploy-aws.yaml AWS Self-Hosted Node. Add this step to your workflow for AWS access (use IAM Role, no passwords): 
copy the complete commands (token embedded) from GitHub UI to your EC2 terminal. Repo → Settings → Actions → Runners → "New self-hosted runner" → Linux → Copy this: Paste ALL on EC2 SSH session. Yes, exactly - once you run the copied commands (with embedded token) on AWS EC2, it becomes a registered self-hosted GitHub Actions runner.
​AWS runner = regular AWS EC2 virtual machine with GitHub runner software installed. IAM role = Temporary permission set that AWS services/users assume to access other AWS resources (S3, VPC, EC2) without passwords/access keys.
After token registration, GitHub Actions can checkout your repo and run ANY code on the EC2. For first case, IAM role is not needed but when using AWS service, IAM role needed.
```
deploy:
  runs-on: [self-hosted, "aws-ec2-large"]
  steps:
    - uses: actions/checkout@v4              # ✅ Downloads your repo to EC2
    - run: ls -la                           # ✅ Runs on EC2
    - run: python -m pytest                 # ✅ Runs on EC2  
    - run: echo "Hello from EC2!"           # ✅ Runs on EC2
    - run: terraform init                   # ✅ Runs on EC2 (init only)
    - run: terraform apply                  # ❌ Needs IAM role (creates VPC)
    - run: aws s3 ls                        # ❌ Needs IAM role (S3 access)
```
```
deploy:
  runs-on: [self-hosted, "aws-ec2-large"]
  steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 1
        fetch-tags: false
        lfs: false
    
    - name: Configure AWS credentials (OIDC - recommended)
      uses: aws-actions/configure-aws-credentials@v4
      with:
        role-to-assume: arn:aws:iam::123456789012:role/GitHubActionsRole
        aws-region: us-east-1

    - name: Test AWS access
      run: aws sts get-caller-identity  # Now works!
```
- AWS_ROLE_ARN and AWS_REGION are stored as GitHub repository secrets. Where secrets go (GitHub UI) : Repo Settings → Secrets and variables → Actions: Click "New repository secret" (twice - one for each)
AWS_ROLE_ARN for arn:aws:iam::123456789012:role/GitHubActionsRole and AWS_REGION for us-east-1.
```
deploy:
  runs-on: [self-hosted, "aws-ec2-large"]
  permissions:
    id-token: write  # Needed for OIDC
    contents: read
  steps:
    - uses: actions/checkout@v4
      with:
        fetch-depth: 1
    
    - name: AWS auth (uses IAM Role)
      uses: aws-actions/configure-aws-credentials@v4
      with:
        role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
        aws-region: ${{ secrets.AWS_REGION }}
    
    - run: echo "AWS ready on self-hosted runner!"
```

# GitHub Actions Self-Hosted Runner on AWS EC2

Run GitHub Actions workflows on your own AWS EC2 instance.

---

## Prerequisites

- AWS EC2 Ubuntu instance (t2.micro or larger)
- EC2 public IP/DNS and `.pem` SSH key
- GitHub repository admin access

---

## Setup

### 1. Get Registration Commands from GitHub

GitHub Repository → Settings → Actions → Runners → **New self-hosted runner** → Linux  
Copy the 5 commands shown (these include a temporary GitHub token).

---

### 2. Connect to EC2

```bash
ssh -i your-key.pem ubuntu@EC2_PUBLIC_IP
```

### Install and Configure the GitHub Runner

Paste the 5 commands you copied from GitHub. They look similar to:
```
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz
tar xzf ./actions-runner-linux-x64.tar.gz
./config.sh --url https://github.com/YOUR_USERNAME/YOUR_REPO --token YOUR_GITHUB_TOKEN
./run.sh
```

### Add Custom Labels (Optional)

Stop the runner (Ctrl + C) and run:
```
echo "self-hosted,aws-ec2-large" >> .runner
./run.sh
```

### Verify Runner Status

Go to:
Repository → Settings → Actions → Runners
You should see:
```
Idle — Labels: self-hosted, aws-ec2-large
```

