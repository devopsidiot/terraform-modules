resource "aws_route53_zone" "zone" {
  name = var.zone_name
  tags = var.tags
}
resource "aws_route53_record" "records" {
  for_each = var.records
    zone_id = aws_route53_zone.zone.zone_id
    name    = "${each.value.prefix}.${var.zone_name}"
    type    = each.value.type
    ttl     = each.value.ttl
    records = each.value.records
}
