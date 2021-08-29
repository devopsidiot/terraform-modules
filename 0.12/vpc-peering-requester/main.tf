resource "aws_vpc_peering_connection" "pc" {
  vpc_id = var.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  tags = var.tags
}
resource "aws_route" "route" {
  count = length(data.aws_route_tables.rt.ids)
  route_table_id            = element(tolist(data.aws_route_tables.rt.ids), count.index)
  destination_cidr_block    = var.destination_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id
}
data "aws_route_tables" "rt" {
  vpc_id = var.vpc_id
}
