variable "client_cidr" {
  type        = string
  description = "Specify an IP address range, in CIDR notation, from which to assign client IP addresses.  The IP address range cannot overlap with the target network or any of the routes that will be associated with the Client VPN endpoint. The client CIDR range must have a block size that is between /12 and /22 and not overlap with VPC CIDR or any other route in the route table. You cannot change the client CIDR after you create the Client VPN endpoint."
}
variable "name" {
  type        = string
  description = "The name of the vpn to be created.  The name is used in the common name of the certificates that are created as well as the name of the cloudwatch log group that is created."
}
variable "logs_retention" {
  type        = number
  default     = 365
  description = "The log retention of the aws cloudwatch log group created for the vpn in days."
}
variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet ids to associate with the vpn, create routes, and dns resolver endpoints for."
}
variable "vpc_cidr" {
  type        = string
  description = "Specify the IP address range, in CIDR notation, of the VPC the VPN is being created in."
}
variable "default_sg_id" {
  type        = string
  description = "The ID of the security group ( typically the default security group of the vpc ) to apply to the dns endpoints that are created."
}
variable "output_file_path" {
  type        = string
  default     = "devopsidiot-configs"
  description = "the path that will be used, in the users home directory, for local vpn files that are created.  Will be created if necessary."
}
variable "home_dir" {
  type        = string
  default     = "."
  description = "The users home directory. Will be used as the base for the output file path."
}

variable "peered_vpc" {
  type = string
  description = "The peered vpc this client VPN needs access to"
  default = null
}
