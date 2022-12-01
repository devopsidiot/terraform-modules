variable "github_owner" {
  type        = string
  default     = "devopsidiot"
  description = "Github account name or organization to sync repo(s) from."
}
variable "repository_name" {
  type        = string
  default     = "flux2"
  description = "Name of github repository to setup initial flux sync with."
}
variable "flux_token" {
  type        = string
  default     = "entertokenhere"
  description = "The github personal access token to use for syncing the initial flux repo.  This is set to a placeholder and manually set.  The secret can be found in 1password."
}
variable "flux_branch" {
  type        = string
  default     = "integration"
  description = "The branch to use when syncing the flux repository."
}
variable "github_user" {
  type        = string
  default     = "devopsidiot-cicd"
  description = "The github account to use for pulling down / syncing repos.  The flux_token should be this accounts PAT."
}
variable "flux_version" {
  type        = string
  default     = "v0.13.1"
  description = "Version of flux2 to deploy"
}
variable "target_path" {
  type        = string
  description = "The filepath in repository_name to set as the target for flux sync and reconciliation.  This is typically clusters/$ENVIRONMENT."
}
variable "cluster_name" {
  type        = string
  description = "Name of the eks cluster to use when setting up iam-authenticator in kubectl and kubernetes providers."
}
variable "cluster_admin_role" {
  type        = string
  description = "ARN of the role to assume when acquiring an EKS token for authentication."
}
variable "cluster_endpoint" {
  type        = string
  description = "The cluster endpoint of the eks cluster to use when setting up the kubectl and kubernetes providers for flux."
}
variable "cluster_certificate_authority_data" {
  type        = string
  description = "Base64 encoded CA certificate to use for EKS cluster authentication."
}