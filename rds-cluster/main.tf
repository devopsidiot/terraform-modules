module "rds-cluster" {
  source  = "cloudposse/rds-cluster/aws"
  version = "v0.50.2"

  engine         = "aurora-postgresql"
  cluster_family = "aurora-postgresql13"
  # 1 writer, 1 reader
  cluster_size   = var.cluster_size
  admin_user     = "dba_user" # Master user name for database
  admin_password = var.admin_password
  db_name        = var.db_name # What is the name of the database you want to create?
  db_port        = var.db_port
  instance_type  = var.instance_type # What size instances to use with this cluster
  vpc_id         = var.vpc_id        # Which VPC will the cluster be created in?
  subnets        = var.subnets       # What subnets should this cluster be able to create in?
  zone_id        = var.zone_id       # Hosted zone to create DNS entry in

  cluster_dns_name = var.cluster_dns_name # DNS entry for the writer instance
  reader_dns_name  = var.reader_dns_name  # DNS entry for readers instances
  environment      = var.environment      # what region is this going to be used in?
  name             = var.name             # App that this DB is for
  namespace        = var.namespace        # A label for overarching projects, ex: coreloop

  allowed_cidr_blocks = var.allowed_cidr_blocks #CIDRs that can access the cluster
  security_groups     = var.security_groups     # SG IDs that can access the cluster

  backup_window         = var.backup_window # Window in which database backups are created
  copy_tags_to_snapshot = true
  retention_period      = var.retention_period # 30 days of rolling backups

  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  maintenance_window          = var.maintenance_window # What time do you want maintenance to happen?
  apply_immediately           = false

  deletion_protection                   = true
  enhanced_monitoring_role_enabled      = true
  iam_database_authentication_enabled   = true
  storage_encrypted                     = true
  kms_key_arn                           = var.kms_key_arn # What KMS key to use for encryption
  performance_insights_kms_key_id       = var.kms_key_arn # Should be same as kms_key_arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 7 #in days, either 7 or 731 (2 years)
  rds_monitoring_interval               = 10
}
