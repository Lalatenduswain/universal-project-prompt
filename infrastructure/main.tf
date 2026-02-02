# Main Terraform configuration for production-ready infrastructure
# This file orchestrates all infrastructure modules

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend configuration for remote state storage
  # Uncomment and configure for production use
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "production/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      CreatedAt   = timestamp()
    }
  }
}

# VPC Module - Networking foundation
module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
}

# RDS PostgreSQL Module - Primary database
module "database" {
  source = "./modules/rds"

  identifier              = "${var.project_name}-${var.environment}-db"
  engine                  = "postgres"
  engine_version          = var.postgres_version
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  max_allocated_storage   = var.db_max_allocated_storage
  storage_encrypted       = true

  database_name = var.db_name
  username      = var.db_username
  password      = var.db_password

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.database_security_group_id]

  backup_retention_period   = var.db_backup_retention_period
  backup_window             = var.db_backup_window
  maintenance_window        = var.db_maintenance_window
  multi_az                  = var.environment == "production"
  deletion_protection       = var.environment == "production"
  skip_final_snapshot       = var.environment != "production"
  final_snapshot_identifier = "${var.project_name}-${var.environment}-final-snapshot"

  performance_insights_enabled = var.environment == "production"
  monitoring_interval          = 60
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Name = "${var.project_name}-${var.environment}-database"
  }
}

# ElastiCache Redis Module - Caching layer
module "cache" {
  source = "./modules/elasticache"

  cluster_id           = "${var.project_name}-${var.environment}-cache"
  engine               = "redis"
  engine_version       = var.redis_version
  node_type            = var.redis_node_type
  num_cache_nodes      = var.redis_num_nodes
  parameter_group_name = var.redis_parameter_group
  port                 = 6379

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.cache_security_group_id]

  at_rest_encryption_enabled = true
  transit_encryption_enabled = true
  auth_token                 = var.redis_auth_token

  snapshot_retention_limit = var.environment == "production" ? 7 : 1
  snapshot_window          = "03:00-05:00"
  maintenance_window       = "sun:05:00-sun:07:00"

  automatic_failover_enabled = var.environment == "production"
  multi_az_enabled           = var.environment == "production"

  tags = {
    Name = "${var.project_name}-${var.environment}-cache"
  }
}

# Application Load Balancer Module
module "alb" {
  source = "./modules/alb"

  name            = "${var.project_name}-${var.environment}-alb"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  security_groups = [module.vpc.alb_security_group_id]

  enable_deletion_protection = var.environment == "production"
  enable_http2               = true
  enable_cross_zone_load_balancing = true

  # SSL/TLS configuration
  certificate_arn = module.acm.certificate_arn

  # Target group configuration
  target_group_name     = "${var.project_name}-${var.environment}-tg"
  target_group_port     = var.app_port
  target_group_protocol = "HTTP"
  health_check_path     = "/health"
  health_check_interval = 30
  health_check_timeout  = 5
  healthy_threshold     = 2
  unhealthy_threshold   = 3

  tags = {
    Name = "${var.project_name}-${var.environment}-alb"
  }
}

# ECS Fargate Module - Serverless compute
module "ecs" {
  source = "./modules/ecs"

  cluster_name = "${var.project_name}-${var.environment}-cluster"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids

  # Service configuration
  service_name       = "${var.project_name}-${var.environment}-service"
  task_family        = "${var.project_name}-${var.environment}-task"
  container_name     = var.project_name
  container_image    = var.container_image
  container_port     = var.app_port
  task_cpu           = var.ecs_task_cpu
  task_memory        = var.ecs_task_memory

  # Environment variables
  environment_variables = [
    {
      name  = "NODE_ENV"
      value = var.environment
    },
    {
      name  = "PORT"
      value = tostring(var.app_port)
    },
    {
      name  = "DATABASE_HOST"
      value = module.database.endpoint
    },
    {
      name  = "REDIS_HOST"
      value = module.cache.endpoint
    }
  ]

  # Secrets from Parameter Store/Secrets Manager
  secrets = [
    {
      name      = "DATABASE_URL"
      valueFrom = aws_secretsmanager_secret.database_url.arn
    },
    {
      name      = "JWT_SECRET"
      valueFrom = aws_secretsmanager_secret.jwt_secret.arn
    }
  ]

  # Auto-scaling configuration
  desired_count    = var.ecs_desired_count
  min_capacity     = var.ecs_min_capacity
  max_capacity     = var.ecs_max_capacity
  target_cpu       = 70
  target_memory    = 80

  # Load balancer integration
  target_group_arn = module.alb.target_group_arn

  # Security groups
  security_group_ids = [module.vpc.app_security_group_id]

  # Logging
  log_group_name         = "/ecs/${var.project_name}-${var.environment}"
  log_retention_in_days  = var.environment == "production" ? 90 : 7

  # IAM roles
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn

