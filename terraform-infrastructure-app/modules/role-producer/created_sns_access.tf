#SNS role attachment
module "iam-role-access-to-created-sns" {
  source       = "git@github.com:devopsidiot-ops/iam-role-access-to-sns.git?ref=v1.0.0"
  count        = var.created_sns_access != null ? length(var.created_sns_access) : 0
  sns_access   = {
    "topic" = var.created_sns_access[count.index],
    permissions = [
      "sns:Publish"
    ]
  }
}

resource "aws_iam_policy" "service-role-created-sns-policy" {
  count       = var.created_sns_access != null ? length(var.created_sns_access) : 0
  name        = "${var.service_name}-created-sns-${var.created_sns_access[count.index]}-policy"
  description = "Policy for ${var.service_name}-role to access sns ${var.created_sns_access[count.index]}"
  policy      = module.iam-role-access-to-created-sns[count.index].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-created-sns-attach" {
  count      = var.created_sns_access != null ? length(var.created_sns_access) : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-created-sns-policy[count.index].arn
}