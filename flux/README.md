<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | >= 0.0.13, < 0.12.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.10.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_flux"></a> [flux](#provider\_flux) | >= 0.0.13, < 0.12.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.10.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [flux_install.main](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/install) | data source |
| [flux_sync.main](https://registry.terraform.io/providers/fluxcd/flux/latest/docs/data-sources/sync) | data source |
| [kubectl_file_documents.install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_admin_role"></a> [cluster\_admin\_role](#input\_cluster\_admin\_role) | ARN of the role to assume when acquiring an EKS token for authentication. | `string` | n/a | yes |
| <a name="input_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#input\_cluster\_certificate\_authority\_data) | Base64 encoded CA certificate to use for EKS cluster authentication. | `string` | n/a | yes |
| <a name="input_cluster_endpoint"></a> [cluster\_endpoint](#input\_cluster\_endpoint) | The cluster endpoint of the eks cluster to use when setting up the kubectl and kubernetes providers for flux. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the eks cluster to use when setting up iam-authenticator in kubectl and kubernetes providers. | `string` | n/a | yes |
| <a name="input_flux_branch"></a> [flux\_branch](#input\_flux\_branch) | The branch to use when syncing the flux repository. | `string` | `"integration"` | no |
| <a name="input_flux_token"></a> [flux\_token](#input\_flux\_token) | The github personal access token to use for syncing the initial flux repo.  This is set to a placeholder and manually set.  The secret can be found in 1password. | `string` | `"entertokenhere"` | no |
| <a name="input_flux_version"></a> [flux\_version](#input\_flux\_version) | Version of flux2 to deploy | `string` | `"v0.13.1"` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Github account name or organization to sync repo(s) from. | `string` | `"devopsidiot"` | no |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | The github account to use for pulling down / syncing repos.  The flux\_token should be this accounts PAT. | `string` | `"devopsidiot-cicd"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of github repository to setup initial flux sync with. | `string` | `"flux2"` | no |
| <a name="input_target_path"></a> [target\_path](#input\_target\_path) | The filepath in repository\_name to set as the target for flux sync and reconciliation.  This is typically clusters/$ENVIRONMENT. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->