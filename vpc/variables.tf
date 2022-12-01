variable "vpc_name" {
  type        = string
  description = "Name of the vpc that will be created."
  default     = "omaze-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR to use for creating vpc."
  default     = "10.0.0.0/16"
}

variable "infra_newbits" {
  type        = number
  description = "Number of bits to add to cidr when subdividing subnets."
  default     = 7
}

variable "private_newbits" {
  type        = number
  description = "Number of bits to add to cidr when subdividing subnets."
  default     = 5
}

variable "vpc_azs" {
  type        = list(string)
  description = "List of AZ's to use "
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

locals {
  #variables for adding clarity in the main cidr creation block
  first_half_of_cidr  = cidrsubnet(var.vpc_cidr, 1, 0) #half the cidr. in the case of /16 : 10.x.0.1 to 10.x.127.254
  second_half_of_cidr = cidrsubnet(var.vpc_cidr, 1, 1) #half the cidr. in the case of /16 : 10.x.128.1 to 10.x.255.254
}
