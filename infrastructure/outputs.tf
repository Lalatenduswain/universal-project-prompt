# Terraform outputs - important values after infrastructure creation

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

# Database Outputs
output "database_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = module.database.endpoint
}

output "database_port" {
  description = "RDS PostgreSQL port"
  value       = module.database.port
}

output "database_name" {
  description = "Database name"
  value       = var.db_name
}

output "database_connection_string" {
  description = "Database connection string (without password)"
  value       = "postgresql://${var.db_username}:***@${module.database.endpoint}/${var.db_name}"
  sensitive   = false
}

# Cache Outputs
output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = module.cache.endpoint
}

output "redis_port" {
  description = "ElastiCache Redis port"
  value       = module.cache.port
}

# Load Balancer Outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = module.alb.zone_id
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.arn
}

# ECS Outputs
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = module.ecs.task_definition_arn
}

# S3 Outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "s3_bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = module.s3.bucket_domain_name
}

# IAM Outputs
output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = module.iam.ecs_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iam.ecs_task_role_arn
}

# ACM Outputs
output "certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = module.acm.certificate_arn
}

output "certificate_domain" {
  description = "Domain of the ACM certificate"
  value       = module.acm.domain_name
}

# Route53 Outputs
output "route53_zone_id" {
  description = "ID of the Route53 hosted zone"
  value       = module.route53.zone_id
}

output "route53_name_servers" {
  description = "Name servers for the Route53 zone"
  value       = module.route53.name_servers
}

# CloudWatch Outputs
output "cloudwatch_log_group" {
  description = "Name of the CloudWatch log group"
  value       = module.cloudwatch.log_group_name
}

output "cloudwatch_sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = module.cloudwatch.sns_topic_arn
}

# Secrets Manager Outputs
output "database_url_secret_arn" {
  description = "ARN of the database URL secret"
  value       = aws_secretsmanager_secret.database_url.arn
  sensitive   = true
}

output "jwt_secret_arn" {
  description = "ARN of the JWT secret"
  value       = aws_secretsmanager_secret.jwt_secret.arn
  sensitive   = true
}

# Application URL
output "application_url" {
  description = "URL to access the application"
  value       = "https://${var.app_domain}"
}

# Summary Output
output "deployment_summary" {
  description = "Summary of deployed infrastructure"
  value = {
    environment     = var.environment
    region          = var.aws_region
    vpc_id          = module.vpc.vpc_id
    database        = module.database.endpoint
    cache           = module.cache.endpoint
    load_balancer   = module.alb.dns_name
    ecs_cluster     = module.ecs.cluster_name
    s3_bucket       = module.s3.bucket_name
    application_url = "https://${var.app_domain}"
  }
}
