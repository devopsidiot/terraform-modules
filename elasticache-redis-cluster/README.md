<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.47.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.47.0, < 4.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redis"></a> [redis](#module\_redis) | git@github.com:cloudposse/terraform-aws-elasticache-redis.git | 0.42.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zone IDs | `list(string)` | n/a | yes |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | Number of nodes in cluster | `number` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Elastic cache instance type | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of redis cluster | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnet IDs to deploy cluster in. | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR for the host VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC this will be deployed in | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Route53 DNS Zone Name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Redis primary endpoint |
| <a name="output_cluster_host"></a> [cluster\_host](#output\_cluster\_host) | Redis hostname |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Redis cluster ID |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Redis Security Group ID |
| <a name="output_cluster_security_group_name"></a> [cluster\_security\_group\_name](#output\_cluster\_security\_group\_name) | Redis Security Group name |
<!-- END_TF_DOCS -->