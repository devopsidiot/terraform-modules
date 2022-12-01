<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_IAM_role_access_to_service_ssm"></a> [IAM\_role\_access\_to\_service\_ssm](#module\_IAM\_role\_access\_to\_service\_ssm) | github.com/cloudposse/terraform-aws-iam-policy-document-aggregator | 0.8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.iam_role_access_to_describe_ssm_parameters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_role_access_to_service_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.iam_role_access_to_ssm_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_key.ssm_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssm_scopes"></a> [ssm\_scopes](#input\_ssm\_scopes) | n/a | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Policy Document for IAM Role usage by K8S Service Account |
<!-- END_TF_DOCS -->