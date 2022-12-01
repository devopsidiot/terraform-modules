<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.47.0, < 4.0.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.47.0, < 4.0.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.10.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 17.0 |
| <a name="module_iam_assumable_role_karpenter"></a> [iam\_assumable\_role\_karpenter](#module\_iam\_assumable\_role\_karpenter) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |
| <a name="module_sops_iam_role"></a> [sops\_iam\_role](#module\_sops\_iam\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | 4.7.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ec2_tag.private_subnet_cluster_karpenter_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.private_subnet_cluster_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.private_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.public_subnet_cluster_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.public_subnet_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.vpc_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_eks_addon.eks_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_instance_profile.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.AWSLoadBalancerControllerIAMPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ClusterAutoscalerIAMPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.EKSExternalDNSPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.EKSExternalSecretsPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.sops_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.karpenter_ssm_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_service_linked_role.awsserviceroleforec2spot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_key_pair.eks_node_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.sops_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.envelope_encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.sops_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket_object.kube_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_object.node_key_priv](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_object.node_key_pub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.karpenter](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.node_group_transition](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [local_file.decrypt_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.encrypt_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.gitignore](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.shared-parameters](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.sops_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.eks_node_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy.ec2_registry_ro](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ssm_managed_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.AWSLoadBalancerControllerIAMPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ClusterAutoscalerIAMPolicy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.EKSExternalDNS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.EKSExternalSecrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sops_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sops_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_kms_alias.kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kms_alias) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the eks cluster to be created.  Also used in the filepath of the generated kubeconfigs, as well as some tags. | `string` | `"devopsidiot-eks"` | no |
| <a name="input_decrypt_script"></a> [decrypt\_script](#input\_decrypt\_script) | The script used to decrypt the shared-parameters.yaml for humans to edit | `any` | n/a | yes |
| <a name="input_default_sg_id"></a> [default\_sg\_id](#input\_default\_sg\_id) | Default security group to apply to cluster nodes. | `string` | n/a | yes |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Version of kubernetes to deploy.  Must be in the list of supported versions | `string` | `"1.21"` | no |
| <a name="input_encrypt_script"></a> [encrypt\_script](#input\_encrypt\_script) | The script used to encrypt the shared-parameters.yaml so terragrunt can apply secrets | `any` | n/a | yes |
| <a name="input_gitignore"></a> [gitignore](#input\_gitignore) | .gitignore to make sure that decrypted secrets aren't committed to git | `any` | n/a | yes |
| <a name="input_home_dir"></a> [home\_dir](#input\_home\_dir) | The users home directory. Will be used as the base for the output file path. | `string` | `"."` | no |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | Access to this KMS will be granted to the eks cluster created with the intent of pulling in secrets stored within SSM. | `string` | `"alias/aws/ssm"` | no |
| <a name="input_kubeconfig_role"></a> [kubeconfig\_role](#input\_kubeconfig\_role) | AWS Role to write to the kubeconfig to be used by iam-authenticator for retrieving an EKS auth token. | `string` | n/a | yes |
| <a name="input_map_accounts"></a> [map\_accounts](#input\_map\_accounts) | Additional AWS account numbers to add to the aws-auth configmap. | `list(string)` | `[]` | no |
| <a name="input_map_roles"></a> [map\_roles](#input\_map\_roles) | Additional IAM roles to add to the aws-auth configmap. | <pre>list(object({<br>    rolearn  = string<br>    username = string<br>  groups = list(string) }))</pre> | `[]` | no |
| <a name="input_map_users"></a> [map\_users](#input\_map\_users) | Additional IAM users to add to the aws-auth configmap. | <pre>list(object({<br>    userarn  = string<br>    username = string<br>  groups = list(string) }))</pre> | `[]` | no |
| <a name="input_output_file_path"></a> [output\_file\_path](#input\_output\_file\_path) | the path that will be used, in the users home directory, for local kubeconfig files that are created.  Will be created if necessary. | `string` | `"devopsidiot-configs"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets to use when spinning up EKS cluster resources. | `list(string)` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets to use when spinning up EKS cluster resources. | `list(string)` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of SSM secret arns to allow the EKS cluster to pull secrets from.  The key should be the name of the path being allowed and the value should be the ARN.  The ARN can contain wildcards. | `map(string)` | n/a | yes |
| <a name="input_shared_parameters_yaml"></a> [shared\_parameters\_yaml](#input\_shared\_parameters\_yaml) | shared-parameters.decrypted.yaml script used to hold secrets | `any` | n/a | yes |
| <a name="input_sops_file"></a> [sops\_file](#input\_sops\_file) | The .sops.yaml file that SOPS uses to encrypt/decrypt the things | `any` | n/a | yes |
| <a name="input_use_spot_karpenter"></a> [use\_spot\_karpenter](#input\_use\_spot\_karpenter) | Allow using spot instances for Karpenter provisioned nodes | `bool` | `false` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | Specify an IP address range, in CIDR notation, that describes the VPC the cluster will live in. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC the EKS cluster will live in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_admin_role"></a> [cluster\_admin\_role](#output\_cluster\_admin\_role) | the role that needs to be assumed to acquire an EKS authentication token for use with iam-authenticator. |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane. |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | the ID of the EKS cluster created. |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | Issuer URL of the oidc provider created for EKS. |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group ids attached to the cluster control plane. |
| <a name="output_config_map_aws_auth"></a> [config\_map\_aws\_auth](#output\_config\_map\_aws\_auth) | A kubernetes configuration to authenticate to this EKS cluster. |
| <a name="output_kubectl_config"></a> [kubectl\_config](#output\_kubectl\_config) | kubectl config as generated by the module. |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | ARN of the oidc provider created for EKS. |
<!-- END_TF_DOCS -->