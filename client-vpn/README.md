<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.47.0 |
| <a name="requirement_newrelic"></a> [newrelic](#requirement\_newrelic) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.47.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.ca](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.root](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.vpn](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.vpn](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_client_vpn_authorization_rule.client_vpn_ingress_auth](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.client-vpn-endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.client-vpn-endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_route.client-vpn-route](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ec2_client_vpn_route) | resource |
| [aws_ec2_client_vpn_route.peered-vpc-route](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ec2_client_vpn_route) | resource |
| [aws_route.acceptor](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/route) | resource |
| [aws_s3_bucket.config_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.object](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/s3_bucket_object) | resource |
| [local_sensitive_file.ovpn_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [tls_cert_request.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_route_tables.acceptor](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/route_tables) | data source |
| [aws_vpc.peered_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/vpc) | data source |
| [aws_vpc_peering_connection.peer_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/vpc_peering_connection) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_cidr"></a> [client\_cidr](#input\_client\_cidr) | Specify an IP address range, in CIDR notation, from which to assign client IP addresses.  The IP address range cannot overlap with the target network or any of the routes that will be associated with the Client VPN endpoint. The client CIDR range must have a block size that is between /12 and /22 and not overlap with VPC CIDR or any other route in the route table. You cannot change the client CIDR after you create the Client VPN endpoint. | `string` | n/a | yes |
| <a name="input_default_sg_id"></a> [default\_sg\_id](#input\_default\_sg\_id) | The ID of the security group ( typically the default security group of the vpc ) to apply to the dns endpoints that are created. | `string` | n/a | yes |
| <a name="input_home_dir"></a> [home\_dir](#input\_home\_dir) | The users home directory. Will be used as the base for the output file path. | `string` | `"."` | no |
| <a name="input_logs_retention"></a> [logs\_retention](#input\_logs\_retention) | The log retention of the aws cloudwatch log group created for the vpn in days. | `number` | `365` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the vpn to be created.  The name is used in the common name of the certificates that are created as well as the name of the cloudwatch log group that is created. | `string` | n/a | yes |
| <a name="input_output_file_path"></a> [output\_file\_path](#input\_output\_file\_path) | the path that will be used, in the users home directory, for local vpn files that are created.  Will be created if necessary. | `string` | `"omaze-configs"` | no |
| <a name="input_peered_vpc"></a> [peered\_vpc](#input\_peered\_vpc) | The peered vpc this client VPN needs access to | `string` | `null` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of private subnet ids to associate with the vpn, create routes, and dns resolver endpoints for. | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Specify the IP address range, in CIDR notation, of the VPC the VPN is being created in. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->