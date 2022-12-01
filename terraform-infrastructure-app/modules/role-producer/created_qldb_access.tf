module "iam-role-access-to-created-qldb" {
  source             = "git@github.com:omaze-ops/iam-role-access-to-qldb.git?ref=v1.0.0"
  count              = var.created_qldb_access != null ? 1 : 0
  qldb_ledger_access = var.created_qldb_access
}

resource "aws_iam_policy" "service-role-created-qldb-policy" {
  count       = var.created_qldb_access != null ? 1 : 0
  name        = "${var.service_name}-created-qldb-policy"
  description = "Policy for ${var.service_name}-role to access qldb"
  policy      = module.iam-role-access-to-created-qldb[0].policy_document
}

resource "aws_iam_role_policy_attachment" "service-role-created-qldb-attach" {
  count      = var.created_qldb_access != null ? 1 : 0
  role       = aws_iam_role.service-role.name
  policy_arn = aws_iam_policy.service-role-created-qldb-policy[0].arn
}