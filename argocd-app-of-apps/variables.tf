variable "argo_environment" {
  type        = string
  default     = "rnd"
  description = "Environment name that points to the ingress for the argocd server - example: argo.rnd.glorify-appdev.com"
}
variable "argo_initial_username" {
  type        = string
  default     = "admin"
  description = "Initial admin user that is generated when argo is created by flux"
}
variable "argo_initial_password" {
  type        = string
  default     = "password"
  description = "Initial password that is generated when argo is created by flux - get this by initially going into the cluster and typing argocd admin initial-password -n argo"
}
variable "workloads_directory" {
  type        = string
  default     = "workloads/"
  description = "Where app of app pattern base application.yaml is deployed"
}
variable "githubapp_id" {
  type    = string
  default = "glorify-bots"
}
variable "github_ssh" {
  type    = string
  default = "ssh"
}
