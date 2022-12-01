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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.repo](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Name of the ecr repository to be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_arn"></a> [ecr\_arn](#output\_ecr\_arn) | the ARN of the repository created. |
| <a name="output_ecr_name"></a> [ecr\_name](#output\_ecr\_name) | the name of the repository created. |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | the ECR repository url. |
<!-- END_TF_DOCS -->