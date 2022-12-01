terraform {  
  experiments = [module_variable_optional_attrs]
  required_providers {
    newrelic = { source = "newrelic/newrelic" }
  }
}

module "ecr" {
  count  = var.create_ecr == true ? 1 : 0
  source = "git@github.com:devopsidiot-ops/ecr.git?ref=v1.0.0"

  repo_name = var.service_name
}

module "ssm" {
  count  = var.ssm_parameters != null ? 1 : 0
  source = "git@github.com:devopsidiot-ops/ssm.git?ref=v1.0.0"

  environment    = var.environment
  ssm_parameters = var.ssm_parameters
  kms_alias      = "alias/aws/ssm"
}

module "sns" {
  count   = var.sns_topic_to_create != null ? length(var.sns_topic_to_create) : 0
  source  = "terraform-aws-modules/sns/aws"
  version = "3.3.0"

  name = var.sns_topic_to_create[count.index]
}

module "sqs" {
  count   = var.sqs_queue_to_create != null ? 1 : 0
  source  = "git@github.com:devopsidiot-ops/sqs.git?ref=v1.0.0"

  sqs_queue_to_create = var.sqs_queue_to_create
}

module "elasticache_redis_cluster" {
  count = var.redis_to_create != null ? 1 : 0
  source = "git@github.com:devopsidiot-ops/elasticache-redis-cluster.git?ref=v1.0.0"

  name               = var.redis_to_create["name"]
  availability_zones = var.redis_to_create["availability_zones"]
  zone_name          = var.redis_to_create["zone_name"]
  vpc_id             = var.redis_to_create["vpc_id"]
  subnets            = var.redis_to_create["subnets"]
  cluster_size       = var.redis_to_create["cluster_size"]
  instance_type      = var.redis_to_create["instance_type"]
  vpc_cidr           = var.redis_to_create["vpc_cidr"]
}

resource "aws_qldb_ledger" "qldb_ledger_to_create" {
  count = var.qldb_ledger_to_create != null ? 1 : 0

  name = var.qldb_ledger_to_create
  permissions_mode = "ALLOW_ALL"
  deletion_protection = true
}

module "rds" {
  count = var.rds_cluster_to_create != null ? 1 : 0
  source  = "git@github.com:devopsidiot-ops/rds-cluster.git?ref=v1.0.0"

  name = var.rds_cluster_to_create["name"]
  namespace = var.rds_cluster_to_create["namespace"]
  environment = var.rds_cluster_to_create["environment"]
  engine_version = var.rds_cluster_to_create["engine_version"]
  instance_type = var.rds_cluster_to_create["instance_type"]
  cluster_size = var.rds_cluster_to_create["cluster_size"]
  db_name = var.rds_cluster_to_create["db_name"]
  admin_password = var.rds_cluster_to_create["admin_password"]
  kms_key_arn = var.rds_cluster_to_create["kms_key_arn"]
  rds_monitoring_interval = var.rds_cluster_to_create["rds_monitoring_interval"]
  backup_window = var.rds_cluster_to_create["backup_window"]
  retention_period = var.rds_cluster_to_create["retention_period"]
  maintenance_window = var.rds_cluster_to_create["maintenance_window"]
  vpc_id = var.rds_cluster_to_create["vpc_id"]
  allowed_cidr_blocks = var.rds_cluster_to_create["allowed_cidr_blocks"]
  subnets = var.rds_cluster_to_create["subnets"]
  zone_id = var.rds_cluster_to_create["zone_id"]
  cluster_dns_name = var.rds_cluster_to_create["cluster_dns_name"]
  reader_dns_name = var.rds_cluster_to_create["reader_dns_name"]
}

resource "aws_s3_bucket" "s3_bucket_to_create" {
  count = var.s3_bucket_to_create != null ? 1 : 0

  bucket = var.s3_bucket_to_create["bucket"]
  acl = "private"

  dynamic "object_lock_configuration" {
    for_each = var.s3_bucket_to_create["object_lock_enabled"] ? [1] : []
    
    content{
      object_lock_enabled = "Enabled"
    
      rule {
        default_retention {
          mode  = var.s3_bucket_to_create["object_lock_retention_mode"]
          years = var.s3_bucket_to_create["object_lock_years"]
        }
      }
    }
  }
}

module "new-relic-alerts" {
  count = var.new_relic_alerts != null ? 1 : 0
  source = "git@github.com:devopsidiot-ops/new-relic-alerts.git?ref=v1.2.1"

  newrelic_alert_policy = var.new_relic_alerts["newrelic_alert_policy"]
  newrelic_alert_policy_incident_preference = var.new_relic_alerts["newrelic_alert_policy_incident_preference"]
  newrelic_alert_email_channel_name = var.new_relic_alerts["newrelic_alert_email_channel_name"] != null ? var.new_relic_alerts["newrelic_alert_email_channel_name"] : ""
  newrelic_alert_slack_channel_name = var.new_relic_alerts["newrelic_alert_slack_channel_name"] != null ? var.new_relic_alerts["newrelic_alert_slack_channel_name"] : ""
  newrelic_alert_pagerduty_channel_name = var.new_relic_alerts["newrelic_alert_pagerduty_channel_name"] != null ? var.new_relic_alerts["newrelic_alert_pagerduty_channel_name"] : ""
  newrelic_alert_conditions = var.new_relic_alerts["newrelic_alert_conditions"]

  providers = {
    newrelic = newrelic
  }
}

module "new-relic-dashboard" {
  count = var.new_relic_dashboard != null ? 1 : 0
  source = "git@github.com:devopsidiot-ops/new-relic-one-dashboard.git?ref=v1.0.2"

  newrelic_dashboard_name = var.new_relic_dashboard["newrelic_dashboard_name"]
  newrelic_dashboard_permissions = var.new_relic_dashboard["newrelic_dashboard_permissions"]
  newrelic_dashboard_pages =  var.new_relic_dashboard["newrelic_dashboard_pages"]

  providers = {
    newrelic = newrelic
  }
}
