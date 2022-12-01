output "created_sns" {
  value = module.sns != [] ? module.sns.*.sns_topic_name : null
  description = "SNS(s) created for this application"
}

output "created_sqs" {
  value       = var.sqs_queue_to_create != null ? {
    queue = var.sqs_queue_to_create["name"]
    permissions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage"
    ]
  } : null
  description = "SQS created for this application"
}

output "created_rds" {
  value       = module.rds != [] ? {
    database_name = module.rds[0].database_name
    cluster_identifier = module.rds[0].cluster_identifier
    arn = module.rds[0].arn
    master_host = module.rds[0].master_host
    replicas_host = module.rds[0].replicas_host
    cluster_resource_id = module.rds[0].cluster_resource_id
  } : null
  description = "Aurora PostgreSQL Cluster created for this application"
}

output "created_redis" {
  value       = module.elasticache_redis_cluster != [] ? module.elasticache_redis_cluster[0].cluster_endpoint : null
  description = "Elasticache Redis cluster created for this application"
}

output "created_qldb_ledger" {
  value       = aws_qldb_ledger.qldb_ledger_to_create != [] ? aws_qldb_ledger.qldb_ledger_to_create[0].name : null
  description = "QLDB Ledger created for this application"
}

output "created_s3_bucket" {
  value       = aws_s3_bucket.s3_bucket_to_create != [] ? {
    bucket = aws_s3_bucket.s3_bucket_to_create[0].id
    permissions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
  } : null
  description = "S3 bucket created for this application"
}
