<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.47.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.47.0, < 4.0.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.sops_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.sops_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [local_file.decrypt_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.encrypt_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.gitignore](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.shared-parameters](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.sops_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_iam_policy_document.sops_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_decrypt_script"></a> [decrypt\_script](#input\_decrypt\_script) | The script used to decrypt the shared-parameters.yaml for humans to edit | `any` | n/a | yes |
| <a name="input_encrypt_script"></a> [encrypt\_script](#input\_encrypt\_script) | The script used to encrypt the shared-parameters.yaml so terragrunt can apply secrets | `any` | n/a | yes |
| <a name="input_gitignore"></a> [gitignore](#input\_gitignore) | .gitignore to make sure that decrypted secrets aren't committed to git | `any` | n/a | yes |
| <a name="input_shared_parameters_yaml"></a> [shared\_parameters\_yaml](#input\_shared\_parameters\_yaml) | shared-parameters.decrypted.yaml script used to hold secrets | `any` | n/a | yes |
| <a name="input_sops_file"></a> [sops\_file](#input\_sops\_file) | The .sops.yaml file that SOPS uses to encrypt/decrypt the things | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->