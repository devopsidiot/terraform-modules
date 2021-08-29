output "requester_peering_connection_id" {
  value = aws_vpc_peering_connection.pc.id
}
output "requester_cidr" {
  value = var.cidr
}
