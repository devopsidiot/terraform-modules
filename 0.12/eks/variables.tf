variable "subnet_ids" {
  type = list(string)
}
variable "vpc_id" {
}
variable "instance_type" {
  type    = string
  default = ""
}
variable "asg_min_size" {
  type    = string
  default = ""
}
variable "asg_max_size" {
  type    = string
  default = ""
}
variable "tags" {
  type = map(string)
}
variable "name" {
}
variable "cluster_endpoint_public_access" {
  type = bool
}
variable "cluster_endpoint_private_access" {
  type = bool
}
variable "cluster_enabled_log_types" {
  type    = list
  default = []
}
variable "cluster_log_retention_in_days" {
  default = "90"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}
variable "node_groups_defaults" {
  type = any
}
variable "node_groups" {
  type = any
}
variable "workers_additional_policies" {
  type = list(string)
}
variable "kubeconfig_aws_authenticator_additional_args" {
  type = list
  default = []
}
variable "cluster_version" {
  type    = string
  default = ""
}
variable "kubeconfig_file" {
  # e.g., kubeconfigfile = "${get_terragrunt_dir()}/kubeconfig"
  description = "Save kubeconfig file. In terragrunt.hcl, use get_terragrunt_dir() to reference same directory as that file."
}
variable "enable_irsa" {
  type = bool
  default = true
}
variable "cluster_endpoint_private_access_cidrs" {
  type = list(string)
}
