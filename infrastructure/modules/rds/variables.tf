variable "identifier" { type = string }
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }
variable "max_allocated_storage" { type = number }
variable "storage_encrypted" { type = bool }
variable "database_name" { type = string }
variable "username" { type = string; sensitive = true }
variable "password" { type = string; sensitive = true }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "backup_retention_period" { type = number }
variable "backup_window" { type = string }
variable "maintenance_window" { type = string }
variable "multi_az" { type = bool }
variable "deletion_protection" { type = bool }
variable "skip_final_snapshot" { type = bool }
variable "final_snapshot_identifier" { type = string }
variable "performance_insights_enabled" { type = bool }
variable "monitoring_interval" { type = number }
variable "enabled_cloudwatch_logs_exports" { type = list(string) }
variable "tags" { type = map(string); default = {} }
