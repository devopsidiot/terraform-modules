resource "aws_route" "route" {
  count = length(data.aws_route_tables.rt.ids)
  route_table_id            = element(tolist(data.aws_route_tables.rt.ids), count.index)
  destination_cidr_block    = var.destination_cidr_block
  vpc_peering_connection_id = var.peering_connection_id
}
data "aws_route_tables" "rt" {
  vpc_id = var.vpc_id
}
resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = var.peering_connection_id
  auto_accept               = true

  tags = var.tags
}
