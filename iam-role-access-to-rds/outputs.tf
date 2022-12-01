output "policy_document" {
  value       = data.aws_iam_policy_document.iam_role_access_to_rds.json
  description = "Policy Document for IAM Role access to RDS User"
}
