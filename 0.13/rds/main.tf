resource "aws_db_parameter_group" "pg" {
  name        = var.name
  family      = var.family
  description = var.name
  tags        = var.tags
  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", "pending-reboot")
      name         = parameter.value["name"]
      value        = parameter.value["value"]
    }
  }

}

resource "aws_rds_cluster_parameter_group" "cpg" {
  name        = var.name
  family      = var.family
  description = var.name
  tags        = var.tags
  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", "pending-reboot")
      name         = parameter.value["name"]
      value        = parameter.value["value"]
    }
  }
}

module "db" {
  source                              = "terraform-aws-modules/rds-aurora/aws"
  version                             = "2.23.0"
  name                                = var.name
  engine                              = var.engine
  engine_version                      = var.engine_version
  vpc_id                              = var.vpc_id
  subnets                             = var.subnets
  replica_count                       = var.replica_count
  allowed_security_groups             = var.allowed_security_groups
  allowed_cidr_blocks                 = var.allowed_cidr_blocks
  instance_type                       = var.instance_type
  storage_encrypted                   = true
  apply_immediately                   = true
  username                            = var.username
  password                            = var.password
  db_parameter_group_name             = aws_db_parameter_group.pg.name
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.cpg.name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled

  # snapshot_identifier only has effect at creation, not subsequent modifications
  snapshot_identifier = var.snapshot_identifier

  tags = var.tags
}
