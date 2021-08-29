variable "name" {
}
variable "vpc_id" {
}
variable "subnets" {
  type = list
}
variable "allowed_cidr_blocks" {
  type = list
}
variable "tags" {
  type = map
}
variable "snapshot_identifier" {
  default = ""
}
variable "username" {
}
variable "password" {
  default = ""
}
variable "allowed_security_groups" {
  type = list
}
variable "instance_type" {
}
variable "replica_count" {
}
variable "engine" {
  default = "aurora-postgresql"
}
variable "engine_version" {
  default = "10.12"
}
variable "db_parameters" {
  description = "List containing map of parameters to apply"
  type        = list(map(any))
  default     = []
}
variable "cluster_parameters" {
  description = "List containing map of parameters to apply"
  type        = list(map(any))
  default     = []
}
variable "family" {
  default ="aurora-postgresql10"
}
variable "iam_database_authentication_enabled" {
  type    = bool
  default = true
}
variable "storage_encrypted" {
  type    = bool
  default = true
}
variable "create_random_password" {
  type        = bool
  default     = false
  description = "If set to true, 'password' var will be ignored"
}
