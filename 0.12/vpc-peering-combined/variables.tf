variable "requester_vpc_id" {
  description = "VPC of requesting vpc"
}
variable "accepter_vpc_id" {
  description = "VPC of accepter, e.g., VPN hub network"
}
variable "tags" {
  type = map(string)
}
