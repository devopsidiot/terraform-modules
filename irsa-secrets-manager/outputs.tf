output "iam_role_arn" {
  value       = module.iam_assumable_role_secretsmanager.iam_role_arn
  description = "ARN of IRSA role"
}
