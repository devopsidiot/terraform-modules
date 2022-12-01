module "redis" {
  source = "git@github.com:cloudposse/terraform-aws-elasticache-redis.git?ref=0.42.0"

  name                             = var.name
  availability_zones               = var.availability_zones
  zone_id                          = data.aws_route53_zone.hosted_zone.zone_id
  vpc_id                           = var.vpc_id
  subnets                          = var.subnets
  cluster_size                     = var.cluster_size
  instance_type                    = var.instance_type
  apply_immediately                = true
  automatic_failover_enabled       = true
  engine_version                   = "6.x"
  family                           = "redis6.x"
  at_rest_encryption_enabled       = true
  transit_encryption_enabled       = true
  cloudwatch_metric_alarms_enabled = true

  additional_security_group_rules = [
    {
      type                     = "ingress"
      from_port                = 0
      to_port                  = 6379
      protocol                 = "-1"
      cidr_blocks              = [var.vpc_cidr]
      source_security_group_id = null
      description              = "Allow all inbound traffic from EKS VPC CIDRs"
    }
  ]
}
