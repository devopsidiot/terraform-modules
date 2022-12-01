variable "ssm_parameters" {
  type        = map(string)
  description = "A map of key value pairs that will become the keys and values created in SSM."
}
variable "kms_alias" {
  type        = string
  description = "The KMS alias to use when encrypting keys.  The default is the account ssm key."
  default     = "alias/aws/ssm"
}
