output "repository_url" {
  value       = aws_ecr_repository.repo.repository_url
  description = "the ECR repository url."
}
output "ecr_arn" {
  value       = aws_ecr_repository.repo.arn
  description = "the ARN of the repository created."
}
output "ecr_name" {
  value       = var.repo_name
  description = "the name of the repository created."
}