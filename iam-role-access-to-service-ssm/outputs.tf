output "policy_document" {
  value       = module.IAM_role_access_to_service_ssm.result_document
  description = "Policy Document for IAM Role usage by K8S Service Account"
}
