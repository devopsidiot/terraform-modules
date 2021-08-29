resource "aws_vpc_peering_connection" "pc" {
  peer_vpc_id   = var.accepter_vpc_id
  vpc_id        = var.requester_vpc_id
  tags          = var.tags
  auto_accept   = true
}

resource "aws_route" "requester" {
  count = length(data.aws_route_tables.requester.ids)
  route_table_id            = element(tolist(data.aws_route_tables.requester.ids), count.index)
  destination_cidr_block    = data.aws_vpc.accepter.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id
}
data "aws_route_tables" "requester" {
  vpc_id = var.requester_vpc_id
}
data "aws_vpc" "requester" {
  id = var.requester_vpc_id
}
data "aws_vpc" "accepter" {
  id = var.accepter_vpc_id
}
resource "aws_route" "accepter" {
  count = length(data.aws_route_tables.accepter.ids)
  route_table_id            = element(tolist(data.aws_route_tables.accepter.ids), count.index)
  destination_cidr_block    = data.aws_vpc.requester.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.pc.id
}
data "aws_route_tables" "accepter" {
  vpc_id = var.accepter_vpc_id
}
