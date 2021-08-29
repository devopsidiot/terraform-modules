locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.environment
  common_vars      = read_terragrunt_config(find_in_parent_folders("common.hcl"))
  common_tags      = local.common_vars.locals.tags
  tags = merge(local.common_tags, {
    Environment = local.env
    Name        = "project-${local.env}-to-VPN"
  })
  VPN_peer_owner_id          = local.common_vars.locals.VPN_peer_owner_id
  VPN_peer_vpc_id            = local.common_vars.locals.VPN_peer_vpc_id
  VPN_destination_cidr_block = local.common_vars.locals.VPN_destination_cidr_block
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "_module"
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  name   = "project-${local.env}-to-VPN"
  vpc_id = dependency.vpc.outputs.vpc_id


  # Next value isn't actually needed, but is useful to output for next
  # step (the accepter)
  cidr   = dependency.vpc.outputs.vpc_cidr_block

  peer_owner_id          = "12345678901"
  peer_vpc_id            = "vpc-123h2345h" # Radio-Management / VPN
  destination_cidr_block = "10.200.0.0/16"

  tags = local.tags
}