  tags = {
    Name = "${var.project_name}-${var.environment}-ecs"
  }
}

# S3 Module - Object storage
module "s3" {
  source = "./modules/s3"

  bucket_name = "${var.project_name}-${var.environment}-storage"

  enable_versioning = var.environment == "production"
  enable_encryption = true

  lifecycle_rules = [
    {
      id      = "archive-old-versions"
      enabled = true

      noncurrent_version_transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]

      noncurrent_version_expiration = {
        days = 365
      }
    }
  ]

  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["GET", "PUT", "POST", "DELETE"]
      allowed_origins = [var.app_domain]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-storage"
  }
}

# CloudWatch Module - Monitoring and logging
module "cloudwatch" {
  source = "./modules/cloudwatch"

  project_name = var.project_name
  environment  = var.environment

  # Alarms for critical metrics
  alarms = [
    {
      name                = "high-cpu-utilization"
      metric_name         = "CPUUtilization"
      namespace           = "AWS/ECS"
      statistic           = "Average"
      threshold           = 80
      evaluation_periods  = 2
      period              = 300
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name                = "high-memory-utilization"
      metric_name         = "MemoryUtilization"
      namespace           = "AWS/ECS"
      statistic           = "Average"
      threshold           = 80
      evaluation_periods  = 2
      period              = 300
      comparison_operator = "GreaterThanThreshold"
    },
    {
      name                = "database-connections-high"
      metric_name         = "DatabaseConnections"
      namespace           = "AWS/RDS"
      statistic           = "Average"
      threshold           = 80
      evaluation_periods  = 2
      period              = 300
      comparison_operator = "GreaterThanThreshold"
    }
  ]

  # SNS topic for alerts
  sns_topic_name = "${var.project_name}-${var.environment}-alerts"
  sns_endpoints  = var.alert_emails

  tags = {
    Name = "${var.project_name}-${var.environment}-monitoring"
  }
}

# IAM Module - Identity and access management
module "iam" {
  source = "./modules/iam"

  project_name = var.project_name
  environment  = var.environment

  # ECS task execution role (pulls images, writes logs)
  ecs_execution_role_policies = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]

  # ECS task role (application permissions)
  ecs_task_role_policies = []

  # S3 bucket access for task role
  s3_bucket_arn = module.s3.bucket_arn

  # Secrets Manager access
  secrets_arns = [
    aws_secretsmanager_secret.database_url.arn,
    aws_secretsmanager_secret.jwt_secret.arn
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-iam"
  }
}

# ACM Module - SSL/TLS certificates
module "acm" {
  source = "./modules/acm"

  domain_name               = var.app_domain
  subject_alternative_names = var.domain_aliases
  validation_method         = "DNS"

  # Route53 zone for DNS validation
  route53_zone_id = module.route53.zone_id

  tags = {
    Name = "${var.project_name}-${var.environment}-certificate"
  }
}

# Route53 Module - DNS management
module "route53" {
  source = "./modules/route53"

  domain_name = var.app_domain

  # A record pointing to ALB
  records = [
    {
      name    = var.app_domain
      type    = "A"
      alias   = true
      zone_id = module.alb.zone_id
      dns_name = module.alb.dns_name
    },
    {
      name    = "www.${var.app_domain}"
      type    = "A"
      alias   = true
      zone_id = module.alb.zone_id
      dns_name = module.alb.dns_name
    }
  ]

  tags = {
    Name = "${var.project_name}-${var.environment}-dns"
  }
}

# AWS Secrets Manager - Secure secret storage
resource "aws_secretsmanager_secret" "database_url" {
  name        = "${var.project_name}-${var.environment}-database-url"
  description = "Database connection URL"

  recovery_window_in_days = var.environment == "production" ? 30 : 0
}

resource "aws_secretsmanager_secret_version" "database_url" {
  secret_id = aws_secretsmanager_secret.database_url.id
  secret_string = "postgresql://${var.db_username}:${var.db_password}@${module.database.endpoint}/${var.db_name}"
}

resource "aws_secretsmanager_secret" "jwt_secret" {
  name        = "${var.project_name}-${var.environment}-jwt-secret"
  description = "JWT secret for token signing"

  recovery_window_in_days = var.environment == "production" ? 30 : 0
}

resource "aws_secretsmanager_secret_version" "jwt_secret" {
  secret_id     = aws_secretsmanager_secret.jwt_secret.id
  secret_string = var.jwt_secret
}

resource "aws_secretsmanager_secret" "redis_auth_token" {
  name        = "${var.project_name}-${var.environment}-redis-auth-token"
  description = "Redis authentication token"

  recovery_window_in_days = var.environment == "production" ? 30 : 0
}

resource "aws_secretsmanager_secret_version" "redis_auth_token" {
  secret_id     = aws_secretsmanager_secret.redis_auth_token.id
  secret_string = var.redis_auth_token
}
