variable "cluster_id" { type = string }
variable "engine" { type = string }
variable "engine_version" { type = string }
variable "node_type" { type = string }
variable "num_cache_nodes" { type = number }
variable "parameter_group_name" { type = string }
variable "port" { type = number }
variable "vpc_id" { type = string }
variable "subnet_ids" { type = list(string) }
variable "security_group_ids" { type = list(string) }
variable "at_rest_encryption_enabled" { type = bool }
variable "transit_encryption_enabled" { type = bool }
variable "auth_token" { type = string; sensitive = true }
variable "snapshot_retention_limit" { type = number }
variable "snapshot_window" { type = string }
variable "maintenance_window" { type = string }
variable "automatic_failover_enabled" { type = bool }
variable "multi_az_enabled" { type = bool }
variable "tags" { type = map(string); default = {} }
