<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.47.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc_peering"></a> [vpc\_peering](#module\_vpc\_peering) | git@github.com:cloudposse/terraform-aws-vpc-peering.git | 0.9.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acceptor_vpc_id"></a> [acceptor\_vpc\_id](#input\_acceptor\_vpc\_id) | The VPC ID that is receiving the peering request. | `string` | n/a | yes |
| <a name="input_requestor_vpc_id"></a> [requestor\_vpc\_id](#input\_requestor\_vpc\_id) | The VPC ID that is originating the peering request. | `string` | n/a | yes |
| <a name="input_vpc_peering_name"></a> [vpc\_peering\_name](#input\_vpc\_peering\_name) | The name of the vpc peering connection being created. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->