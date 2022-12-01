output "policy_document" {
  value       = data.aws_iam_policy_document.iam_role_access_to_sns.json
  description = "Policy Document for IAM Role usage by K8S Service Account"
}
