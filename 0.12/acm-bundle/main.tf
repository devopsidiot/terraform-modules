/*******
Note: re-applying will always force recreate certs and DV entries, as there is
a bug in the provider that returns both SANS and domain_validation_options in
a different order each time. The latter is handled in this configuration but
SANS are not. There is a solution in the works:
https://github.com/terraform-providers/terraform-provider-aws/issues/8531
*/
locals {
  max_san = var.max_san
  domains_chunks = var.domains_chunks
}

# Generate cert requests
resource "aws_acm_certificate" "cert" {
  count       = length(local.domains_chunks)
  domain_name = local.domains_chunks[count.index][0]
  subject_alternative_names = slice(local.domains_chunks[count.index], 1, length(local.domains_chunks[count.index]))
  validation_method         = "DNS"
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "zone" {
  count        = length(var.domains)
  name         = "${regex("[^.]+\\.[^.]+$", var.domains[count.index])}."
  private_zone = false
}

resource "aws_route53_record" "dv" {
  count = length(var.domains)

  # Change this to for / for_each
  name = aws_acm_certificate.cert[floor(count.index / local.max_san)].domain_validation_options[count.index % local.max_san].resource_record_name
  type = aws_acm_certificate.cert[floor(count.index / local.max_san)].domain_validation_options[count.index % local.max_san].resource_record_type
  # This doesn't work because of bug https://github.com/terraform-providers/terraform-provider-aws/issues/8531
  #zone_id = data.aws_route53_zone.zone[count.index].zone_id
  # Hence the nastiness that follows:
  zone_id         = data.aws_route53_zone.zone[index(data.aws_route53_zone.zone.*.name, "${regex("[^.]+\\.[^.]+$", aws_acm_certificate.cert[floor(count.index / local.max_san)].domain_validation_options[count.index % local.max_san].domain_name)}.")].zone_id
  records         = [aws_acm_certificate.cert[floor(count.index / local.max_san)].domain_validation_options[count.index % local.max_san].resource_record_value]
  ttl             = 60
  allow_overwrite = true

}

# Validate zones
resource "aws_acm_certificate_validation" "cert" {
  count           = length(local.domains_chunks)
  certificate_arn = aws_acm_certificate.cert[count.index].arn

  validation_record_fqdns = [
    for record in slice(aws_route53_record.dv, (count.index * local.max_san), min(((count.index + 1) * local.max_san), length(aws_route53_record.dv))) :
    record.fqdn
  ]
}
