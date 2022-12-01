#s3 role attachment
module "iam-role-access-to-created-s3" {
  source       = "git@github.com:omaze-ops/iam-role-access-to-s3.git?ref=v1.0.0"
  count        = var.created_s3_access != null ? 1 : 0
  s3_access   = var.created_s3_access
}

resource "aws_iam_policy" "service-role-created-s3-policy" {
  count       = var.created_s3_access != null ? 1 : 0
  name        = "${var.service_name}-created-s3-policy"
  description = "Policy for ${var.service_name}-role to access s3"
  policy      = module.iam-role-access-to-created-s3[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-created-s3-attach" {
  count      = var.created_s3_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-created-s3-policy[0].arn
}