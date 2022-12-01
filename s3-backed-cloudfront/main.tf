data "aws_wafv2_web_acl" "waf_acl" {
  count = var.acl == null ? 0 : 1
  name  = var.acl
  scope = "CLOUDFRONT"
}

data "aws_acm_certificate" "omaze" {
  domain   = "*.${var.public_url}"
  statuses = ["ISSUED"]
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.main.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.main.iam_arn}"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:TlsVersion"

      values = [
        "1.2"
      ]
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "Access Identity for ${var.bucket_name}"
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  website {
    index_document = var.index_document
    error_document = var.error_document
  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_cloudfront_distribution" "main" {
  aliases             = ["${var.service_name}.${var.public_url}"]
  enabled             = true
  default_root_object = var.index_document
  web_acl_id          = var.acl == null ? null : "${data.aws_wafv2_web_acl.waf_acl[0].arn}"

  origin {
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = "S3-${var.bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path
    }
  }

  custom_error_response {
    error_code         = "404"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = "403"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.omaze.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.bucket_name}"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = true

      # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/header-caching.html#header-caching-web-cors
      headers = ["Origin", "Access-Control-Request-Headers", "Access-Control-Request-Method"]

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

data "aws_route53_zone" "domain" {
  name = var.public_url
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.service_name}.${var.public_url}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.main.domain_name
    zone_id                = aws_cloudfront_distribution.main.hosted_zone_id
    evaluate_target_health = false
  }
}
