variable "vpc_id" {
    description = "VPC ID."
    type        = string
}

variable "vpc_cidr" {
    description = "VPC cidr block."
    type        = string
}

variable "subnet_cidr_blocks_private" {
    description = "Map of private subnet cidr blocks."
    type        = map(string)
    default     = {}
}

variable "subnet_cidr_blocks_public" {
    description = "Map of public subnet cidr blocks."
    type        = map(string)
    default     = {}
}

variable "enable_dns_hostnames" {
    description = "Status flag for DNS hostnames enable."
    type        = bool
    default     = false
}

variable "enable_s3_endpoint" {
    description = "Status flag for s3 endpoint enable."
    type        = bool
    default     = false
}

variable "public_subnet_tags" {
    description = "Map of tags for public subnets."
    type        = map(string)
}

variable "private_subnet_tags" {
    description = "Map of tags for private subnets."
    type        = map(string)
}

variable "tags" {
    description = "Map of tags for VPC."
    type = map(string)
}
