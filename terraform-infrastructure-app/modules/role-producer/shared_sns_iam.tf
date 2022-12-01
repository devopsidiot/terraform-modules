#SNS role attachment
module "iam-role-access-to-shared-sns" {
  source       = "git@github.com:devopsidiot-ops/iam-role-access-to-sns.git?ref=v1.0.0"
  count        = var.shared_sns_access != null ? 1 : 0
  sns_access   = var.shared_sns_access
}

resource "aws_iam_policy" "service-role-shared-sns-policy" {
  count       = var.shared_sns_access != null ? 1 : 0
  name        = "${var.service_name}-shared-sns-policy"
  description = "Policy for ${var.service_name}-role to access sns"
  policy      = module.iam-role-access-to-shared-sns[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-shared-sns-attach" {
  count      = var.shared_sns_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-shared-sns-policy[0].arn
}
