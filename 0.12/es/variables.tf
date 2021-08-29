variable "policy" {
  default = ""
}
variable "allow_open_access" {
  type        = bool
  default     = false
  description = "If true, policy will be overridden with permissive policy."
}
variable "tags" {
  type = map(string)
}
variable "vpc_id" {}
variable "allowed_cidr_blocks" {
  type = list(string)
}
variable "advanced_options" {
  type = map(string)
  default = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
  description = "This must be set or plan changes every time"
}
variable "kibana_subdomain_name" {
  default     = ""
  description = "This has to be set or cloudposse module complains"
}
variable "subnet_ids" {
  type        = list(string)
  description = "If left empty, module will use first 3 subnets in VPC, per AWS recommendations at https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains-multiaz.html"
  default     = []
}
variable "security_groups" {
  type = list(string)
}
variable "name" {}
variable "elasticsearch_version" {}
variable "create_iam_service_linked_role" {
  type    = bool
  default = false
}
variable "instance_type" {}
variable "ebs_volume_size" {}
variable "zone_awareness_enabled" {
  type    = bool
  default = true
}
variable "instance_count" {
  default = 3
}
variable "availability_zone_count" {
  default = 3
}
variable "encrypt_at_rest_enabled" {
  type    = bool
  default = true
}
variable "domain_endpoint_options_enforce_https" {
  type    = bool
  default = true
}
variable "private_subnets" {
  type    = list(string)
  default = []
}
# Not yet used
variable "multi_az" {
  type    = bool
  default = false
}
variable "dedicated_master_count" {
  default = 0
}
variable "dedicated_master_enabled" {
  type    = bool
  default = false
}
variable "dedicated_master_type" {
  default = "t2.small.elasticsearch"
}
