<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.iam_role_access_to_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_rds_cluster.rds_cluster_to_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/rds_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rds_cluster_access"></a> [rds\_cluster\_access](#input\_rds\_cluster\_access) | RDS Cluster attributes to give IAM role access to | <pre>object(<br>    {<br>      rds_cluster_name    = string,<br>      rds_cluster_account = string,<br>      rds_cluster_region  = string,<br>      rds_user_name       = string<br>    }<br>  )</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Policy Document for IAM Role access to RDS User |
<!-- END_TF_DOCS -->