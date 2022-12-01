variable "name" {
  type        = string
  description = "Name of redis cluster"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zone IDs"
}

variable "zone_name" {
  type        = string
  description = "Route53 DNS Zone Name"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC this will be deployed in"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs to deploy cluster in."
}

variable "cluster_size" {
  type        = number
  description = "Number of nodes in cluster"
}

variable "instance_type" {
  type        = string
  description = "Elastic cache instance type"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for the host VPC"
}
