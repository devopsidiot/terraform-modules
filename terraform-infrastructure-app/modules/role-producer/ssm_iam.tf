#SSM role attachment
module "iam-role-access-to-service-ssm" {
  source       = "git@github.com:devopsidiot-ops/iam-role-access-to-service-ssm.git?ref=v1.0.0"
  count        = var.ssm_scopes != null ? 1 : 0
  ssm_scopes   = var.ssm_scopes
}

resource "aws_iam_policy" "service-role-ssm-policy" {
  count       = var.ssm_scopes != null ? 1 : 0
  name        = "${var.service_name}-ssm-policy"
  description = "Policy for ${var.service_name}-role to access ssm"
  policy      = module.iam-role-access-to-service-ssm[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-ssm-attach" {
  count      = var.ssm_scopes != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-ssm-policy[0].arn
}
