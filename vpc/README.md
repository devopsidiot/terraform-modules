<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.47.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_wafv2"></a> [alb\_wafv2](#module\_alb\_wafv2) | trussworks/wafv2/aws | 2.4.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git@github.com:terraform-aws-modules/terraform-aws-vpc.git | v3.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.Global-WhiteList](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/wafv2_ip_set) | resource |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/iam_policy_document) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_infra_newbits"></a> [infra\_newbits](#input\_infra\_newbits) | Number of bits to add to cidr when subdividing subnets. | `number` | `7` | no |
| <a name="input_private_newbits"></a> [private\_newbits](#input\_private\_newbits) | Number of bits to add to cidr when subdividing subnets. | `number` | `5` | no |
| <a name="input_vpc_azs"></a> [vpc\_azs](#input\_vpc\_azs) | List of AZ's to use | `list(string)` | <pre>[<br>  "us-west-2a",<br>  "us-west-2b",<br>  "us-west-2c"<br>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR to use for creating vpc. | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the vpc that will be created. | `string` | `"omaze-vpc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | azs |
| <a name="output_cgw_ids"></a> [cgw\_ids](#output\_cgw\_ids) | List of IDs of Customer Gateway |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of IDs of database subnets |
| <a name="output_default_sg_id"></a> [default\_sg\_id](#output\_default\_sg\_id) | Default VPC SG ID |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | List of IDs of intra subnets |
| <a name="output_nat_public_ips"></a> [nat\_public\_ips](#output\_nat\_public\_ips) | List of public Elastic IPs created for AWS NAT Gateway |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_this_customer_gateway"></a> [this\_customer\_gateway](#output\_this\_customer\_gateway) | Map of Customer Gateway attributes |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | cidr allocation of the vpc |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->