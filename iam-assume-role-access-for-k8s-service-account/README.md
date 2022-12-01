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
| [aws_iam_policy_document.iam_assume_role_access_for_k8s_service_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_cluster_attributes"></a> [eks\_cluster\_attributes](#input\_eks\_cluster\_attributes) | EKS Cluster attributes to be pulled from EKS module attributes | <pre>object(<br>    {<br>      cluster_oidc_issuer_url = string,<br>      oidc_provider_arn       = string,<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | What k8s namespace will this service be in? | `string` | `"devopsidiot"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of service that this policy is for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | Policy Document for IAM Assume Role Policy for K8S Service Account |
<!-- END_TF_DOCS -->