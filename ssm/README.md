## Usage

```terraform
module "ssm" {
    source = "git::git@github.com:omaze/terraform-modules.git//ssm"
    environment = 
    region = 
    ssm_parameters = {

        "/vendor/github/user" = "omaze_cicd",
        "/vendor/github/pass" = "placeholder"
    }
}
```

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
| [aws_ssm_parameter.parameters](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/resources/ssm_parameter) | resource |
| [aws_kms_alias.kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.47.0/docs/data-sources/kms_alias) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment that the module is being invoked within.  This is used for setting up the provider. | `string` | n/a | yes |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | The KMS alias to use when encrypting keys.  The default is the account ssm key. | `string` | `"alias/aws/ssm"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region that the AWS provider will use. | `string` | n/a | yes |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | A map of key value pairs that will become the keys and values created in SSM. | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->