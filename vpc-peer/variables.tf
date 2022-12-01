variable "vpc_peering_name" {
  type        = string
  description = "The name of the vpc peering connection being created."
}
variable "requestor_vpc_id" {
  type        = string
  description = "The VPC ID that is originating the peering request."
}
variable "acceptor_vpc_id" {
  type        = string
  description = "The VPC ID that is receiving the peering request."
}
