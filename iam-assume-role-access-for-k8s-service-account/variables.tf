variable "namespace" {
  type        = string
  default     = "devopsidiot"
  description = "What k8s namespace will this service be in?"
}

variable "service_name" {
  type        = string
  description = "Name of service that this policy is for"
}

variable "eks_cluster_attributes" {
  type = object(
    {
      cluster_oidc_issuer_url = string,
      oidc_provider_arn       = string,
    }
  )
  description = "EKS Cluster attributes to be pulled from EKS module attributes"
}
