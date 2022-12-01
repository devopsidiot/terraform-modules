# S3 Bucket

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.main.bucket_domain_name
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_region" {
  value = aws_s3_bucket.main.region
}

output "website_endpoint" {
  value = aws_s3_bucket.main.website_endpoint
}

output "website_domain" {
  value = aws_s3_bucket.main.website_domain
}

# Route53 Record

output "record_name" {
  value = aws_route53_record.main.name
}

output "record_fqdn" {
  value = aws_route53_record.main.fqdn
}

# CloudFront Distribution
output "distribution_id" {
  value = aws_cloudfront_distribution.main.id
}

output "distribution_arn" {
  value = aws_cloudfront_distribution.main.arn
}

output "distribution_caller_reference" {
  value = aws_cloudfront_distribution.main.caller_reference
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "distribution_etag" {
  value = aws_cloudfront_distribution.main.etag
}

output "distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}
