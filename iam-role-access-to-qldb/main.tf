data "aws_qldb_ledger" "qldb_ledger_to_access" {
  name = var.qldb_ledger_access
}

data "aws_iam_policy_document" "iam_role_access_to_qldb" {
  statement {
    actions = [
      "qldb:ExecuteStatement",
      "qldb:GetRevision",
      "qldb:GetDigest",
      "qldb:GetBlock",
      "qldb:SendCommand"
    ]

    resources = [
      data.aws_qldb_ledger.qldb_ledger_to_access.arn
    ]
  }
}