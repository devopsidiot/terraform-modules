resource "aws_eip" "eip" {
  count    = var.num_eips
  instance = var.instance_id
  vpc      = var.vpc
  tags     = var.tags
}
