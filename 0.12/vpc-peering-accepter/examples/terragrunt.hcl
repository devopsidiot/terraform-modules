locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  common_tags      = local.common_vars.locals.tags
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../_module"
}

inputs = {
  vpc_id = "vpc-123456as"

  # Unity loadtest
  peering_connection_id = "pcx-234441125gwef32"
  destination_cidr_block = "10.232.0.0/16"

  tags = merge(local.common_tags,{
    Environment = local.env
    Name = "VPN-to-marconi-dev"
  })
}
