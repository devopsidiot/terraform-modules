# Shared RDS role attachment
module "iam-role-access-to-shared-rds" {
  source             = "git@github.com:devopsidiot-ops/iam-role-access-to-rds.git?ref=v1.0.0"
  count              = var.shared_rds_access != null ? 1 : 0
  rds_cluster_access = var.shared_rds_access
}

resource "aws_iam_policy" "service-role-shared-rds-policy" {
  count       = var.shared_rds_access != null ? 1 : 0
  name        = "${var.service_name}-shared-rds-policy"
  description = "Policy for ${var.service_name}-role to access rds"
  policy      = module.iam-role-access-to-shared-rds[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-shared-rds-attach" {
  count      = var.shared_rds_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-shared-rds-policy[0].arn
}
