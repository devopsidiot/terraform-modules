#sqs role attachment
module "iam-role-access-to-created-sqs" {
  source       = "git@github.com:devopsidiot-ops/iam-role-access-to-sqs.git?ref=v1.0.0"
  count        = var.created_sqs_access != null ? 1 : 0
  sqs_access   = var.created_sqs_access
}

resource "aws_iam_policy" "service-role-created-sqs-policy" {
  count       = var.created_sqs_access != null ? 1 : 0
  name        = "${var.service_name}-created-sqs-policy"
  description = "Policy for ${var.service_name}-role to access sqs"
  policy      = module.iam-role-access-to-created-sqs[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-created-sqs-attach" {
  count      = var.created_sqs_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-created-sqs-policy[0].arn
}