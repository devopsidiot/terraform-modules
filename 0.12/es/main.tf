module "es" {
  source                                = "cloudposse/elasticsearch/aws"
  version                               = "0.24.1"
  name                                  = var.name
  elasticsearch_version                 = var.elasticsearch_version
  tags                                  = var.tags
  vpc_id                                = var.vpc_id
  allowed_cidr_blocks                   = var.allowed_cidr_blocks
  create_iam_service_linked_role        = var.create_iam_service_linked_role
  encrypt_at_rest_enabled               = var.encrypt_at_rest_enabled
  domain_endpoint_options_enforce_https = var.domain_endpoint_options_enforce_https
  advanced_options                      = var.advanced_options
  kibana_subdomain_name                 = var.kibana_subdomain_name
  subnet_ids = length(var.subnet_ids) > 0 ? var.subnet_ids : [
    var.private_subnets[0],
    var.private_subnets[1],
    var.private_subnets[2]
  ]
  zone_awareness_enabled   = var.zone_awareness_enabled
  instance_count           = var.instance_count
  instance_type            = var.instance_type
  ebs_volume_size          = var.ebs_volume_size
  availability_zone_count  = var.availability_zone_count
  security_groups          = var.security_groups
  dedicated_master_count   = var.dedicated_master_count
  dedicated_master_type    = var.dedicated_master_type
  dedicated_master_enabled = var.dedicated_master_enabled
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name     = module.es.domain_name
  access_policies = var.allow_open_access ? var.policy : <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "es:ESHttpPut",
        "es:ESHttpPost",
        "es:ESHttpGet",
        "es:ESHttpDelete"
      ],
      "Resource": [
        "${module.es.domain_arn}/*"
      ]
    }
  ]
}
EOF
}
