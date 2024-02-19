variable "eks_cluster_version" {
  type        = string
  default     = "1.26"
  description = "Version of kubernetes to deploy.  Must be in the list of supported versions"
}
variable "map_accounts" {
  type        = list(string)
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  default     = []
}
variable "map_roles" {
  type = list(object({
    rolearn  = string
    username = string
  groups = list(string) }))
  default     = []
  description = "Additional IAM roles to add to the aws-auth configmap."
}
variable "map_users" {
  type = list(object({
    userarn  = string
    username = string
  groups = list(string) }))
  default     = []
  description = "Additional IAM users to add to the aws-auth configmap."
}
variable "kms_alias" {
  type        = string
  default     = "alias/aws/ssm"
  description = "Access to this KMS will be granted to the eks cluster created with the intent of pulling in secrets stored within SSM."
}
variable "kubeconfig_role" {
  type        = string
  description = "AWS Role to write to the kubeconfig to be used by iam-authenticator for retrieving an EKS auth token."
}
variable "cluster_name" {
  type        = string
  default     = "devopsidiot-eks"
  description = "The name of the eks cluster to be created.  Also used in the filepath of the generated kubeconfigs, as well as some tags."
}

variable "secrets" {
  type        = map(string)
  description = "A map of SSM secret arns to allow the EKS cluster to pull secrets from.  The key should be the name of the path being allowed and the value should be the ARN.  The ARN can contain wildcards."
}
variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets to use when spinning up EKS cluster resources."
}
variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets to use when spinning up EKS cluster resources."

}
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC the EKS cluster will live in."
}
variable "default_sg_id" {
  type        = string
  description = "Default security group to apply to cluster nodes."
}
variable "vpc_cidr" {
  type        = string
  description = "Specify an IP address range, in CIDR notation, that describes the VPC the cluster will live in."
}
variable "output_file_path" {
  type        = string
  default     = "devopsidiot-configs"
  description = "the path that will be used, in the users home directory, for local kubeconfig files that are created.  Will be created if necessary."
}
variable "home_dir" {
  type        = string
  default     = "."
  description = "The users home directory. Will be used as the base for the output file path."
}
variable "sops_file" {
  description = "The .sops.yaml file that SOPS uses to encrypt/decrypt the things"
}
variable "decrypt_script" {
  description = "The script used to decrypt the shared-parameters.yaml for humans to edit"
}
variable "encrypt_script" {
  description = "The script used to encrypt the shared-parameters.yaml so terragrunt can apply secrets"
}
variable "shared_parameters_yaml" {
  description = "shared-parameters.decrypted.yaml script used to hold secrets"
}
variable "gitignore" {
  description = ".gitignore to make sure that decrypted secrets aren't committed to git"
}
variable "use_spot_karpenter" {
  description = "Allow using spot instances for Karpenter provisioned nodes"
  type        = bool
  default     = true
}

variable "api_namespaces" {
  type        = list(string)
  description = "Kubernetes namespaces to be managed by Fargate"
  default     = []
}
# Uncomment below variables if using fargate.tf to create fargate profile
# variable "fargate_namespaces" {
#   type        = list(string)
#   description = "Kubernetes namespaces to be managed by Fargate"
#   default     = []
# }
# variable "fargateprofile_name" {
#   type        = string
#   default     = "default-fargateprofile"
#   description = "The name of the fargateprofile be created."
# }
# Below variable is not need if using fargate.tf instead
# variable "fargate_selectors" {
#   type        = list(object({
#     namespace = string
#   }))
#   description = "Kubernetes namespaces to be managed by Fargate"
#   default     = []
# }
