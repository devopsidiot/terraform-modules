#NOTHING here will ever be used - ever
#Needed for validation - don't remove
variable "environment" {
  type = string
  default = "local"
}
variable "region" {
  type = string
  default = "us-east-1"
}
variable "account_id" {
  type = string
  default = "111111111111"
}