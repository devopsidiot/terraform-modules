variable "secret_arns" {
  description = "A list of ARNs for the AWS Secrets Manager secrets"
  type        = list(string)
}

variable "oidc_provider_url" {
  type = string
}
