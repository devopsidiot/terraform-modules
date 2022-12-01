terraform {
  experiments = [module_variable_optional_attrs]

  required_providers {
    newrelic = { source = "newrelic/newrelic" }
  }
}

module "resource-builder" {
  count = (
    var.create_ecr ||
    var.ssm_parameters != null ||
    var.s3_bucket_to_create != null ||
    var.sns_topic_to_create != null ||
    var.sqs_queue_to_create != null ||
    var.redis_to_create != null ||
    var.rds_cluster_to_create != null ||
    var.qldb_ledger_to_create != null ||
    var.new_relic_alerts != null ||
    var.new_relic_dashboard != null
  ) == true ? 1 : 0

  source = "./modules/resource-builder"

  environment = var.environment
  region      = var.region

  create_ecr          = var.create_ecr
  service_name        = var.service_name
  ssm_parameters      = var.ssm_parameters
  redis_to_create     = var.redis_to_create
  rds_cluster_to_create = var.rds_cluster_to_create
  qldb_ledger_to_create = var.qldb_ledger_to_create
  sns_topic_to_create = var.sns_topic_to_create
  sqs_queue_to_create = var.sqs_queue_to_create
  s3_bucket_to_create = var.s3_bucket_to_create
  new_relic_alerts    = var.new_relic_alerts
  new_relic_dashboard    = var.new_relic_dashboard

  providers = {
    newrelic = newrelic
  }
}

module "role-producer" {
  depends_on = [module.resource-builder]
  count      = var.create_role == true ? 1 : 0
  source     = "./modules/role-producer"

  service_name           = var.service_name
  namespace              = var.namespace
  ssm_scopes             = var.ssm_scopes
  eks_cluster_attributes = var.eks_cluster_attributes
  shared_rds_access      = var.shared_rds_access
  #S3
  shared_s3_access  = var.shared_s3_access
  created_s3_access = module.resource-builder != [] ? module.resource-builder[0].created_s3_bucket : null
  #SNS
  shared_sns_access  = var.shared_sns_access
  created_sns_access = module.resource-builder != [] ? module.resource-builder[0].created_sns : null
  #SQS
  created_sqs_access = module.resource-builder != [] ? module.resource-builder[0].created_sqs : null
  #QLDB
  shared_qldb_access = var.shared_qldb_access
  created_qldb_access = module.resource-builder != [] ? module.resource-builder[0].created_qldb_ledger : null
}

