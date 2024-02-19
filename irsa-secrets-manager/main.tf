# I hate that I have to do this
terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    newrelic = { source = "newrelic/newrelic" }
  }
}

data "aws_iam_policy_document" "secretsmanager" {
  dynamic "statement" {
    for_each = var.secret_arns

    content {
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [statement.value]
    }
  }
}

resource "aws_iam_policy" "secretsmanager" {
  name        = "${var.environment}-secrets-managager-policy"
  description = "${var.environment}-secrets-managager-policy"
  policy      = data.aws_iam_policy_document.secretsmanager.json
}

module "iam_assumable_role_secretsmanager" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "4.7.0"
  create_role                   = true
  role_name                     = "${var.environment}-secrets-manager-role"
  provider_url                  = var.oidc_provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:external-secrets:external-secrets"]
  role_policy_arns              = [aws_iam_policy.secretsmanager.arn]
}
