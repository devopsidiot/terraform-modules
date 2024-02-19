output "iam_role_arn" {
  value       = module.iam_assumable_role_argo_image_updater_ecr.iam_role_arn
  description = "ARN of IRSA role"
}
