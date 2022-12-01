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
| [aws_iam_policy_document.iam_role_access_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.s3_bucket_to_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_s3_access"></a> [s3\_access](#input\_s3\_access) | What S3 bucket is this applicaion creating, and with what permissions? | <pre>object(<br>    {<br>      bucket       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Policy Document for IAM Role usage by K8S Service Account |
<!-- END_TF_DOCS -->