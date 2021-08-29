variable "vpc_id" {
  description = "VPC of requesting account, e.g., spoke network that is connecting to VPN."
}
variable "peer_vpc_id" {
  description = "VPC of accepter account, e.g., VPN hub network"
}
variable "tags" {
  type = map(string)
}
variable "destination_cidr_block" {
  description = "CIDR of accepter account, eg., VPN hub network CIDR"
}
variable "peer_owner_id" {
  description = "AWS account ID of accepter accont"
}
variable "cidr" {
  description = "CIDR of requester account, only needed to provide useful output from this module"
}
