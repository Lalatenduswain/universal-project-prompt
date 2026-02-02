# Variables for Terraform infrastructure configuration

# General Configuration
variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway for private subnets"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Enable VPN gateway"
  type        = bool
  default     = false
}

# RDS PostgreSQL Configuration
variable "postgres_version" {
  description = "PostgreSQL engine version"
  type        = string
  default     = "18.1"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum allocated storage for autoscaling (GB)"
  type        = number
  default     = 100
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Backup window (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "Maintenance window (UTC)"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

# ElastiCache Redis Configuration
variable "redis_version" {
  description = "Redis engine version"
  type        = string
  default     = "7.1"
}

variable "redis_node_type" {
  description = "ElastiCache node type"
  type        = string
  default     = "cache.t3.micro"
}

variable "redis_num_nodes" {
  description = "Number of cache nodes"
  type        = number
  default     = 1
}

variable "redis_parameter_group" {
  description = "Redis parameter group name"
  type        = string
  default     = "default.redis7"
}

variable "redis_auth_token" {
  description = "Redis authentication token"
  type        = string
  sensitive   = true
}

# ECS Configuration
variable "container_image" {
  description = "Docker container image (ECR or Docker Hub)"
  type        = string
}

variable "app_port" {
  description = "Application container port"
  type        = number
  default     = 3000
}

variable "ecs_task_cpu" {
  description = "ECS task CPU units (256, 512, 1024, 2048, 4096)"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "ECS task memory in MB (512, 1024, 2048, 4096, 8192)"
  type        = number
  default     = 512
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "ecs_min_capacity" {
  description = "Minimum ECS task capacity for auto-scaling"
  type        = number
  default     = 2
}

variable "ecs_max_capacity" {
  description = "Maximum ECS task capacity for auto-scaling"
  type        = number
  default     = 10
}

# Domain and DNS Configuration
variable "app_domain" {
  description = "Primary application domain"
  type        = string
}

variable "domain_aliases" {
  description = "Domain aliases for SSL certificate"
  type        = list(string)
  default     = []
}

# Secrets Configuration
variable "jwt_secret" {
  description = "JWT secret for token signing (min 32 characters)"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.jwt_secret) >= 32
    error_message = "JWT secret must be at least 32 characters."
  }
}

# Monitoring Configuration
variable "alert_emails" {
  description = "Email addresses for CloudWatch alerts"
  type        = list(string)
  default     = []
}

# Tags
variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
