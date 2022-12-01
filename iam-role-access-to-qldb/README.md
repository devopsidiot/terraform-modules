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
| [aws_iam_policy_document.iam_role_access_to_qldb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_qldb_ledger.qldb_ledger_to_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/qldb_ledger) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_qldb_ledger_access"></a> [qldb\_ledger\_access](#input\_qldb\_ledger\_access) | QLDB Ledger to give IAM role access to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Policy Document for IAM Role access to RDS User |
<!-- END_TF_DOCS -->