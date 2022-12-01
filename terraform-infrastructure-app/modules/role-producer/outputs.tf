output "iam_role_name" {
  value       = aws_iam_role.service-role.name
  description = "IAM Role created by role producer"
}
