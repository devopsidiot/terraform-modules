output "database_name" {
  value       = var.db_name
  description = "Database name"
}

output "cluster_identifier" {
  value       = module.rds-cluster.cluster_identifier
  description = "Cluster Identifier"
}

output "arn" {
  value       = module.rds-cluster.arn
  description = "Amazon Resource Name (ARN) of the cluster"
}

output "master_host" {
  value       = module.rds-cluster.master_host
  description = "DB Master hostname"
}

output "replicas_host" {
  value       = module.rds-cluster.replicas_host
  description = "Replicas hostname"
}

output "cluster_resource_id" {
  value       = module.rds-cluster.cluster_resource_id
  description = "The region-unique, immutable identifier of the cluster"
}