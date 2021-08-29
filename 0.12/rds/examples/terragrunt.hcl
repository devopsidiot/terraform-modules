locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))

  common_tags       = local.common_vars.locals.tags
  env              = local.environment_vars.locals.environment
  vpn_cidr         = local.common_vars.locals.VPN_destination_cidr_block
  tags = merge(local.common_tags, {
    Environment = local.env
  })

  # Merge default cluster and DB parameter group settings from env.hcl with
  # overrides specified in this file (if there happen to be any at all)
  db_parameters_default      = local.environment_vars.locals.db_parameters
  db_parameters              = concat(local.db_parameters_default, [])
  cluster_parameters_default = local.environment_vars.locals.cluster_parameters
  cluster_parameters         = concat(local.cluster_parameters_default, [])

  db_creds = yamldecode(sops_decrypt_file("db-creds.sops.yaml"))
  username = local.db_creds.username
  password = local.db_creds.password
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../tf-main/0.12/rds"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "eks" {
  config_path = "../eks"
}

inputs = {
  name = "project-${local.env}"
  engine                          = "aurora-postgresql"
  engine_version                  = "10.11"
  vpc_id                          = dependency.vpc.outputs.vpc_id
  subnets                         = dependency.vpc.outputs.database_subnets
  replica_count                   = 1
  allowed_security_groups         = [dependency.eks.outputs.cluster_primary_security_group_id]
  allowed_cidr_blocks             = [local.vpn_cidr]
  instance_type                   = "db.r4.large"
  storage_encrypted               = true
  apply_immediately               = true

  # Create from snapshot (only has effect on initial resource creation)
  #snapshot_identifier = ""

  tags = local.tags
  cluster_parameters = local.cluster_parameters
  db_parameters      = local.db_parameters
}
