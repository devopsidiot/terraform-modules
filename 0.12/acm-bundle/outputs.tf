output "arns" {
  value = ["${aws_acm_certificate.cert.*.arn}"]
}
