output "iam_role_name" {
  value       = module.role-producer != [] ? module.role-producer[0].iam_role_name : null
  description = "IAM Role created by role producer"
}

output "created_sns" {
  value = module.resource-builder != [] ? module.resource-builder[0].created_sns : null
  description = "SNS created for this application"
}

output "created_sqs" {
  value = module.resource-builder != [] ? module.resource-builder[0].created_sqs : null
  description = "SQS created for this application"
}

output "created_rds" {
  value       = null
  description = "Aurora PostgreSQL Cluster created for this application"
}

output "created_redis" {
  value = module.resource-builder != [] ? module.resource-builder[0].created_redis : null
  description = "Elasticache Redis cluster created for this application"
}