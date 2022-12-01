output "policy_document" {
  value       = data.aws_iam_policy_document.iam_assume_role_access_for_k8s_service_account.json
  description = "Policy Document for IAM Assume Role Policy for K8S Service Account"
}
