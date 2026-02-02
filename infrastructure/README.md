# Terraform Infrastructure as Code

Production-ready Terraform configurations for deploying complete cloud infrastructure on AWS, with patterns applicable to GCP and Azure.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Deployment Guide](#deployment-guide)
- [Modules](#modules)
- [Environment Management](#environment-management)
- [State Management](#state-management)
- [Security Best Practices](#security-best-practices)
- [Cost Optimization](#cost-optimization)
- [Disaster Recovery](#disaster-recovery)
- [Troubleshooting](#troubleshooting)
- [Multi-Cloud Deployment](#multi-cloud-deployment)

## Overview

This Terraform configuration creates a complete production-ready infrastructure including:

- **VPC** with public/private subnets across multiple availability zones
- **RDS PostgreSQL** with automated backups and Multi-AZ support
- **ElastiCache Redis** for caching with encryption
- **ECS Fargate** for serverless container orchestration
- **Application Load Balancer** with SSL/TLS termination
- **S3** for object storage with versioning and lifecycle policies
- **CloudWatch** for monitoring and alerting
- **IAM** roles and policies with least-privilege access
- **Route53** for DNS management
- **ACM** for SSL/TLS certificate management
- **Secrets Manager** for secure secret storage

## Quick Start

```bash
# 1. Clone and navigate to infrastructure directory
cd infrastructure

# 2. Initialize Terraform
terraform init

# 3. Copy example configuration
cp environments/production/terraform.tfvars.example terraform.tfvars

# 4. Edit terraform.tfvars with your values
vim terraform.tfvars

# 5. Validate configuration
terraform validate

# 6. Plan deployment
terraform plan

# 7. Apply configuration
terraform apply

# 8. View outputs
terraform output
```

## Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                          AWS Cloud                           │
│                                                               │
│  ┌────────────────────────────────────────────────────────┐ │
│  │                    VPC (10.0.0.0/16)                    │ │
│  │                                                          │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │         Public Subnets (3 AZs)                    │  │ │
│  │  │                                                    │  │ │
│  │  │  ┌───────────────────┐  ┌──────────────────┐     │  │ │
│  │  │  │  Internet Gateway │  │  NAT Gateway (3) │     │  │ │
│  │  │  └───────────────────┘  └──────────────────┘     │  │ │
│  │  │                                                    │  │ │
│  │  │  ┌─────────────────────────────────────────┐     │  │ │
│  │  │  │ Application Load Balancer (ALB)          │     │  │ │
│  │  │  │ - SSL/TLS Termination (ACM)              │     │  │ │
│  │  │  │ - Health Checks                           │     │  │ │
│  │  │  └─────────────────────────────────────────┘     │  │ │
│  │  └────────────────────────────────────────────────── │  │ │
│  │                                                          │ │
│  │  ┌──────────────────────────────────────────────────┐  │ │
│  │  │         Private Subnets (3 AZs)                   │  │ │
│  │  │                                                    │  │ │
│  │  │  ┌─────────────────────────────────────────┐     │  │ │
│  │  │  │ ECS Fargate Tasks (2-10 instances)      │     │  │ │
│  │  │  │ - Auto-scaling (CPU/Memory based)        │     │  │ │
│  │  │  │ - CloudWatch Logs                        │     │  │ │
│  │  │  └─────────────────────────────────────────┘     │  │ │
│  │  │                                                    │  │ │
│  │  │  ┌─────────────────────────────────────────┐     │  │ │
│  │  │  │ RDS PostgreSQL (Multi-AZ)                │     │  │ │
│  │  │  │ - Automated Backups (30 days)            │     │  │ │
│  │  │  │ - Encryption at Rest                     │     │  │ │
│  │  │  │ - Performance Insights                   │     │  │ │
│  │  │  └─────────────────────────────────────────┘     │  │ │
│  │  │                                                    │  │ │
│  │  │  ┌─────────────────────────────────────────┐     │  │ │
│  │  │  │ ElastiCache Redis Cluster                │     │  │ │
│  │  │  │ - Encryption (at-rest & in-transit)      │     │  │ │
│  │  │  │ - Multi-AZ with automatic failover       │     │  │ │
│  │  │  └─────────────────────────────────────────┘     │  │ │
│  │  └────────────────────────────────────────────────── │  │ │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  Supporting Services                                    │ │
│  │  - Route53 (DNS)                                        │ │
│  │  - ACM (SSL Certificates)                               │ │
│  │  - S3 (Object Storage)                                  │ │
│  │  - Secrets Manager (Secrets)                            │ │
│  │  - CloudWatch (Monitoring & Logs)                       │ │
│  │  - IAM (Roles & Policies)                               │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Resource Relationships

```yaml
VPC:
  Creates:
    - Public Subnets (3 AZs)
    - Private Subnets (3 AZs)
    - Internet Gateway
    - NAT Gateways (3)
    - Route Tables
    - Security Groups (ALB, App, Database, Cache)
    - VPC Flow Logs

ALB:
  Depends on: VPC
  Uses:
    - Public Subnets
    - ALB Security Group
    - ACM Certificate
  Routes to: ECS Tasks

ECS Fargate:
  Depends on: VPC, ALB, RDS, ElastiCache
  Uses:
    - Private Subnets
    - App Security Group
    - IAM Roles (Execution, Task)
    - Secrets Manager
  Connects to:
    - RDS (Database)
    - ElastiCache (Cache)
    - S3 (Storage)

RDS PostgreSQL:
  Depends on: VPC
  Uses:
    - Private Subnets
    - Database Security Group
  Features:
    - Multi-AZ for high availability
    - Automated backups
    - Encryption at rest
    - Performance Insights

ElastiCache Redis:
  Depends on: VPC
  Uses:
    - Private Subnets
    - Cache Security Group
  Features:
    - Cluster mode with sharding
    - Automatic failover
    - Encryption (at-rest & in-transit)
```

## Prerequisites

### Required Tools

1. **Terraform** >= 1.6.0
   ```bash
   # Install Terraform
   curl -fsSL https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip -o terraform.zip
   unzip terraform.zip
   sudo mv terraform /usr/local/bin/
   terraform version
   ```

2. **AWS CLI** >= 2.0
   ```bash
   # Install AWS CLI
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   aws --version
   ```

3. **AWS Account** with appropriate permissions

### AWS Credentials

```bash
# Configure AWS credentials
aws configure

# Or use environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"

# Or use AWS IAM roles (recommended for CI/CD)
```

### Required IAM Permissions

Your AWS user/role needs permissions to create:
- VPC, Subnets, Internet Gateway, NAT Gateway, Route Tables, Security Groups
- RDS instances, DB subnet groups
- ElastiCache clusters, subnet groups
- ECS clusters, services, task definitions
- ALB, target groups, listeners
- S3 buckets
- IAM roles and policies
- Route53 hosted zones and records
- ACM certificates
- CloudWatch log groups, alarms
- Secrets Manager secrets

Minimum policy: `PowerUserAccess` or custom policy with all above permissions.

## Directory Structure

```
infrastructure/
├── main.tf                    # Root configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Output values
├── terraform.tfvars           # Variable values (gitignored)
│
├── modules/                   # Reusable Terraform modules
│   ├── vpc/                  # VPC with subnets, IGW, NAT
│   ├── rds/                  # RDS PostgreSQL
│   ├── elasticache/          # ElastiCache Redis
│   ├── ecs/                  # ECS Fargate
│   ├── alb/                  # Application Load Balancer
│   ├── s3/                   # S3 buckets
│   ├── iam/                  # IAM roles and policies
│   ├── cloudwatch/           # Monitoring and logging
│   ├── route53/              # DNS management
│   └── acm/                  # SSL/TLS certificates
│
├── environments/              # Environment-specific configurations
│   ├── dev/
│   │   └── terraform.tfvars.example
│   ├── staging/
│   │   └── terraform.tfvars.example
│   └── production/
│       └── terraform.tfvars.example
│
└── README.md                  # This file
```

## Deployment Guide

### Step 1: Initialize Terraform

```bash
cd infrastructure
terraform init

# Initialize with backend (S3 + DynamoDB for state locking)
# terraform init -backend-config="bucket=your-state-bucket" \
#                -backend-config="key=production/terraform.tfstate" \
#                -backend-config="region=us-east-1"
```

### Step 2: Configure Variables

```bash
# Copy example configuration
cp environments/production/terraform.tfvars.example terraform.tfvars

# Edit with your values
vim terraform.tfvars
```

**Required variables:**
- `db_username` - Database username
- `db_password` - Strong database password (16+ characters)
- `redis_auth_token` - Redis auth token (16+ characters)
- `jwt_secret` - JWT secret (32+ characters)
- `container_image` - ECR image URL
- `app_domain` - Your domain name

### Step 3: Validate Configuration

```bash
# Format code
terraform fmt -recursive

# Validate syntax
terraform validate

# Security check (optional)
# tfsec .
# checkov -d .
```

### Step 4: Plan Deployment

```bash
# See what will be created
terraform plan

# Save plan to file
terraform plan -out=tfplan

# Review plan details
terraform show tfplan
```

### Step 5: Deploy Infrastructure

```bash
# Apply configuration
terraform apply

# Or apply saved plan
terraform apply tfplan

# Auto-approve (use with caution)
# terraform apply -auto-approve
```

### Step 6: Verify Deployment

```bash
# View outputs
terraform output

# Get specific output
terraform output alb_dns_name

# Test database connection
aws rds describe-db-instances --db-instance-identifier myapp-production-db

# Test ECS service
aws ecs describe-services --cluster myapp-production-cluster \
  --services myapp-production-service

# Access application
curl https://$(terraform output -raw app_domain)
```

## Modules

### VPC Module (`modules/vpc`)

Creates a complete VPC with public/private subnets, NAT gateways, and security groups.

**Features:**
- Multi-AZ deployment (3 availability zones)
- Public subnets for ALB
- Private subnets for ECS, RDS, ElastiCache
- NAT gateways for outbound internet access
- Security groups with least-privilege rules
- VPC Flow Logs for network monitoring

**Usage:**
```hcl
module "vpc" {
  source = "./modules/vpc"

  project_name       = "myapp"
  environment        = "production"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway = true
}
```

### RDS Module (`modules/rds`)

PostgreSQL database with automated backups, Multi-AZ, and encryption.

**Features:**
- PostgreSQL 18.1+
- Automated backups with configurable retention
- Multi-AZ for high availability (production)
- Encryption at rest (AES-256)
- Performance Insights
- CloudWatch Logs integration
- Automated minor version upgrades

**Usage:**
```hcl
module "database" {
  source = "./modules/rds"

  identifier        = "myapp-db"
  engine            = "postgres"
  engine_version    = "18.1"
  instance_class    = "db.t3.medium"
  allocated_storage = 100

  database_name = "appdb"
  username      = var.db_username
  password      = var.db_password

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  backup_retention_period = 30
  multi_az                = true
}
```

### ElastiCache Module (`modules/elasticache`)

Redis cluster with encryption and automatic failover.

**Features:**
- Redis 7.1+ with cluster mode
- Encryption at rest and in transit
- Automatic failover (Multi-AZ)
- Auth token for authentication
- Automated backups
- CloudWatch metrics

**Usage:**
```hcl
module "cache" {
  source = "./modules/elasticache"

  cluster_id  = "myapp-cache"
  engine      = "redis"
  node_type   = "cache.t3.medium"
  num_nodes   = 3

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = var.redis_auth_token
}
```

### ECS Module (`modules/ecs`)

ECS Fargate for serverless container orchestration with auto-scaling.

**Features:**
- ECS Fargate (serverless containers)
- Auto-scaling based on CPU/memory
- Integration with ALB
- CloudWatch Logs
- Secrets Manager integration
- IAM task roles

**Usage:**
```hcl
module "ecs" {
  source = "./modules/ecs"

  cluster_name    = "myapp-cluster"
  service_name    = "myapp-service"
  container_image = "123456789012.dkr.ecr.us-east-1.amazonaws.com/myapp:latest"
  container_port  = 3000

  task_cpu    = 1024
  task_memory = 2048

  desired_count = 3
  min_capacity  = 2
  max_capacity  = 10

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids

  target_group_arn = module.alb.target_group_arn
}
```

### ALB Module (`modules/alb`)

Application Load Balancer with SSL/TLS termination.

**Features:**
- SSL/TLS termination via ACM
- HTTP to HTTPS redirect
- Health checks
- Connection draining
- Access logs to S3
- Cross-zone load balancing

**Usage:**
```hcl
module "alb" {
  source = "./modules/alb"

  name       = "myapp-alb"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids

  certificate_arn = module.acm.certificate_arn

  health_check_path = "/health"
  target_group_port = 3000
}
```

## Environment Management

### Development Environment

```bash
# Use development configuration
cp environments/dev/terraform.tfvars.example terraform.tfvars

# Deploy
terraform workspace new dev
terraform apply

# Characteristics:
# - Single AZ
# - db.t3.micro (RDS)
# - cache.t3.micro (Redis)
# - 1 ECS task
# - No Multi-AZ
# - 1-day backup retention
```

### Staging Environment

```bash
# Use staging configuration
cp environments/staging/terraform.tfvars.example terraform.tfvars

# Deploy
terraform workspace new staging
terraform apply

# Characteristics:
# - 2 AZs
# - db.t3.small (RDS)
# - cache.t3.small (Redis)
# - 2 ECS tasks
# - 7-day backup retention
```

### Production Environment

```bash
# Use production configuration
cp environments/production/terraform.tfvars.example terraform.tfvars

# Deploy
terraform workspace new production
terraform apply

# Characteristics:
# - 3 AZs
# - db.t3.medium+ (RDS)
# - cache.t3.medium+ (Redis)
# - 3-10 ECS tasks (auto-scaling)
# - Multi-AZ enabled
# - 30-day backup retention
# - Deletion protection
```

## State Management

### Local State (Development)

```hcl
# No backend configuration
# State stored in terraform.tfstate locally
```

### Remote State (Production)

```hcl
# terraform.tf
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

**Setup S3 Backend:**

```bash
# Create S3 bucket for state
aws s3 mb s3://your-terraform-state-bucket --region us-east-1

# Enable versioning
aws s3api put-bucket-versioning \
  --bucket your-terraform-state-bucket \
  --versioning-configuration Status=Enabled

# Enable encryption
aws s3api put-bucket-encryption \
  --bucket your-terraform-state-bucket \
  --server-side-encryption-configuration \
  '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Create DynamoDB table for state locking
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

## Security Best Practices

### Secret Management

```bash
# NEVER commit secrets to git
echo "terraform.tfvars" >> .gitignore
echo "*.tfstate*" >> .gitignore

# Use environment variables
export TF_VAR_db_password="strong-password"
export TF_VAR_jwt_secret="32-char-secret"

# Or use AWS Secrets Manager
aws secretsmanager create-secret \
  --name myapp-db-password \
  --secret-string "strong-password"
```

### IAM Best Practices

```yaml
Least Privilege:
  - Grant minimum required permissions
  - Use IAM roles instead of access keys
  - Enable MFA for sensitive operations

Task Roles:
  - Separate execution role (pull images, write logs)
  - Separate task role (application permissions)
  - No hardcoded credentials in containers

Service Accounts:
  - Use IRSA (IAM Roles for Service Accounts) in EKS
  - Rotate credentials regularly
```

### Network Security

```yaml
Security Groups:
  - Deny all by default
  - Allow only required ports
  - Use security group references (not CIDR blocks)

Private Subnets:
  - Place databases in private subnets
  - Use NAT gateway for outbound internet access
  - No direct internet access to private resources

VPC Flow Logs:
  - Enable flow logs for network monitoring
  - Send to CloudWatch Logs
  - Analyze for security threats
```

## Cost Optimization

### Development Environment

```yaml
Cost Savings:
  - Use db.t3.micro ($15/month)
  - Use cache.t3.micro ($12/month)
  - Single AZ deployment
  - 1-day backup retention
  - Disable Multi-AZ

Estimated Cost: ~$50-75/month
```

### Production Environment

```yaml
Cost Optimization:
  - Use Reserved Instances (40-60% savings)
  - Enable auto-scaling (pay for what you use)
  - Use S3 Intelligent-Tiering
  - Enable cost allocation tags
  - Review CloudWatch retention periods

Estimated Cost: ~$300-500/month (without Reserved Instances)
Estimated Cost: ~$180-300/month (with Reserved Instances)
```

### Cost Monitoring

```bash
# Enable cost allocation tags
aws ce update-cost-allocation-tags-status \
  --cost-allocation-tags-status TagKey=Project,Status=Active

# Create budget alerts
aws budgets create-budget \
  --account-id 123456789012 \
  --budget file://budget.json \
  --notifications-with-subscribers file://notifications.json

# View cost breakdown
aws ce get-cost-and-usage \
  --time-period Start=2026-02-01,End=2026-02-28 \
  --granularity MONTHLY \
  --metrics "BlendedCost" "UnblendedCost"
```

## Disaster Recovery

### Backup Strategy

```yaml
RDS Backups:
  - Automated daily backups
  - 30-day retention (production)
  - Cross-region backup replication (optional)
  - Manual snapshots before major changes

ElastiCache Backups:
  - Automated daily backups
  - 7-day retention
  - Manual snapshots for cluster upgrades

Infrastructure as Code:
  - Terraform state backed up to S3
  - State versioning enabled
  - Git repository for configuration
```

### Recovery Procedures

```bash
# Restore RDS from snapshot
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier myapp-db-restored \
  --db-snapshot-identifier myapp-db-snapshot-2026-02-01

# Restore ElastiCache from backup
aws elasticache create-cache-cluster \
  --cache-cluster-id myapp-cache-restored \
  --snapshot-name myapp-cache-backup-2026-02-01

# Recreate infrastructure from Terraform
terraform init
terraform apply -auto-approve
```

### Cross-Region Disaster Recovery

```hcl
# Enable cross-region replication for RDS
resource "aws_db_instance_automated_backups_replication" "default" {
  source_db_instance_arn = aws_db_instance.main.arn
  retention_period       = 30
}

# Replicate Terraform state to secondary region
terraform {
  backend "s3" {
    bucket = "your-state-bucket"
    key    = "production/terraform.tfstate"
    region = "us-east-1"

    # Enable replication in S3 bucket configuration
  }
}
```

## Troubleshooting

### Common Issues

**Issue: "Error creating VPC: VpcLimitExceeded"**
```bash
# Check VPC limit
aws service-quotas get-service-quota \
  --service-code vpc \
  --quota-code L-F678F1CE

# Request limit increase
aws service-quotas request-service-quota-increase \
  --service-code vpc \
  --quota-code L-F678F1CE \
  --desired-value 10
```

**Issue: "Error: cannot delete non-empty S3 bucket"**
```bash
# Empty bucket before terraform destroy
aws s3 rm s3://your-bucket-name --recursive

# Or force destroy (if configured in Terraform)
terraform destroy -target=module.s3
```

**Issue: "Error: database already exists"**
```bash
# Import existing resource
terraform import module.database.aws_db_instance.main myapp-db

# Or destroy and recreate (data loss!)
terraform destroy -target=module.database
terraform apply
```

### Debugging Commands

```bash
# Enable debug logging
export TF_LOG=DEBUG
terraform apply

# Verify AWS credentials
aws sts get-caller-identity

# Check resource limits
aws service-quotas list-service-quotas --service-code ec2

# View Terraform state
terraform show

# List all resources
terraform state list

# Inspect specific resource
terraform state show module.vpc.aws_vpc.main
```

## Multi-Cloud Deployment

### Google Cloud Platform (GCP)

```hcl
# Configure GCP provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Equivalent resources:
# VPC → Google VPC
# RDS → Cloud SQL
# ElastiCache → Memorystore
# ECS → Cloud Run / GKE
# ALB → Cloud Load Balancing
# S3 → Cloud Storage
```

### Microsoft Azure

```hcl
# Configure Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Equivalent resources:
# VPC → Virtual Network
# RDS → Azure Database for PostgreSQL
# ElastiCache → Azure Cache for Redis
# ECS → Azure Container Instances / AKS
# ALB → Azure Load Balancer / Application Gateway
# S3 → Azure Blob Storage
```

## Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [AWS Reference Architectures](https://aws.amazon.com/architecture/)

## Support

For issues or questions:
- Review [Troubleshooting](#troubleshooting) section
- Check Terraform state: `terraform show`
- View AWS resources: AWS Console
- Check CloudWatch logs for application errors

## License

This Terraform configuration is part of the Universal Project Prompt and is licensed under the MIT License.
