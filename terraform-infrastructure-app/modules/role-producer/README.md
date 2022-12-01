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
| <a name="module_iam-assume-role-access-for-k8s-service-account"></a> [iam-assume-role-access-for-k8s-service-account](#module\_iam-assume-role-access-for-k8s-service-account) | git@github.com:devopsidiot-ops/iam-assume-role-access-for-k8s-service-account.git | v1.0.0 |
| <a name="module_iam-role-access-to-created-qldb"></a> [iam-role-access-to-created-qldb](#module\_iam-role-access-to-created-qldb) | git@github.com:devopsidiot-ops/iam-role-access-to-qldb.git | v1.0.0 |
| <a name="module_iam-role-access-to-created-s3"></a> [iam-role-access-to-created-s3](#module\_iam-role-access-to-created-s3) | git@github.com:devopsidiot-ops/iam-role-access-to-s3.git | v1.0.0 |
| <a name="module_iam-role-access-to-created-sns"></a> [iam-role-access-to-created-sns](#module\_iam-role-access-to-created-sns) | git@github.com:devopsidiot-ops/iam-role-access-to-sns.git | v1.0.0 |
| <a name="module_iam-role-access-to-created-sqs"></a> [iam-role-access-to-created-sqs](#module\_iam-role-access-to-created-sqs) | git@github.com:devopsidiot-ops/iam-role-access-to-sqs.git | v1.0.0 |
| <a name="module_iam-role-access-to-service-ssm"></a> [iam-role-access-to-service-ssm](#module\_iam-role-access-to-service-ssm) | git@github.com:devopsidiot-ops/iam-role-access-to-service-ssm.git | v1.0.0 |
| <a name="module_iam-role-access-to-shared-qldb"></a> [iam-role-access-to-shared-qldb](#module\_iam-role-access-to-shared-qldb) | git@github.com:devopsidiot-ops/iam-role-access-to-qldb.git | v1.0.0 |
| <a name="module_iam-role-access-to-shared-rds"></a> [iam-role-access-to-shared-rds](#module\_iam-role-access-to-shared-rds) | git@github.com:devopsidiot-ops/iam-role-access-to-rds.git | v1.0.0 |
| <a name="module_iam-role-access-to-shared-s3"></a> [iam-role-access-to-shared-s3](#module\_iam-role-access-to-shared-s3) | git@github.com:devopsidiot-ops/iam-role-access-to-s3.git | v1.0.0 |
| <a name="module_iam-role-access-to-shared-sns"></a> [iam-role-access-to-shared-sns](#module\_iam-role-access-to-shared-sns) | git@github.com:devopsidiot-ops/iam-role-access-to-sns.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.service-role-created-qldb-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-created-s3-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-created-sns-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-created-sqs-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-shared-qldb-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-shared-rds-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-shared-s3-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-shared-sns-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.service-role-ssm-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.service-role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.service-role-created-qldb-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-created-s3-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-created-sns-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-created-sqs-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-shared-qldb-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-shared-rds-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-shared-s3-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-shared-sns-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.service-role-ssm-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_created_qldb_access"></a> [created\_qldb\_access](#input\_created\_qldb\_access) | Which QLDB Ledger does this application create and need access to? | `string` | n/a | yes |
| <a name="input_created_s3_access"></a> [created\_s3\_access](#input\_created\_s3\_access) | What S3 bucket does this applcation create and need access to, and with what permissions? | <pre>object(<br>    {<br>      bucket       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_created_sns_access"></a> [created\_sns\_access](#input\_created\_sns\_access) | Which SNS topic does this application create and need access to? | `list(string)` | n/a | yes |
| <a name="input_created_sqs_access"></a> [created\_sqs\_access](#input\_created\_sqs\_access) | Which SQS queue does this application create and need access to, and with what permissions? | <pre>object(<br>    {<br>      queue       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_eks_cluster_attributes"></a> [eks\_cluster\_attributes](#input\_eks\_cluster\_attributes) | EKS Cluster attributes to be pulled from EKS module attributes | <pre>object(<br>    {<br>      cluster_oidc_issuer_url = string,<br>      oidc_provider_arn       = string,<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The kubernetes namespace this application will reside in | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the application | `string` | n/a | yes |
| <a name="input_shared_qldb_access"></a> [shared\_qldb\_access](#input\_shared\_qldb\_access) | Which QLDB Ledger does this application need access to? | `string` | n/a | yes |
| <a name="input_shared_rds_access"></a> [shared\_rds\_access](#input\_shared\_rds\_access) | Shared RDS Cluster attributes to give IAM role access to | <pre>object(<br>    {<br>      rds_cluster_name    = string,<br>      rds_cluster_account = string,<br>      rds_cluster_region  = string,<br>      rds_user_name       = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_shared_s3_access"></a> [shared\_s3\_access](#input\_shared\_s3\_access) | What S3 bucket does this applcation need access to, and with what permissions? | <pre>object(<br>    {<br>      bucket       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_shared_sns_access"></a> [shared\_sns\_access](#input\_shared\_sns\_access) | Which SNS topic does this application need access to, and with what permissions? | <pre>object(<br>    {<br>      topic       = string,<br>      permissions = set(string)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_ssm_scopes"></a> [ssm\_scopes](#input\_ssm\_scopes) | What ssm parameter paths should this application have access to? | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | IAM Role created by role producer |
<!-- END_TF_DOCS -->