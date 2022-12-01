module "vpc_peering" {
  source = "git@github.com:cloudposse/terraform-aws-vpc-peering.git?ref=0.9.0"
  # Cloud Posse recommends pinning every module to a specific version
  namespace        = "devopsidiot" #TODO change to devopsidiot
  stage            = var.environment
  name             = var.vpc_peering_name
  requestor_vpc_id = var.requestor_vpc_id
  acceptor_vpc_id  = var.acceptor_vpc_id
}
