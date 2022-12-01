#s3 role attachment
module "iam-role-access-to-shared-s3" {
  source       = "git@github.com:devopsidiot-ops/iam-role-access-to-s3.git?ref=v1.0.0"
  count        = var.shared_s3_access != null ? 1 : 0
  s3_access   = var.shared_s3_access
}

resource "aws_iam_policy" "service-role-shared-s3-policy" {
  count       = var.shared_s3_access != null ? 1 : 0
  name        = "${var.service_name}-shared-s3-policy"
  description = "Policy for ${var.service_name}-role to access s3"
  policy      = module.iam-role-access-to-shared-s3[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-shared-s3-attach" {
  count      = var.shared_s3_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-shared-s3-policy[0].arn
}